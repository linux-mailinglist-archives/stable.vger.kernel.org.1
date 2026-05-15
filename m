Return-Path: <stable+bounces-247641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLVZBBzzBmqtpQIAu9opvQ
	(envelope-from <stable+bounces-247641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:19:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2A754D323
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED5C73036C9E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7345144CAE2;
	Fri, 15 May 2026 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="oC9PAanA"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3B44BCAE;
	Fri, 15 May 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839975; cv=none; b=jWroysKt12hU++L3h3M+rmdedI41KWkQc+IJ9EsFLT3sBWlvpr4DpwvQ5q69XaYD2cOCaz3SCHRbWDjSC3Vp7912gUGUD0P5rJxzpcOJjGChWhG8Y57mVnqtWI6WZzVxfe6dYZtuR21DTXYfn437LTlmNnun+hfT0+SK6JJ5DX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839975; c=relaxed/simple;
	bh=+uuolMEzk01MqROiPWoLaqFCK9H047b1HfjEJPLE0a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6a52Bp40d9RpWvvFrepgJoqHM9SvwLd/XedBUijvcXbNHF38S5yXqqhfMCtS6YCKywddCMIX6EY4PZI6rpoEdfS5legt6pfxOkJ0Fz7D+4NPbcklOVjUCnYGTjnLp4X3dDy3fK1KKNbpsYrj5pK9IPrfmIMBrqVnpNtvYQGAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=oC9PAanA; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=307ZaWD6IWPu+vWKv98hkfU29hz3L1LQMmI008hUEKU=; 
	b=oC9PAanAWj6k35PG7BSaA+Idnz/ku+8/0objh/1fjmJyyWghehgD8dyzJVeUYVdKdzzB8+YZ0Dq
	ZUer+jkt28abXSSHsjxdPsB0N1sZeGGF9rnSgbsA9+WnOOkF/sv60hB8tXauUree1BVwJPpnop91s
	08BhVVs9rTESBgdnVsTlDLpvSTwQnjPWG/J/YL0iUZ8QUvZmARtLPtfupUk3HqbMVWTj7o6FFvNln
	Eo+chwpms7oxbrHiFxS3WvChINcRxXtBKHbZaSkGUWbwhHGIe0okLeCNkWsuz/L1I/Dh8w7lL+F5q
	DC1qlQZ8K1Qf1FUZz3rZbkT+gEPFHTuLZBww==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wNpXA-00EOFJ-0z;
	Fri, 15 May 2026 18:12:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 May 2026 18:12:44 +0800
Date: Fri, 15 May 2026 18:12:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Taeyang Lee <0wn@theori.io>,
	Brian Pak <bpak@theori.io>, Juno Im <juno@theori.io>,
	Jungwon Lim <setuid0@theori.io>, Tim Becker <tjbecker@theori.io>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Feng Ning <feng@innora.ai>, stable@vger.kernel.org
Subject: Re: [PATCH v3] crypto: af_alg - Remove zero-copy support from
 skcipher and aead
Message-ID: <agbxnDKpD7o1uFOq@gondor.apana.org.au>
References: <20260504092442.GA2486@quark>
 <20260504225328.25356-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504225328.25356-1-ebiggers@kernel.org>
X-Rspamd-Queue-Id: 9E2A754D323
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,theori.io,gmail.com,innora.ai];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TAGGED_FROM(0.00)[bounces-247641-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 03:53:28PM -0700, Eric Biggers wrote:
> The zero-copy support is one of the riskiest aspects of AF_ALG.  It
> allows userspace to request cryptographic operations directly on
> pagecache pages of files like the 'su' binary.  It also allows userspace
> to concurrently modify the memory which is being operated on, a recipe
> for TOCTOU vulnerabilities.
> 
> While zero-copy support is more valuable in other areas of the kernel
> like the frequently used networking and file I/O code, it has far less
> value in AF_ALG, which is a niche UAPI.  AF_ALG primarily just exists
> for backwards compatibility with a small set of userspace programs such
> as 'iwd' that haven't yet been fixed to use userspace crypto code.
> 
> Originally AF_ALG was intended to be used to access hardware crypto
> accelerators.  However, it isn't an efficient interface for that anyway,
> and it turned out to be rarely used in this way in practice.
> 
> Thus, the risks of the zero-copy support in AF_ALG vastly outweigh its
> benefits.  Let's just remove it.
> 
> This commit removes it from the "skcipher" and "aead" algorithm types.
> "hash" will be handled separately.
> 
> This is a soft break, not a hard break.  Even after this commit, it
> still works to use splice() or sendfile() to transfer data to an AF_ALG
> request socket from a pipe or any file, respectively.  What changes is
> just that the kernel now makes an internal, stable copy of the data
> before doing the crypto operation.  So performance is slightly reduced,
> but the UAPI isn't broken.  And, very importantly, it's much safer.
> 
> Tested with libkcapi/test.sh.  All its test cases still pass.  I also
> verified that this would have prevented the copy.fail exploit as well.
> I also used a custom test program to verify that sendfile() still works.
> 
> Fixes: 8ff590903d5f ("crypto: algif_skcipher - User-space interface for skcipher operations")
> Fixes: 400c40cf78da ("crypto: algif - add AEAD support")
> Reported-by: Taeyang Lee <0wn@theori.io>
> Link: https://copy.fail/
> Reported-by: Feng Ning <feng@innora.ai>
> Closes: https://lore.kernel.org/r/afYcc-tZFwvZZo76@ans-MacBook-Pro.local
> Reviewed-by: Demi Marie Obenour <demiobenour@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> v3: improved explanation
> v2: added tags
> 
>  Documentation/crypto/userspace-if.rst | 31 ++----------
>  crypto/af_alg.c                       | 73 +++++++++------------------
>  crypto/algif_aead.c                   |  8 +--
>  3 files changed, 33 insertions(+), 79 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

