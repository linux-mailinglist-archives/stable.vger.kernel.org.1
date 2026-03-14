Return-Path: <stable+bounces-225406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IAyAZHqtGkuuQAAu9opvQ
	(envelope-from <stable+bounces-225406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 05:56:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EF828B9FB
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 05:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8861E304AAFA
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 04:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28C8346E70;
	Sat, 14 Mar 2026 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="n6z5ZCyl"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4E1FC0FC;
	Sat, 14 Mar 2026 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773464202; cv=none; b=SG5NUbdmsN0LYsRPvqYnOYAn7DqGp3ZUtvDBkQjKKQIk03Frf1RcsPHlWBriuldzTqTnyYfzLNY2szplVnVyyU5ioi/HV62xp+hILBDEZnQOSE2VI55Mk4wSwcHpTTp4kNfuhRwxhACCvP1Tp1gYgnYvGwZV5QKHcVDmGZqoTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773464202; c=relaxed/simple;
	bh=WKzbUM/TetTYKdEGDFZcp+0PPb/Fq2fZOv9jLw8+k6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Licyp5ouxAzgh8xeBoZ0LFDOn2JViG/EB9dGOhpMBK4MSSl9nsggluatVagjKgZiyRHK28lMVgvJjBB1MeEWSIcTxTskxtQTvJRiTcCFnDf3EWdfYt6vNBaAS8R4wj3tmSynuRiesEVt/S2T1PboqKk+s8NL1QvzNGOXiEyT9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=n6z5ZCyl; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=BtaFN/3OIDRUzNsp9pMbMb+hL6db+m54rOKvY8r2Las=; 
	b=n6z5ZCylKhckSVcPe2kcXMYHV769xnrGXH0np7daM/iNFGyMZfBs/no21dBkIqmxniYt+uMnUGo
	7asnP4JtVbIY9c9Fi8XGB5cqv5Rl8qHp2WXRBOHFFPZkuTDCdvQ0fnyP+VXUBKvkUBWUdUBnsiqTr
	8um9E02KFn6Gj7VLA7pNcG3rnPAcqRBDwbw1sz5/O+6kDNc0Qh5PokIrgywrN/ojwZ3++FdMykK/2
	nXJnH7auKwt4yyXodN4Nc6SX1skQXbqV9QYQnPCmobnstVk/eEL3Jt/Gs+aGOreT8TGnv2R0/ZInP
	Naa5gzkyxznZ1TFmiOgZJzZy/cxGbwvpoLKg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1H33-00EKwY-10;
	Sat, 14 Mar 2026 12:56:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Mar 2026 13:56:25 +0900
Date: Sat, 14 Mar 2026 13:56:25 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Kim Phillips <kim.phillips@freescale.com>,
	Yuan Kang <Yuan.Kang@freescale.com>, stable@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam - remove HMAC key hex dumps from
 hash_digest_key
Message-ID: <abTqefme_iApfHZi@gondor.apana.org.au>
References: <20260306111204.302544-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306111204.302544-1-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225406-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,apana.org.au:email,apana.org.au:url,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97EF828B9FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 06, 2026 at 12:12:03PM +0100, Thorsten Blum wrote:
> Stop dumping sensitive HMAC key bytes (original and reduced keys) in
> hash_digest_key() to avoid leaking secrets when debug logging is
> enabled.
> 
> Fixes: 045e36780f11 ("crypto: caam - ahash hmac support")
> Fixes: 3f16f6c9d632 ("crypto: caam/qi2 - add support for ahash algorithms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/caam/caamalg_qi2.c | 5 -----
>  drivers/crypto/caam/caamhash.c    | 6 ------
>  2 files changed, 11 deletions(-)

What is the rationale for this? When debugging is enabled, all
sorts of things could be dumped, e.g., passwords.

Is there a scenario where production systems will run with debugging
enabled in caam?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

