Return-Path: <stable+bounces-263615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vIdnGMLmMGoLYgUAu9opvQ
	(envelope-from <stable+bounces-263615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 08:01:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B323768C529
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 08:01:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=Z3SIhbGE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263615-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263615-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1692130F56F8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 06:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DE3DA5AB;
	Tue, 16 Jun 2026 06:00:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50253D966F;
	Tue, 16 Jun 2026 06:00:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589641; cv=none; b=Vfabqggxas+R8QH943tLaxhrG5btw8iugZH68NS3QV1z9iOU1g2y9r0Pl+Mf8QNIO5GuwYzVD+ItLSzAJ8VOS5/KYTujV+3ixrK7M7vRXauF+ZRG4+UFWR2O95lEUOQmx8VsRXnNSpxwKdfF56uEWFJ7Wy8LxY+O32/4jAJP27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589641; c=relaxed/simple;
	bh=1s8xyRggthOfIr+tZEQvs/TUoyUbGplXoUeBGWUzsDI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alNWr2gcIuAgBLdq86Y7rsd7SOKGZBvwdmG2lmTOOvVWB6dUoGK3EgxSe7gTWBVJPPjTiGZKNxUyQ5Qwq9TPOrIZadu4HxvFyly7gT5sF+UC7wbYMPf08HcjKUi+m8pFOhygKkAxthY8ladDlYnjrwuhMdwu/CaOhNTJXHrg4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Z3SIhbGE; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D945F20719;
	Tue, 16 Jun 2026 08:00:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9O2rAj6TuZI; Tue, 16 Jun 2026 08:00:37 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4A677206BC;
	Tue, 16 Jun 2026 08:00:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4A677206BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781589637;
	bh=x/KSMqSYUmdcUz4Qf9A4bh2jqAJ+K3ylX9vkl1sa48g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Z3SIhbGEvmtWXVH/Fy55g6BphDPzt5rfOkJ3lcyAc90yqbASx7Ooo1+1soMpI00Io
	 Z3KAf0TkKyvcRCjql3mGbuJkahDB8v0TXyzQ77BFhfay2eaKUNTdpppFXao01NXKbx
	 WoExUXP2CADnkdCwEiF4xkijpXxlomVx8vkcFMnLEbAp0KWqQFGOs2FvPr06NibePZ
	 y725WUBKqp+PexmiwcHhBNEYh21SpfwlheyM7d08SsSDiiUs+SqMI0AG3v+IrJZkXc
	 mVOzpLrLrCAdhfPVDGdiW7sWsyz13NkQK1mZaIoNtPDD012bZWNEYyCGWtKvb7jh2a
	 GkyORNmppRpvA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 08:00:36 +0200
Received: (nullmailer pid 1676227 invoked by uid 1000);
	Tue, 16 Jun 2026 06:00:36 -0000
Date: Tue, 16 Jun 2026 08:00:36 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Zijing Yin <yzjaurora@gmail.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net v2] net: af_key: initialize alg_key_len for IPComp
 states
Message-ID: <ajDmhG51u0iDcFei@secunet.com>
References: <20260608144453.3553219-1-yzjaurora@gmail.com>
 <aibn3tkGc3Iz1r5n@krikkit>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aibn3tkGc3Iz1r5n@krikkit>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263615-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,google.com,redhat.com,nvidia.com,kernel.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,secunet.com:dkim,secunet.com:mid,secunet.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:yzjaurora@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:idosch@nvidia.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B323768C529

On Mon, Jun 08, 2026 at 06:03:42PM +0200, Sabrina Dubroca wrote:
> note: fixes for IPsec should go to the "ipsec" tree, not net
> 
> 2026-06-08, 07:44:41 -0700, Zijing Yin wrote:
> > pfkey_msg2xfrm_state() handles the IPComp (SADB_X_SATYPE_IPCOMP) case by
> > allocating x->calg and copying only the algorithm name:
> > 
> > 	x->calg = kmalloc_obj(*x->calg);
> > 	if (!x->calg) {
> > 		err = -ENOMEM;
> > 		goto out;
> > 	}
> > 	strcpy(x->calg->alg_name, a->name);
> > 	x->props.calgo = sa->sadb_sa_encrypt;
> > 
> > Unlike the authentication (x->aalg) and encryption (x->ealg) branches of
> > the same function, the compression branch never initializes
> > calg->alg_key_len.  IPComp carries no key and the allocation only
> > reserves sizeof(struct xfrm_algo) (i.e. no room for a key), so the field
> > is left containing uninitialized slab data.
> > 
> > calg->alg_key_len is later used as a length by xfrm_algo_clone() when an
> > IPComp state is cloned during XFRM_MSG_MIGRATE:
> 
> The patch looks correct, but do we want to start fixing random bugs in
> code that we're trying to get rid of and that nobody actually uses?
> 
> If we do, then:
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

As long as we have the code in the repo, we do.

Applied, thanks everyone!

