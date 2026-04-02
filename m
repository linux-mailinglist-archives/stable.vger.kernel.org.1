Return-Path: <stable+bounces-232979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNCyBvdKzmmgmgYAu9opvQ
	(envelope-from <stable+bounces-232979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:54:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99336387F6C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A45A3013AA7
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4038F93D;
	Thu,  2 Apr 2026 10:54:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF48318B96;
	Thu,  2 Apr 2026 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127280; cv=none; b=m1XXr7Zi5v6XrPb6WKcK74ZJTIhxTu2eDFrTYZsYT28NUUhrA+M16a7iwGT7HQ+hkYqwWjCy43Il52WZkbp8aEgEpXJvJHi5ybBIO3+9b4AQSpSFmT5cz/2AxMnoWJHFuyI5X0F6P4ZIdjw9VyF2xMd0Th+KNLRwjUhI/HcnSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127280; c=relaxed/simple;
	bh=f4GmkTCi9WzElXJDSYzjJf/HkpEIPRRzLzh9TGwLvW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc3UXp5V/rnzwYXGOfvw+38oIves64LV6YXUHUgZF2JGoO1dwxhY75953bgFH83nTJCqeB7WnwQmsNnkDjJC3DiVqEpWwHLFalwfmNRsRtncl+EqbqPmQDuYD+Tnb+DYURT3D/mcoAXuBndkv9MZf+W6I2+4zDPRtx1ymCDOsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id AD011608B3; Thu, 02 Apr 2026 12:54:35 +0200 (CEST)
Date: Thu, 2 Apr 2026 12:54:37 +0200
From: Florian Westphal <fw@strlen.de>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Qi Tang <tpluszz77@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] xfrm: delay dev_put in xfrm_input to after transport
 reinject
Message-ID: <ac5K7S3dBsINFafg@strlen.de>
References: <20260331092737.1937-1-tpluszz77@gmail.com>
 <ac5GnMeqSeNlzBp7@secunet.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac5GnMeqSeNlzBp7@secunet.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232979-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:email,strlen.de:mid]
X-Rspamd-Queue-Id: 99336387F6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Steffen Klassert <steffen.klassert@secunet.com> wrote:
> On Tue, Mar 31, 2026 at 05:27:37PM +0800, Qi Tang wrote:
> >  int xfrm4_transport_finish(struct sk_buff *skb, int async)
> >  {
> >  	struct xfrm_offload *xo = xfrm_offload(skb);
> > @@ -74,7 +96,8 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
> >  
> >  	NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
> >  		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
> > -		xfrm4_rcv_encap_finish);
> > +		async ? xfrm4_rcv_encap_finish_async :
> > +			xfrm4_rcv_encap_finish);
> 
> What happens if the PRE_ROUTING hook returns NF_DROP, NF_QUEUE, or
> NF_STOLEN before the okfn runs? Looks like we leak the dev refcnt
> then.

Yes, no okfn is run in those cases.
I'd suggest do drop the refcount after NF_HOOK, i.e. something like:

dev = skb->dev;

NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
...
if (async)
	dev_put(dev);

Thats easier to follow.

