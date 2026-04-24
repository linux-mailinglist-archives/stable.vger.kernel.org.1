Return-Path: <stable+bounces-240682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gESAKdxx62ndMwAAu9opvQ
	(envelope-from <stable+bounces-240682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:36:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F108445F33F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA2A5304C134
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82197260566;
	Fri, 24 Apr 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hUiArOac"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC778F4A;
	Fri, 24 Apr 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037567; cv=none; b=RiG1e7O3fD2BQ3l01Yd2ROdjXOCkbnUGp23YrHEDDskowkfgahE250XzSB7ncmQoUJ0TQA26ypaSOk6hnA1kx2lGjuw3vfM6XT5CgqV0HLmdrkbiOqGm8ATF4+pcZ8mBocPUnG3Kcui9pittr1SJX6mEkudPFbzS+wutOZHEeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037567; c=relaxed/simple;
	bh=Qk/FM7q16BYdZXW4o94Gs9nsQQ+5tPogJJxCALTfLTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=No5rkCv8OpkCvBelac7/BpW9uCZkSo1RrVZSCfz8ImKxxHtiNwkEZ2iruvWVjMh3DHOg9JHgcSebvSNbCG/QtQRauRmdieDzTZJ4S061S2j26LgEWq/n7UdoW2qe286ZdEsphAJUj7OVzpeQEBesT27JR4XzVd+yCMUloefIumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hUiArOac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B41C19425;
	Fri, 24 Apr 2026 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037567;
	bh=Qk/FM7q16BYdZXW4o94Gs9nsQQ+5tPogJJxCALTfLTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUiArOacffVa21IWEJ/R4+FKrDcs+do/+TrnSRBgg2YIXIqFz58rj3KFqz0fhtxUE
	 JQMH58NH/COy/ToztgaAY78Qrx1LcyqFS9KZDd1wGQCmDRMVELjSGjtxfO0nQYPmb2
	 PpHY2eahx4Y7Pxeg5wkBDFXJ9ZfZkKojvGXwm7jI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wesley Atwell <atwellwea@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 7.0 04/42] crypto: krb5enc - fix sleepable flag handling in encrypt dispatch
Date: Fri, 24 Apr 2026 15:30:29 +0200
Message-ID: <20260424132421.299668440@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132420.410310336@linuxfoundation.org>
References: <20260424132420.410310336@linuxfoundation.org>
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
X-Rspamd-Queue-Id: F108445F33F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240682-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,gondor.apana.org.au];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wesley Atwell <atwellwea@gmail.com>

commit 2ef3bac16fb5e9eee4fb1d722578a79b751ea58a upstream.

krb5enc_encrypt_ahash_done() continues encryption from an ahash
completion callback by calling krb5enc_dispatch_encrypt().

That helper takes a flags argument for this continuation path, but it
ignored that argument and reused aead_request_flags(req) when setting
up the skcipher subrequest callback. This can incorrectly preserve
CRYPTO_TFM_REQ_MAY_SLEEP when the encrypt step is started from callback
context.

Preserve the original request flags but clear
CRYPTO_TFM_REQ_MAY_SLEEP for the callback continuation path, and use
the caller-supplied flags when setting up the skcipher subrequest.

Fixes: d1775a177f7f ("crypto: Add 'krb5enc' hash and cipher AEAD algorithm")
Assisted-by: Codex:GPT-5
Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/krb5enc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/crypto/krb5enc.c
+++ b/crypto/krb5enc.c
@@ -154,7 +154,7 @@ static int krb5enc_dispatch_encrypt(stru
 		dst = scatterwalk_ffwd(areq_ctx->dst, req->dst, req->assoclen);
 
 	skcipher_request_set_tfm(skreq, enc);
-	skcipher_request_set_callback(skreq, aead_request_flags(req),
+	skcipher_request_set_callback(skreq, flags,
 				      krb5enc_encrypt_done, req);
 	skcipher_request_set_crypt(skreq, src, dst, req->cryptlen, req->iv);
 
@@ -192,7 +192,8 @@ static void krb5enc_encrypt_ahash_done(v
 
 	krb5enc_insert_checksum(req, ahreq->result);
 
-	err = krb5enc_dispatch_encrypt(req, 0);
+	err = krb5enc_dispatch_encrypt(req,
+				       aead_request_flags(req) & ~CRYPTO_TFM_REQ_MAY_SLEEP);
 	if (err != -EINPROGRESS)
 		aead_request_complete(req, err);
 }



