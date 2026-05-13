Return-Path: <stable+bounces-246915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3IZUF62eBGqbMAIAu9opvQ
	(envelope-from <stable+bounces-246915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:54:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7E75368FA
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 762BB30A2D83
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5BF48BD33;
	Wed, 13 May 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dnq14dqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6E410D1B;
	Wed, 13 May 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686109; cv=none; b=dNjOmZR6XAxkP5QIvaQ2m3ZZqm6Myyvo1tMzjcJnX/pjV4om3dAH1uBJMC56G+o8KT0dQVEDmBwGO5+T+tdv/39SPcv9D/kUT8LOB7ZbPfJOeeH8EV06CWkS3ms36vlV3Pg80EkTQpHQXwGDwjGlLe4dl3BEp12QesoV6aW75PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686109; c=relaxed/simple;
	bh=nrT/IYm92GeN2uuWzQrUzNKcRKrJDw/1vnYpFU2zJLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIlTpj0pgB6RWVe5V6G3LpTi9sokN7w/kLuj2QTrAZFm77t7qkz0slpsOnK9Z18CpTf4QOQ8D3H9WlGr8wLks/cy0KEemtr7j0l/GYLwulKZIzP4c5BpTGxkG9D+OkxHH6VSs0RhZ1fukAehtEwNGKVlDjVQnCN5gSS7Rqfbi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dnq14dqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFC4C2BCC9;
	Wed, 13 May 2026 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778686108;
	bh=nrT/IYm92GeN2uuWzQrUzNKcRKrJDw/1vnYpFU2zJLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dnq14dqNX45XHyJ3UHMs9kVcOXspxwpMXLC/U+yDH/mDezIjWNxYL7M4QBsNvwJCZ
	 W4gjfuokTgTqRK9nwdtbrsSXj7iyVm8rTEoiIpx+SFthGhGHMRRkLrVbzhMnELqhxp
	 Y5zEvNsrnX2jkQIn/Hy5gNpgQb+OiPY0EIcaY25c=
Date: Wed, 13 May 2026 17:28:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	Vijayendra Suman <vijayendra.suman@oracle.com>,
	Sherry Yang <sherry.yang@oracle.com>
Subject: Re: [PATCH 6.12 190/206] crypto: nx - Migrate to scomp API
Message-ID: <2026051316-drilling-subwoofer-89bf@gregkh>
References: <20260512173932.810559588@linuxfoundation.org>
 <20260512173936.892132003@linuxfoundation.org>
 <1577a01a-f3de-4ab5-b4ad-b653cf4e3fa2@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577a01a-f3de-4ab5-b4ad-b653cf4e3fa2@oracle.com>
X-Rspamd-Queue-Id: 3F7E75368FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-246915-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,apana.org.au:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 05:42:01PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 12/05/26 23:10, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > [ Upstream commit 980b5705f4e73f567e405cd18337cc32fd51cf79 ]
> > 
> > The only remaining user of 842 compression has been migrated to the
> > acomp compression API, and so the NX hardware driver has to follow suit,
> > given that no users of the obsolete 'comp' API remain, and it is going
> > to be removed.
> > 
> > So migrate the NX driver code to scomp. These will be wrapped and
> > exposed as acomp implementation via the crypto subsystem's
> > acomp-to-scomp adaptation layer.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Stable-dep-of: adb3faf2db1a ("crypto: nx - fix bounce buffer leaks in nx842_crypto_{alloc,free}_ctx")
> 
> Note: this is pulled in as a prerequisite. More comments inline.
> 
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/crypto/nx/nx-842.c            |   33 +++++++++++++++++++--------------
> >   drivers/crypto/nx/nx-842.h            |   15 ++++++++-------
> >   drivers/crypto/nx/nx-common-powernv.c |   31 +++++++++++++++----------------
> >   drivers/crypto/nx/nx-common-pseries.c |   33 ++++++++++++++++-----------------
> >   4 files changed, 58 insertions(+), 54 deletions(-)
> > 
> > --- a/drivers/crypto/nx/nx-842.c
> > +++ b/drivers/crypto/nx/nx-842.c
> > @@ -101,9 +101,13 @@ static int update_param(struct nx842_cry
> >   	return 0;
> >   }
> > -int nx842_crypto_init(struct crypto_tfm *tfm, struct nx842_driver *driver)
> > +void *nx842_crypto_alloc_ctx(struct nx842_driver *driver)
> >   {
> > -	struct nx842_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
> > +	struct nx842_crypto_ctx *ctx;
> > +
> > +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return ERR_PTR(-ENOMEM);
> >   	spin_lock_init(&ctx->lock);
> >   	ctx->driver = driver;
> > @@ -114,22 +118,23 @@ int nx842_crypto_init(struct crypto_tfm
> >   		kfree(ctx->wmem);
> >   		free_page((unsigned long)ctx->sbounce);
> >   		free_page((unsigned long)ctx->dbounce);
> > -		return -ENOMEM;
> > +		kfree(ctx);
> > +		return ERR_PTR(-ENOMEM);
> >   	}
> > -	return 0;
> > +	return ctx;
> >   }
> > -EXPORT_SYMBOL_GPL(nx842_crypto_init);
> > +EXPORT_SYMBOL_GPL(nx842_crypto_alloc_ctx);
> > -void nx842_crypto_exit(struct crypto_tfm *tfm)
> > +void nx842_crypto_free_ctx(void *p)
> >   {
> > -	struct nx842_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
> > +	struct nx842_crypto_ctx *ctx = p;
> >   	kfree(ctx->wmem);
> >   	free_page((unsigned long)ctx->sbounce);
> >   	free_page((unsigned long)ctx->dbounce);
> >   }
> > -EXPORT_SYMBOL_GPL(nx842_crypto_exit);
> > +EXPORT_SYMBOL_GPL(nx842_crypto_free_ctx);
> >   static void check_constraints(struct nx842_constraints *c)
> >   {
> > @@ -246,11 +251,11 @@ nospc:
> >   	return update_param(p, slen, dskip + dlen);
> >   }
> > -int nx842_crypto_compress(struct crypto_tfm *tfm,
> > +int nx842_crypto_compress(struct crypto_scomp *tfm,
> >   			  const u8 *src, unsigned int slen,
> > -			  u8 *dst, unsigned int *dlen)
> > +			  u8 *dst, unsigned int *dlen, void *pctx)
> >   {
> > -	struct nx842_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
> > +	struct nx842_crypto_ctx *ctx = pctx;
> >   	struct nx842_crypto_header *hdr =
> >   				container_of(&ctx->header,
> >   					     struct nx842_crypto_header, hdr);
> > @@ -431,11 +436,11 @@ usesw:
> >   	return update_param(p, slen + padding, dlen);
> >   }
> 
> 
> I have run an AI assisted backport review and it spotted an issue: I
> have taken a look and the issues goes like:
> 
> 
> Backport commit: 481ea90e8326 ("crypto: nx - Migrate to scomp API") migrates
> NX 842 registration to the no-tfm scomp API but 6.12.y still uses the old
> free_ctx(tfm, ctx) for freeing.
> 
> The required prerequisite commit commit: 0af7304c0696 ("crypto: scomp -
> Remove tfm argument from alloc/free_ctx") which is not in 6.12.y:
> 
>   mainline        : v6.15-rc1 - 0af7304c0696 crypto: scomp - Remove tfm
> argument from alloc/free_ctx
> 
> it is only in 6.15-rc1 +
> 
> So Upstream has:
> 
> struct scomp_alg {
>         void *(*alloc_ctx)(void);
>         void (*free_ctx)(void *ctx);
>         int (*compress)(struct crypto_scomp *tfm, const u8 *src,
>                         unsigned int slen, u8 *dst, unsigned int *dlen,
>                         void *ctx);
> 
> Downstream 6.12.y has:
> 
> struct scomp_alg {
>         void *(*alloc_ctx)(struct crypto_scomp *tfm);
>         void (*free_ctx)(struct crypto_scomp *tfm, void *ctx);
>         ...
> };
> 
> .free_ctx = nx842_crypto_free_ctx,
> 
> void nx842_crypto_free_ctx(void *p)
> 
> Given that we don't have commit: 0af7304c0696 ("crypto: scomp - Remove tfm
> argument from alloc/free_ctx") in 6.12.y it feels wrong to pick up this
> patch. Thoughts ?

Thanks, I've dropped this and fixed up the real bugfix here "by hand" to
apply properly.

greg k-h

