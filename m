Return-Path: <stable+bounces-259283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA+LDJ82G2oXAQkAu9opvQ
	(envelope-from <stable+bounces-259283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 21:12:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A74612FD2
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 21:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DDB1302DFB8
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FC8296BC1;
	Sat, 30 May 2026 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOs1jz+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C692628C5CB;
	Sat, 30 May 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780168333; cv=none; b=QfO44Vw6ZrPvzt4OlakJHlYGCmaZGPryDsx7nVDiAEZ2Z41eH9u1vbg/scC8ZPtJZLm1gFTwpUIXByC7a2HonRtKfWgEIoHW1KTo3qa1Yjqi8CgIGKCNjqnHxZmParG+WqxbNDh4eViv8Vqi/+5bIiHRkIs+pwBqLbJI1sDmO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780168333; c=relaxed/simple;
	bh=DJcr0gSSpMZr6xUdirV2SS3XS4yWuzkl58yJTUak94Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaMth5ymtVXATYF6/VMIGj1uiPEV2mvPBNmHbZKMJri+lv2EMLce5G/pA+86lZYJ6k05CyTZylU7bnddsiBgkbn4vv/9GAFA5c1DSq6nOKFc3I8C+Oz46ILbYYaAGw2yPgj5qLY3af3MNDloRtMmtGynfA/j7putdw/QGFTid+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOs1jz+o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BF51F00893;
	Sat, 30 May 2026 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780168332;
	bh=wuWV0UDN7XNlhZhb++Cgiht7/YenA/gl8ofUZVO9VMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bOs1jz+oauIQCmArH/fPM8HDOOrAHv/F7bMYh+FHVbJubtmHf+sgKD/tCUW6TEsbE
	 g256mN5wQ8CrEDMqDbFm3vhO/CtWEcENaGGoHDYmArQm1RWWX+mPCxyGX2BubIx9tZ
	 r+RR3/n/qEyxuUkcBhsTBdWLn4rVWGZ/ssSwSB0+X2eFJcaC+y5/m/QBViyZkbfqN+
	 /XonNk8OwW9Yg3ykoNOFeNBkE2Old6QgDvjtPaefzwddrSeOZqxx0tybAxKhLtj160
	 UYMeLhE/juU/JfS1Kg8C2h1ku/qWXuwnN9ckhkB1d2gj+0/8wiHu4702aBTgGhf6ce
	 pEL+SjY785pVw==
Date: Sat, 30 May 2026 12:12:07 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: crypto4xx - Remove insecure and unused rng_alg
Message-ID: <20260530191207.GA6807@quark>
References: <20260529220430.34135-1-ebiggers@kernel.org>
 <e0b3cfc2-c6da-46d4-9dec-027dafaba74e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b3cfc2-c6da-46d4-9dec-027dafaba74e@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259283-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B0A74612FD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 12:20:57PM +0200, Christian Lamparter wrote:
> > diff --git a/drivers/crypto/amcc/crypto4xx_reg_def.h b/drivers/crypto/amcc/crypto4xx_reg_def.h
> > index 1038061224da..73d626308a84 100644
> > --- a/drivers/crypto/amcc/crypto4xx_reg_def.h
> > +++ b/drivers/crypto/amcc/crypto4xx_reg_def.h
> > @@ -88,24 +88,13 @@
> >   #define CRYPTO4XX_DMA_CFG	        	0x000600d4
> >   #define CRYPTO4XX_BYTE_ORDER_CFG 		0x000600d8
> >   #define CRYPTO4XX_ENDIAN_CFG			0x000600d8
> > -#define CRYPTO4XX_PRNG_STAT			0x00070000
> > -#define CRYPTO4XX_PRNG_STAT_BUSY		0x1
> >   #define CRYPTO4XX_PRNG_CTRL			0x00070004
> >   #define CRYPTO4XX_PRNG_SEED_L			0x00070008
> >   #define CRYPTO4XX_PRNG_SEED_H			0x0007000c
> > -
> > -#define CRYPTO4XX_PRNG_RES_0			0x00070020
> > -#define CRYPTO4XX_PRNG_RES_1			0x00070024
> > -#define CRYPTO4XX_PRNG_RES_2			0x00070028
> > -#define CRYPTO4XX_PRNG_RES_3			0x0007002C
> > -
> > -#define CRYPTO4XX_PRNG_LFSR_L			0x00070030
> > -#define CRYPTO4XX_PRNG_LFSR_H			0x00070034
> > -
> 
> Hmm, don't think these defines will hurt anyone? As these are part of the hardware spec.
> Or do you forsee a future where AI-Agents will sent patches hallucinating that it "fixed"
> the issue which readds it? I have no idea.

Well, there's not really any point in keeping these when they aren't
used.

- Eric

