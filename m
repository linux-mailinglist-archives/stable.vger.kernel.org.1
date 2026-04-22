Return-Path: <stable+bounces-240300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMmtH46V6GmENAIAu9opvQ
	(envelope-from <stable+bounces-240300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:31:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E74944403F
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9A8C3012593
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C492877DA;
	Wed, 22 Apr 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="HE4+eZoa"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (dresden.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35972265CD9
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850226; cv=none; b=mNPuVRbpQxhFPuOn0IEBlDOnp9G9WYEeM/bJyB+kNHrD7SVKQ5B/6rk+67LjuOLCPAFxHTzbMupMN4a5t8aM6Dwz865gxfGb2ttlSwEbAqmG+L7OxbaATxnlTtfN+DbtVK/83JKu1CUhEaP+S2rcgWdVYCZnzxg6h2nrclrJfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850226; c=relaxed/simple;
	bh=mQrXxYVnkzKBosLSh098LE/jJx5xWPb3y+k9B+KZU4U=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=S/AhZrm1WRFNzJ+JyXJHXa9lPfKKJ66bQvYiSKXQxw40oBZ/VQLzflWnvE+jJsSRHhuuAyyA3WICgPCBFIEd4Hn/xaTtIfKJPJoozRwKio3rfiEnlzsZ55Jbyq+huGgdAbl0Y6SjC9V4r6ODgJr4umG86z/tASDNX/yOo8xz4AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=HE4+eZoa; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4g0v8M6Q7CzRhR8;
	Wed, 22 Apr 2026 11:30:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1776850211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+nl3nmM5BrVtgm/7Fv/5CLZrIkUquzkMxN4THQHlrk=;
	b=HE4+eZoa0tw8UXoa0ZYCrPFUSnZWy1bLTxaK4Il+jo49TxR5+/flvLprAAvOSWNteZD3Hx
	9mJGmK+3ny7GNATzMxBzYduJmuyDZLaXeybhkrRp7YFFXCffSDe6Yn8FTE1ZfDTtkjgRmy
	aZj99oVJI8sy9XqS4tncUYATGBCKb9k3BiMZ1Z7WBAxJmGvJ5KhvaqnvwqA4Oh+hs4Xnyp
	exj6TQh14fQebqtsnVDfL7fE1zxXaI1mDVGW5UrEqG2hLnXRmZ42UJVPv282rXVDq8b3vk
	yynreFNEnt2Kvnbnc2x7izQbNSDzJxfhMoOrTrnjbi4Q0Vkfwp6j28k+5yO3ig==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 11:30:11 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Subject: Fwd: [PATCH] crypto: authencesn - Fix src offset when decrypting
 in-place
In-Reply-To: <ad7QGhjPKRh-Vvm5@gondor.apana.org.au>
References: <2026041152-boaster-patrol-1918@gregkh>
 <b397c5b34ed7484aad6e0acf7e1319c6@stwm.de>
 <ad7QGhjPKRh-Vvm5@gondor.apana.org.au>
Message-ID: <0462b2759106bbb145297a49369820c4@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[stwm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[stwm.de:s=stwm-20170627];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240300-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@stwm.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[stwm.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stwm.de:email,stwm.de:dkim,stwm.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E74944403F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

the fix from Herbert Xu has landed in Torvald's tree as:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1f48ad3b19a9dfc947868edda0bb8e48e5b5a8fa


Would it be possible to include it in the next stable releases? I using 
it already for v6.18.22 and v6.18.23 and it fixes ipsec with esn.


-------- Originalnachricht --------
Betreff: [PATCH] crypto: authencesn - Fix src offset when decrypting 
in-place
Datum: 2026-04-15 01:39
Von: Herbert Xu <herbert@gondor.apana.org.au>
An: Wolfgang Walter <linux@stwm.de>
Kopie: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
linux-kernel@vger.kernel.org, stable@vger.kernel.org, Sasha Levin 
<sashal@kernel.org>, Linux Crypto Mailing List 
<linux-crypto@vger.kernel.org>

On Tue, Apr 14, 2026 at 06:52:22PM +0200, Wolfgang Walter wrote:
> Hello,
> 
> with 6.12.18 ipsec stopped working for us. After reverting commit
> 
> commit 153d5520c3f9fd62e71c7e7f9e34b59cf411e555.
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Fri Mar 27 15:04:17 2026 +0900
> 
>     crypto: authencesn - Do not place hiseq at end of dst for 
> out-of-place
> decryption

Yes this is broken.  Please try this patch:

---8<---
The src SG list offset wasn't set properly when decrypting in-place,
fix it.

Reported-by: Wolfgang Walter <linux@stwm.de>
Fixes: e02494114ebf ("crypto: authencesn - Do not place hiseq at end of 
dst for out-of-place decryption")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/authencesn.c b/crypto/authencesn.c
index c0a01d738d9b..af3d584e584f 100644
--- a/crypto/authencesn.c
+++ b/crypto/authencesn.c
@@ -228,9 +228,11 @@ static int crypto_authenc_esn_decrypt_tail(struct 
aead_request *req,

  decrypt:

-	if (src != dst)
-		src = scatterwalk_ffwd(areq_ctx->src, src, assoclen);
  	dst = scatterwalk_ffwd(areq_ctx->dst, dst, assoclen);
+	if (req->src == req->dst)
+		src = dst;
+	else
+		src = scatterwalk_ffwd(areq_ctx->src, src, assoclen);

  	skcipher_request_set_tfm(skreq, ctx->enc);
  	skcipher_request_set_callback(skreq, flags,


Regards
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

