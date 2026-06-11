Return-Path: <stable+bounces-262638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OuOyOcl2KmpPpwMAu9opvQ
	(envelope-from <stable+bounces-262638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 10:50:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A5A670031
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 10:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=oXJi7PBi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262638-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262638-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B7063102BC7
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 08:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B7326ACC;
	Thu, 11 Jun 2026 08:48:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64A1DDC07;
	Thu, 11 Jun 2026 08:48:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167702; cv=none; b=K1BqX4FVqWRiyx3mpoCdB1GsTDrDuswNbMRZ95QG64wlGmUsXiuypzmOTOIYL+uMcH00hyED84Utq5uugkbpIi1l84Rqt/6hjXxcQpPrDEKCa1AThA0NpGB6Ti0g0tuHsftA42f5ZuU6SEDoUMkrjR/E4NkKa0l4/ZF2iPw3xWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167702; c=relaxed/simple;
	bh=cfQvIbp0jM4STUEjGfy90m0zb61Kkokx5L71mI65VxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/joIYeD1DPVt5wzglM1jgPyZSewMZciqsDdag8On9aIvT9MF/f2jkXWsErXDe4PqjkxMIfExMsSrtI7kUy7PXcOr4w2b23gcKtct8G3PCRoGzmXrj9FJGwXni5Zj7N8bMZbL5S6eyJdmCH4H87Kiq7E0y0h/An3oSEkKF7gEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=oXJi7PBi; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=8LIqtcZKNkc2uKbRR6MR2liMH+f4E+aYDAhp5GtwOQQ=; 
	b=oXJi7PBiInOeAV+gHQ6An5Hww69oa5wyEJPX2qscey0SP1ymdHHu+s2CR6wA+8E8EfQSb5kRgQA
	qWs0zhsEE5RcPnAHjoo0M1sUW/BEGfQAQ0zvZk4/l5CKkG8qXqJdX1Q079sCS0QR75jPJ+Vqtp172
	qpLlKhcTSJ+Dsf8DtO7+pkB4Hu6RV9fSzsADrLQrv74Ln9llAjSp8KUhyt6uOnFwaGp4hvjxKqJeb
	C7/o4JeZyj/0Io1Z+wEnJvsBd3g/RkZ4Fsy0F4D1ve/n4b6Dxjqqf2JAThWPZxwtg7eYeDMSUT4L/
	Qi1ZsWrZ2Uwu0qVSOdeZSYhxJemAWE0rABig==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXb5E-00000004XS2-3IHN;
	Thu, 11 Jun 2026 16:48:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:48:16 +0800
Date: Thu, 11 Jun 2026 16:48:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yinggang Gu <guyinggang@loongson.cn>, Lee Jones <lee@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: loongson - Remove broken and unused loongson-rng
Message-ID: <aip2ULHUVT8YiMuh@gondor.apana.org.au>
References: <20260529233208.8703-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529233208.8703-1-ebiggers@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262638-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:zhaoqunqin@loongson.cn,m:chenhuacai@kernel.org,m:guyinggang@loongson.cn,m:lee@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40A5A670031

On Fri, May 29, 2026 at 04:32:08PM -0700, Eric Biggers wrote:
> The loongson-rng rng_alg has several vulnerabilities, including not
> providing forward security, and a use-after-free bug due to the use of
> wait_for_completion_interruptible().
> 
> Meanwhile, the rng_alg framework doesn't really have any purpose in the
> first place other than to access the software algorithms crypto/drbg.c
> and crypto/jitterentropy.c.  Hardware-specific rng_algs have no
> in-kernel user, and unlike hwrng there's no feed into the actual Linux
> RNG.  As such, there's really no point to this code.  There are of
> course other rng_alg drivers that are similarly unused, but they're
> similarly in the process of being phased out, e.g.
> https://lore.kernel.org/r/20260529193648.18172-1-ebiggers@kernel.org and
> https://lore.kernel.org/r/20260529220430.34135-1-ebiggers@kernel.org
> 
> Given that, there's no point in fixing forward these vulnerabilities,
> and it makes much more sense to simply roll back the addition of this
> driver.  If this platform provides TRNG (not PRNG) functionality, it
> could make sense to add a hwrng driver, but it would be quite different.
> 
> Link: https://lore.kernel.org/linux-crypto/20260525145939.GC2018@quark/
> Fixes: 766b2d724c8d ("crypto: loongson - add Loongson RNG driver support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  MAINTAINERS                                 |   1 -
>  arch/loongarch/configs/loongson32_defconfig |   1 -
>  arch/loongarch/configs/loongson64_defconfig |   1 -
>  drivers/crypto/Kconfig                      |   1 -
>  drivers/crypto/Makefile                     |   1 -
>  drivers/crypto/loongson/Kconfig             |   6 -
>  drivers/crypto/loongson/Makefile            |   1 -
>  drivers/crypto/loongson/loongson-rng.c      | 209 --------------------
>  8 files changed, 221 deletions(-)
>  delete mode 100644 drivers/crypto/loongson/Kconfig
>  delete mode 100644 drivers/crypto/loongson/Makefile
>  delete mode 100644 drivers/crypto/loongson/loongson-rng.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

