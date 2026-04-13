Return-Path: <stable+bounces-236169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCoCL+AT3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E13EE474
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FF79301DDA4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E210826982C;
	Mon, 13 Apr 2026 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ddh2i9J3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7jBNdgY"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6223EA94;
	Mon, 13 Apr 2026 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096221; cv=none; b=tKJz5UGydpOfpAtBq5bLkyjkT0lT05BB8R/ILhaRLTWBS6NLlw0/H11mii3q2tdqIqaZbpC6cO0D2jQ0UaOqHgLdfmy0pduq1AU2p2tmpezudOuQDI8BZn4tvZ/9L6NWGHENa6iTsl4Yn2UlpYHoLPXbWPLgGAc3aqk1tmguuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096221; c=relaxed/simple;
	bh=G2CXw2SLjwLZ6+gB0Rd/7Gb+MbtT6y5L3W3UvM7TvLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO/yL3CxTAMRLapmMlVNQEANi9Be693oZUJbzWxVXIWX5urgOatXWVX34btrmnTaPXQUoQyeJ0ltzV/9AMuuhIjDSnNMgTVaask7Vz64BjPF7E3SW17pqtJ/KqvsK7cuiXULDnQF8VWzfGOe9i/2dgFI+a18v2c3hbKM2yOyI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ddh2i9J3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7jBNdgY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Apr 2026 18:03:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776096218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7wixSgYcfwa3G8B492QA+njgoCtE6VKMR6vlFAJy9Q=;
	b=Ddh2i9J30P+NUcII1LSZ8yW9ibZrnlwCnt1At5PLCNFVRdrrOf3g2XZq/K5Wqpu4j9GRnD
	73jHY6X8ctKV5dOBF/7U7ek/JLaOW4qVXVyUjr287MYCQJCnf6jDVdZ3DdaPNJNcSJPihq
	5YeNkbK0mIqTGxkhaM2CO1qYdqhpaY1FLgBkmj86xRMI3oslbBSOcinZvxeM3bHj4Tex8s
	v9YBE15F9NPHsenbNL6RbPw2hGx1SPwSGPj1iAqJYZPkoVUxEEnUrSqavSR3OOM4Bezj6L
	+BeVOoWPvIzPMJsgeR1Kc75Fg5VjTBC/wBUx1zIeTpGqZ8AmzrYZzzrroeEhrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776096218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7wixSgYcfwa3G8B492QA+njgoCtE6VKMR6vlFAJy9Q=;
	b=t7jBNdgY/uIbFT9BeRkOaCzVPocbMo5iRr616sGMruSj1FL4OUqOf5TEeEtzfCfgsK4AT4
	NM1PM8MYVDBJXjDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marek Vasut <marex@nabladev.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Nicolai Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
Message-ID: <20260413160336.GQCaw-1d@linutronix.de>
References: <20260408162535.98108-1-marex@nabladev.com>
 <20260412090141.21bf1534@kernel.org>
 <2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
 <20260412105125.48f0c58f@kernel.org>
 <20260413125744.TVKkZcEK@linutronix.de>
 <16fdeec9-9208-4c9b-b228-d6c6e045e116@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16fdeec9-9208-4c9b-b228-d6c6e045e116@nabladev.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236169-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D8E13EE474
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-13 17:31:34 [+0200], Marek Vasut wrote:
> > I don't see why it needs to disable interrupts.
> 
> Because when the lock is held, the PAR code shouldn't be interrupted by an
> interrupt, otherwise it would completely mess up the state of the KS8851
> MAC. The spinlock does not protect only the IRQ handler, it protects also
> ks8851_start_xmit_par() and ks8851_write_mac_addr() and
> ks8851_read_mac_addr() and ks8851_net_open() and ks8851_net_stop() and other
> sites which call ks8851_lock()/ks8851_unlock() which cannot be executed
> concurrently, but where BHs can be enabled.

I need check this once brain is at full power again. But which
interrupt? Your interrupt is threaded. So that should be okay.

> > ? This seems to be used by
> > the _par driver and the _common part. The comments refer to DMA but I
> > see only FIFO access.
> 
> The KS8851 does its own internal DMA into the SRAM, from which the data are
> copied by the driver into system DRAM.

So this no interrupt involved as "dma completed" and you do your manual
"memcpy".

> > And while at it, I would recommend to
> > 
> > diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
> > index 8048770958d60..f1c662887646c 100644
> > --- a/drivers/net/ethernet/micrel/ks8851_common.c
> > +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> > @@ -378,9 +378,12 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
> >   	if (status & IRQ_LCI)
> >   		mii_check_link(&ks->mii);
> > -	if (status & IRQ_RXI)
> > +	if (status & IRQ_RXI) {
> > +		local_bh_disable();
> >   		while ((skb = __skb_dequeue(&rxq)))
> >   			netif_rx(skb);
> > +		local_bh_enable();
> > +	}
> >   	return IRQ_HANDLED;
> >   }
> > 
> > Because otherwise it will kick-off backlog NAPI after every packet if
> > multiple packets are available.
> I think this patch will do the same, but the above should be done for the
> SPI part ?

Yes, both. This the SPI/ Mutex part does not matter. You inject one
packet into netif_rx() then if will add it to its internal NAPI and
schedule a softirq, process it. It would be more efficient to queue
multiple packets and process them all at the local_bh_enable() time.

Sebastian

