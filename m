Return-Path: <stable+bounces-262641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gi1gNA95KmrpqAMAu9opvQ
	(envelope-from <stable+bounces-262641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 10:59:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFC16701D0
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 10:59:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=i3Jq1p6a;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262641-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262641-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872B53351A9B
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D238D404;
	Thu, 11 Jun 2026 08:54:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC174306741;
	Thu, 11 Jun 2026 08:54:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168088; cv=none; b=OYKcajN7actGjodmZBSsIrsCmmucoRyep5/6+qFb+aQ2CtTj+G4cC0WxOKcdSlmWNb0jrDfN4sDBPbAKwIZI1sH5Ssifr1Q6/TkCtCyTtdfPq9DfR5LcS67+ZabVfkPRKsJuxDrmt5ZAdXEfjMz5OH+kFZMdIcoUdTJE85o9lqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168088; c=relaxed/simple;
	bh=YEJZfy9QY46g+ae8XBphy5TsxEnOqLWMXGmzZNdOuew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYAnbOqPaWLveV1sKafop40vuHnam+bmXFrVdlutZ+VeM5SmpOwLDqocdS41sOdTM2ql+IzZjw2+OQBAlMz3IU+TAyBw9MYRZuqnuZAixFpFSiWU/NWbuzBM0TGZZpQB87oknw6Yj64kXo1h3Tx6JAByOBwSP/zgjoPuEJUMNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=i3Jq1p6a; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=m2ko7DiHoP+qaaPuL/wZDTmbNapXMc/WLpQKqkcamEI=; 
	b=i3Jq1p6aYT3AfIEqwa0vTvN7a5lE9AN9o58lx/tSsT5YSns+wAhFT8UD/YZCjDDKCXccxmi/aD9
	eOes8oqnh1KAtRhf4ZsfV7P5BZDj3/oFp6wO0e/HRcyHkFhe3wv1rHdy+tb8eXXzIud9xAAEEsB7F
	6+5kS4wNVrm58BPZ5MljeSzvMItojQVtdUYSFYAMBDqqVyPm/VUItAc/APV+f3WVz0FrMcjd9v4om
	rgn+Hm9vH/xzaK/7HTQDWvkh+Qf2AMseBCqmODjFLohnl2AuDjD3ASWVoaGUxayeJtA0lKsKljocI
	IjEUIUM/NRX8icg3DVp9ioCa8INy0iJSdYgg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXbBS-00000004Xd5-2VMv;
	Thu, 11 Jun 2026 16:54:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:54:42 +0800
Date: Thu, 11 Jun 2026 16:54:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: jiajie.ho@starfivetech.com, olivia@selenic.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwrng: jh7110: fix refcount leak in starfive_trng_read()
Message-ID: <aip30p1GyFsptpjQ@gondor.apana.org.au>
References: <20260603110327.3750514-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603110327.3750514-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262641-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:jiajie.ho@starfivetech.com,m:olivia@selenic.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email,vger.kernel.org:from_smtp,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CFC16701D0

On Wed, Jun 03, 2026 at 11:03:27AM +0000, Wentao Liang wrote:
> The starfive_trng_read() function acquires a runtime PM reference
> via pm_runtime_get_sync() but fails to release it on two error
> paths.  If starfive_trng_wait_idle() or starfive_trng_cmd() returns
> an error, the function exits without calling
> pm_runtime_put_sync_autosuspend(), leaving the runtime PM usage
> counter permanently elevated and preventing the device from entering
> runtime suspend.
> 
> Refactor the function to use a unified error path that calls
> pm_runtime_put_sync_autosuspend() before returning.
> 
> Cc: stable@vger.kernel.org
> Fixes: c388f458bc34 ("hwrng: starfive - Add TRNG driver for StarFive SoC")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/char/hw_random/jh7110-trng.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

