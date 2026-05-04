Return-Path: <stable+bounces-242854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOr6M2RF+Gn9rwIAu9opvQ
	(envelope-from <stable+bounces-242854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 09:06:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 702EB4B9295
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 09:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F22A30022E2
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 06:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E872B2D3ED2;
	Mon,  4 May 2026 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeCy8+84"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781F1A7264;
	Mon,  4 May 2026 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877894; cv=none; b=I2jswPYLGKyJyHBwB4vr6A628peDitQ1v8EomLuAyzjzGQTDQO4dWJwP3Dk0rkj8CgIcly8Il7B1Tj5bHvBFPx1/L0USpSNm1Aq2ibJMKywsYvFiUi6yEnu+35UBGO9hJJFpjjo/ORY/zLkLYvDht5ZkRm7S38iMNjGtsszInJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877894; c=relaxed/simple;
	bh=eEPWkYG9vRxG9eKHUX36q6Uk4lUTzBZNMaSTD+uUOVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rspuzo+cVp6+GX6rVQl7Q8Bc4u3/nZ7iWAjC/qft+9PN/GCHQoBY0ZSRYjTC0cRiF9RRhB/cdYBPIfNw4V9XpwtWU3hl9mWN1MmHaurqMc8Q3bxhaSHOWJutqY3Q2cPwynEnQIuRoXtV7q+jWLoKrB8NI6I7n4Y7ylt0iyPfUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeCy8+84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE986C2BCB8;
	Mon,  4 May 2026 06:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777877894;
	bh=eEPWkYG9vRxG9eKHUX36q6Uk4lUTzBZNMaSTD+uUOVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oeCy8+841qO7uotZxyYDEAuv7Ew4w7qtYZyw98vgHYEqEg2IUxbKPyVBm01ta6/qa
	 7TQY8LEJFV9SDCwQFwwQgJ3Jx7GjUjZiE9pc8rko/Jqkkn8i9VnPNXvew/WO+eVo2L
	 g89PWs8MpMtocSQGk5NfUWATxD3s2SPrzFlwzWcs+nLtgOxPLCnVTgI9wF2elxZGzL
	 mFJGh6YZ2SNuSHL58E2sh0HAeeqmgEMmF0o+58PduEHO7fQ79PAXZaCe5TVj4BG6u8
	 PxOd9y6bXv7OzTfwSdPEjowwsl5K95TjSq7xqNVEA7Ova0Bt95s2n3jKxFrTNfRWip
	 lFwAWxbVMqSRg==
Date: Sun, 3 May 2026 23:56:55 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Taeyang Lee <0wn@theori.io>, Brian Pak <bpak@theori.io>,
	Juno Im <juno@theori.io>, Jungwon Lim <setuid0@theori.io>,
	Tim Becker <tjbecker@theori.io>, Feng Ning <feng@innora.ai>,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg - Remove zero-copy support from AF_ALG
Message-ID: <20260504065655.GB112568@sol>
References: <20260504061532.172013-1-ebiggers@kernel.org>
 <79b24e6f-91a2-4dd0-a5f2-c01a9247ea9c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b24e6f-91a2-4dd0-a5f2-c01a9247ea9c@gmail.com>
X-Rspamd-Queue-Id: 702EB4B9295
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242854-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[innora.ai:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,copy.fail:url,theori.io:email]

On Mon, May 04, 2026 at 02:54:27AM -0400, Demi Marie Obenour wrote:
> On 5/4/26 02:15, Eric Biggers wrote:
> > The zero-copy support is one of the riskiest aspects of AF_ALG.  It
> > allows userspace to request cryptographic operations directly on
> > pagecache pages of files like the 'su' binary.  It also allows userspace
> > to concurrently modify the memory which is being operated on, a huge
> > recipe for TOCTOU vulnerabilities.
> > 
> > While zero-copy support is more valuable in other areas of the kernel
> > like the frequently used networking and file I/O code, it has far less
> > value in AF_ALG, which is a niche UAPI.  AF_ALG primarily just exists
> > for backwards compatibility with a small set of userspace programs such
> > as 'iwd' that haven't yet been fixed to use userspace crypto code.
> > 
> > Originally AF_ALG was intended to be used to access hardware crypto
> > accelerators.  However, it isn't an efficient interface for that anyway,
> > and it turned out to be rarely used in this way in practice.
> > 
> > Thus, the risks of the zero-copy support in AF_ALG vastly outweigh its
> > benefits.  Just remove it.
> > 
> > Note that this isn't a hard break, since the splice syscall is still
> > supported.  The data is just now copied instead.  So it still works,
> > just a bit slower in some cases.
> > 
> > Tested with libkcapi/test.sh.  All its test cases still pass.  I also
> > verified that this would have prevented the copy.fail exploit as well.
> > 
> > Fixes: 8ff590903d5f ("crypto: algif_skcipher - User-space interface for skcipher operations")
> > Fixes: 400c40cf78da ("crypto: algif - add AEAD support")
> > Reported-by: Taeyang Lee <0wn@theori.io>
> > Reported-by: Feng Ning <feng@innora.ai>
[...]
> In light of https://lore.kernel.org/all/afYcc-tZFwvZZo76@ans-MacBook-Pro.local/,
> yes please!
> 
> Should there be a Link: tag referencing that email?

Yes I forgot to put that in, sorry.  It should go after the second
Reported-by:

    Link: https://lore.kernel.org/r/afYcc-tZFwvZZo76@ans-MacBook-Pro.local

- Eric

