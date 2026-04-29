Return-Path: <stable+bounces-241846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEIDOWnE8WkbkQEAu9opvQ
	(envelope-from <stable+bounces-241846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:42:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A3C491492
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C0F8302BBB9
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B963B635A;
	Wed, 29 Apr 2026 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mMW/Lj+t"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B72BE7DD;
	Wed, 29 Apr 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452129; cv=none; b=jIFWhyFte6IgZcWvH83tXs27HhMzEAZ/tsJKS+YHKDDy1fAL9HtwZEHCxxia8Gi0tfG1zroZI+7X71VQOaZG4Tnt3Vr8nWqffQjkQ4EFVxB6zdeIWFscnOtMUJyZFKQp+JAh/H8wJd9+xX28q1hfRHw1q/a+i2KU7jiWI2z54/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452129; c=relaxed/simple;
	bh=1l7in8zeLJb3WLLG96ZWQEqhSEXb02kXlEWrTzGO3ko=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDO6YQ/18KjRUu+AlOARKgTJ0o4hCHOLbDAw3sugA1bs4U2FpLwG/57Uqg5oyXexudjE0p325NRXk3kW6t50BjZ9EQrbE443fpsZ/ewn/dkSL4GCGV3X5mWTLgQ5amqD3YIWlMkgiev7wVKbZ4b9FdhOraP1cxpkvqeC6gafjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mMW/Lj+t; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DE9E820610;
	Wed, 29 Apr 2026 10:42:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HlNuacS5KQJ1; Wed, 29 Apr 2026 10:42:04 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 511D220539;
	Wed, 29 Apr 2026 10:42:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 511D220539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777452124;
	bh=APAP52bCnfYyyh4yfSwYKwAJFaexzWcXnqOwfXmcTYk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=mMW/Lj+tu7xmWAyO41RRY2F9gdKriCeV5RMwQKj9zT6XKQ+EvtRBj/INYJZuYahH+
	 fHIBcWzQGQXfmBjad08lQlgjrAEOFMizzqoLi4Fqsg7Uaoo9i8HA3fiaIp+Eyi/y0S
	 vrRZrP//nkfEF/Bk8u9+C0O6Y8lxen6nMtYpSqpG+NyKSZZiLc48Ngs9K+Tncaxw+5
	 QzSpvRmBkasK6R9cGLlNDRLlkgOFggDlZJfpiOwwn8R97Ac1PCTvxS9YsUl1yp4hB4
	 VaFOgEfkh2yWduxVbj47S2OBElFC2n2Xz+mSPElN2X8ZZf7nSRDIRcvMMg3BoEzBsk
	 4x1ZX/rxHgf9w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 10:42:03 +0200
Received: (nullmailer pid 1233961 invoked by uid 1000);
	Wed, 29 Apr 2026 08:42:02 -0000
Date: Wed, 29 Apr 2026 10:42:02 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Michal Kosiorek <mkosiorek121@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	<sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] xfrm: protect __xfrm_state_delete against double-unhash
 of byseq/byspi
Message-ID: <afHEWqYEiA07An7W@secunet.com>
References: <CAFRy_Hg8O9smcwzWTdBn6j6NLwv+8vBXKtm2KTsOoG1CjxC2Dg@mail.gmail.com>
 <afGug2nzdfjEGHxO@secunet.com>
 <CAFRy_HgkpfzxtJEJWRa=wfJ+m_++FbGsaezywRXQWt7uhkKoTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFRy_HgkpfzxtJEJWRa=wfJ+m_++FbGsaezywRXQWt7uhkKoTQ@mail.gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 44A3C491492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241846-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Wed, Apr 29, 2026 at 10:29:10AM +0200, Michal Kosiorek wrote:
...
> 
> Fixes: fe9f1d8779cb ("xfrm: add state hashtable keyed by seq")
> Fixes: 7b4dc3600e48 ("[XFRM]: Do not add a state whose SPI is zero to
> the SPI hash.")
> Reported-by: Michal Kosiorek <mkosiorek121@gmail.com>
> Tested-by: Michal Kosiorek <mkosiorek121@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michal Kosiorek <mkosiorek121@gmail.com>
> ---
>  net/xfrm/xfrm_state.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 1748d374abca..686014d39429 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -818,17 +818,17 @@ int __xfrm_state_delete(struct xfrm_state *x)
> 
>   spin_lock(&net->xfrm.xfrm_state_lock);
>   list_del(&x->km.all);
> - hlist_del_rcu(&x->bydst);
> - hlist_del_rcu(&x->bysrc);
> - if (x->km.seq)
> - hlist_del_rcu(&x->byseq);
> + hlist_del_init_rcu(&x->bydst);
> + hlist_del_init_rcu(&x->bysrc);
> + if (!hlist_unhashed(&x->byseq))
> + hlist_del_init_rcu(&x->byseq);
>   if (!hlist_unhashed(&x->state_cache))
>   hlist_del_rcu(&x->state_cache);
>   if (!hlist_unhashed(&x->state_cache_input))
>   hlist_del_rcu(&x->state_cache_input);
> 
> - if (x->id.spi)
> - hlist_del_rcu(&x->byspi);
> + if (!hlist_unhashed(&x->byspi))
> + hlist_del_init_rcu(&x->byspi);
>   net->xfrm.state_num--;
>   xfrm_nat_keepalive_state_updated(x);
>   spin_unlock(&net->xfrm.xfrm_state_lock);

This looks still odd, the indentation seems to be wrong.
It does not apply, maybe your mail client malformed
the patch.

