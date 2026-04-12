Return-Path: <stable+bounces-235805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPpkOVdd22mWAwkAu9opvQ
	(envelope-from <stable+bounces-235805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 10:52:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 455713E3269
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 10:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE0CC3019F0E
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E593C2F90C9;
	Sun, 12 Apr 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="pS0yIq3G"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C6B2DEA64;
	Sun, 12 Apr 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775983934; cv=none; b=NdfTTHNDye/qT+TlqgkZGOZeCjYTGMiS0nFVHGYgMHAY6UgcmwcXCgk+1M67NMQm8quByYMCwYUuKWRU6Ga+Adkgq5wPs1rA2FVwwd7HZnTijuztpkiYhTqtrlc18uyflJzraCnJWwMAV7ww18KfVELAKFuV6mssfq0KhCjgCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775983934; c=relaxed/simple;
	bh=ViSmbdSX6LKAF+U4zuG9wp46Bd/qGUNDNu9e83ZEfe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQg9t+F+DFv/stDk8Uv0KoqTIu/j95VjjU/qpn0/e6emBG/n5iT+Y6aWvNZgz2IWMu3QogxiFoW6seFWZRIU1GbU5hI17mBMuxt+BtcFN6dja66QYnpTPVnhmXqIAgb1AR/Wtn+g7Y+yCBhLyuYCjtzF3a+DYEPdX2RTTTuCWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=pS0yIq3G; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=+ne1c67xZj2Cj4GkgPF8gH5xDmjvNPxULJWRk1kJ9OQ=; 
	b=pS0yIq3GfJY/wYEsFKMPD/XUTfneEo6zw+VxpL/hzR75npv97tMiZ6PeL9JQREo8s2SxVYsYvYs
	8zlM7qE6GytM4qVsmzauPURr/Y1wkvdBetf71bu/6YduokBV9RPX8ZodFiW/87K/qdBy9DfMeDYW1
	E8g/CkGG+hsvmINqPJbG5g8yNQwK8ls402XQBB9E6arZpQeeGai6hLYgexXQvtgF/i3TDgFg9pfGa
	ku9a0ThlKeiWcsSU9xJeEuby0Qs78Q61kYXvXBVftknm9O8QsXFJmmAo9BSK4jyr+GaKZfndyKe6/
	ECXeHZzjT7YZvRGo0+hAU3I1SEUhIqb2cLjA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wBq8Y-005UJW-0p;
	Sun, 12 Apr 2026 16:52:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 12 Apr 2026 16:52:05 +0800
Date: Sun, 12 Apr 2026 16:52:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon - Fix dma_unmap_single() direction
Message-ID: <adtdNVq0Sw-Q9Yxm@gondor.apana.org.au>
References: <20260330151937.83837-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330151937.83837-2-fourier.thomas@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235805-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Queue-Id: 455713E3269
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 05:19:32PM +0200, Thomas Fourier wrote:
> The direction used to map the buffer skreq->iv is DMA_TO_DEVICE but it is
> unmapped with direction DMA_BIDIRECTIONAL in the error path.
> 
> Change the unmap to match the mapping.
> 
> Fixes: 915e4e8413da ("crypto: hisilicon - SEC security accelerator driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/crypto/hisilicon/sec/sec_algs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

