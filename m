Return-Path: <stable+bounces-267616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rhARFz/sOGp0kAcAu9opvQ
	(envelope-from <stable+bounces-267616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:03:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB54E6AD7B3
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:03:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="ok k9t4D";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267616-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267616-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A53FE301DE06
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AD38E5F9;
	Mon, 22 Jun 2026 08:02:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08436EAA6;
	Mon, 22 Jun 2026 08:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115323; cv=none; b=b413aUKD4QuGoRadXWO1lXywPvERS4N1XjKSLczXBi6NvcpuZY/5L4SPUP5WkaLi8bBgVJMTSLibvWsoOyCJV54Crhe2JLdCXpCZslyrD+JYHB/49+ANZ79wfiMorxCeSVqvIYeX3SfTxQnX9brNw2Hjoop/HZtJAoWhKdauiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115323; c=relaxed/simple;
	bh=9YcSQDgiIdeeJ5Q6A5OyXgluQjm6S2yxNJeBrtelcm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDr3IEms3rgX5Oqg72q2Gf9cOWBXcn2e8AH0fjjOa6CdNbDl6WVmfOIC3kvu0U8ay1s52RysciI+FEukg79Kj1AKQZBCrgtMrGnti/o6uWCWcAei5BQNtglO0HG/ZMgEo42AWGIpO3XjeKzouUYmBaHXM5yhbpbtDybm1j1nZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=okk9t4Df; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=aTh+kVZB6+gAPWFNfzyuI+EJqNKK1a/lt3CUQPy9Nng=; b=ok
	k9t4DfJzBHbCvaiZX0urkEZrmrub1EWvQw35Zan6erjLzqSodanFfjZ5MXgaOmCsc2CTj1I/Dcr5H
	GAW10W6sucnnIKyCYZ3JsqrI/gsiJjwacrsi1y7BK3E6rfRM1q7TaJpIIu73fF1NvQtusGxiB3HSW
	LzPvMlnDd4l/TRE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbZbI-008nRY-9V; Mon, 22 Jun 2026 10:01:48 +0200
Date: Mon, 22 Jun 2026 10:01:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: meth: check skb allocation in meth_init_rx_ring()
Message-ID: <d4b8eedd-5be4-46a8-a887-a06f80f1a293@lunn.ch>
References: <20260622044914.664749-1-haoxiang_li2024@163.com>
 <CALs4sv2dr2QsFU_DUDNAMgr4MDxHcRrHqer+Kdm7dP+4TUT0eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv2dr2QsFU_DUDNAMgr4MDxHcRrHqer+Kdm7dP+4TUT0eg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267616-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[163.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pavan.chebbi@broadcom.com,m:haoxiang_li2024@163.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB54E6AD7B3

On Mon, Jun 22, 2026 at 11:27:41AM +0530, Pavan Chebbi wrote:
> On Mon, Jun 22, 2026 at 10:20 AM Haoxiang Li <haoxiang_li2024@163.com> wrote:
> >
> > meth_init_rx_ring() does not check the return value of alloc_skb().
> > If the allocation fails, the NULL skb is passed to skb_reserve() and
> > then dereferenced through skb->head.
> >
> > Add check for alloc_skb() to prevent potential null pointer dereference.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> > ---
> >  drivers/net/ethernet/sgi/meth.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
> > index f7c3a5a766b7..ceff3cc937ad 100644
> > --- a/drivers/net/ethernet/sgi/meth.c
> > +++ b/drivers/net/ethernet/sgi/meth.c
> > @@ -228,6 +228,9 @@ static int meth_init_rx_ring(struct meth_private *priv)
> >
> >         for (i = 0; i < RX_RING_ENTRIES; i++) {
> >                 priv->rx_skbs[i] = alloc_skb(METH_RX_BUFF_SIZE, 0);
> > +               if (!priv->rx_skbs[i])
> > +                       return -ENOMEM;
> > +
> 
> I think the fix is not complete. The caller meth_open() will not free
> any successfully allocated skbs if the function ever returns -ENOMEM.

There is also the question, does anybody care? Are SGI machines still
used? This is a Fast Ethernet driver, written in 2003. It has no
Maintainer. Maybe it would be better to just remove the driver?

At least drop the Fixes: tag, it does not fit the Stable rules.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

    Andrew

---
pw-bot: cr

