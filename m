Return-Path: <stable+bounces-256520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOUjGqUtGWogrwgAu9opvQ
	(envelope-from <stable+bounces-256520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:09:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD21E5FDC61
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B801130CEE9C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4EF3A0B1D;
	Fri, 29 May 2026 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="bgYUFCco"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A780360751;
	Fri, 29 May 2026 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034910; cv=none; b=b3gDPTCD4bSRR21YVk1d9TcJSOuMtbn0DKFou8GUAJvDEyF+8BByMgu1e2Pwq2VXaHBOf3ZsAlgz6U2oGNf8kp2So8I0OiepUj9I60CURkmNPqAMX/EtLPpQXndw75qbOnwMFsE5W9hfpyCpHgU4haoiVld0x9LfNqrRe1WHrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034910; c=relaxed/simple;
	bh=RBz//esfofXvbehmuF8QGKMMslpRvLKFHYYxjIwoPcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAt/nHR68jEl7Cd0ec8JiaexEoEEmi7ilxn16MeiwLsqJXb6PBFeCeyVqc/ileAuDm32Dk7H1Yfjh7sGNmeOV9Swt0IRi264KGbofbdteJSUJiHdGk666nklw+6BSdHm8Qo1BHW2MlrAlwG69W1TNn3isVzqjqiINt1sFTl/dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=bgYUFCco; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=bUi6qNPCJHs1zjImKGBpaa0dufszLYZyWbxdSNWETVo=; 
	b=bgYUFCcoZ/+pBgZ4BgEIM/6U8LBKUang6Ju5OrggXpuoRp0Gl2Nbiyn4wG5RsnyqhC8AFiA2M+z
	sB8N/V4dAM+cjb6WaAOgMr7dq0Ga6rQjuYv4ZY70/IqBeGkBIbnThJ8AZVneKlygelhQHm+29jPDL
	BBVLjEXNQEmCJZ+qk7drDf2wpdQjGSMfwQqhqdNQgubnAlquycGI8swLCol7vCqiaflDRpMQQRdft
	wxutGbwemtSLW+6sUHYC9Z4FpZDr3y/mhpSVpd/7/ni8alW/gTZ54KiBFNNEUe5yQgzrJ9EUotnMm
	O7VFLG1N5xH8+q7oH35RkZ6wAhN3UgNGxwuQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wSqOP-000dJI-2C;
	Fri, 29 May 2026 14:08:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 May 2026 14:08:25 +0800
Date: Fri, 29 May 2026 14:08:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, Huacai Chen <chenhuacai@kernel.org>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Yinggang Gu <guyinggang@loongson.cn>, Lee Jones <lee@kernel.org>,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: loongson - Select CRYPTO_RNG
Message-ID: <ahktWQCfZYel_0hZ@gondor.apana.org.au>
References: <20260522022525.12976-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522022525.12976-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256520-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:mid,gondor.apana.org.au:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,apana.org.au:url,apana.org.au:email,intel.com:email]
X-Rspamd-Queue-Id: DD21E5FDC61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 09:25:25PM -0500, Eric Biggers wrote:
> This driver registers a rng_alg, so it requires CRYPTO_RNG.
> 
> Fixes: 766b2d724c8d ("crypto: loongson - add Loongson RNG driver support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605201622.qWOiiZTV-lkp@intel.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  drivers/crypto/loongson/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

