Return-Path: <stable+bounces-237790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJDAIX4b3mmFnAkAu9opvQ
	(envelope-from <stable+bounces-237790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:48:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 298BE3F8F18
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93A7F3008C39
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A623D6CB9;
	Tue, 14 Apr 2026 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WI5iYh5v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1WsNHaO/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3AA2E11D2;
	Tue, 14 Apr 2026 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163705; cv=none; b=nM60QV7usTiXS6EU4H4K9LsHOv6Vt0NvLNwwEQgto+Taa2CngE2LPyGm9Y4Fh5UKWkqqwAybauvFSZ/gJ7Zn7xNWWYpNCLGGV9grceVXtrQcHwA4hU8DpVh51dz88dNzmxO+4ruGr/jPLG0Q9V2Kvlo+5jB36Dx/m3416QVFoes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163705; c=relaxed/simple;
	bh=wO2FjUoo2Zr5O8u+CWxPk4AZQaSj/BQiaoY0B/4R92Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNjAvcymHsJWe24CpDke6AX2jEQJ3NyaH3f/oaRw8dhJfd8RsSonsCC+2mNi7QgrxGye1rYf0Qu+E6hR3H9QwN7Tnf/vxY07U96LHsJjwNkiFO4kkGM2Ik3YKjqICNts7yEcrTXZLHJGowJGFETo3w3OpVCWC12XuNzgEjSZoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WI5iYh5v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1WsNHaO/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Apr 2026 12:48:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776163700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/ni/9wGlEGu8QDmgTbpLutiXNiyQ8TUYcqJ+1VidqI=;
	b=WI5iYh5v6iMQfl8PMtyWUMX+Tjp1s0BkAzlHq8/MWZjjkBT4nHnTrR7KllbykXx+nlP7uk
	nKBlLJwgsQadKt9CTwButiuAWR9QxVp9FtvpoR3OdrngaDxbLcuib/f/89JJMZqnhEaAK+
	gbqJp4PWeUhtnCHEvzKeG08kpKmVpOv2j6kJx7INe0uC31CqxXDG/sphkKNfwWKWOtcaEh
	67ytNcR97jCcYH0fudd+aHK25ZLkTlVdIAd5mzgJtSttWTlLYAJggZwfdXTVZqop401QkR
	D5OX39Um3u1GqUccEZK07freqoXwcSIZlTGMmgOcjxotDdprXcrv9t2n2EKmEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776163700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/ni/9wGlEGu8QDmgTbpLutiXNiyQ8TUYcqJ+1VidqI=;
	b=1WsNHaO/UVAy+OlgKUwnHf9WGKZZMuXU+AWAJYx0wj0f1oZXRgogLn3DIqnrCPaRt4WZgr
	q08x8W4PukFtuMBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Nicolai Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
Message-ID: <20260414104819.1QtVAxc4@linutronix.de>
References: <20260408162535.98108-1-marex@nabladev.com>
 <20260412090141.21bf1534@kernel.org>
 <2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
 <20260412105125.48f0c58f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260412105125.48f0c58f@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237790-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nabladev.com,vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 298BE3F8F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-12 10:51:25 [-0700], Jakub Kicinski wrote:
> > 
> >    rt_spin_lock from ks8851_start_xmit_par+0x68/0x1a0
> >    ks8851_start_xmit_par from netdev_start_xmit+0x1c/0x40 <---- this 
> > tries to grab the same PAR spinlock, and deadlocks
> >    netdev_start_xmit from dev_hard_start_xmit+0xec/0x1b0
> >    dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
> >    sch_direct_xmit from __qdisc_run+0x20c/0x4fc
> >    __qdisc_run from qdisc_run+0x1c/0x28
> >    qdisc_run from net_tx_action+0x1f4/0x244
> >    net_tx_action from handle_softirqs+0x1c0/0x29c
> >    handle_softirqs from __local_bh_enable_ip+0xdc/0xf4
> >    __local_bh_enable_ip from __netdev_alloc_skb+0x140/0x194
> >    __netdev_alloc_skb from ks8851_irq+0x348/0x4d8 <---- this is called 
> > from ks8851_rx_pkts() via netdev_alloc_skb_ip_align()
> >    ks8851_irq from irq_thread_fn+0x24/0x64 <-------- this here runs with 
> > the PAR spinlock held
> > 
> > > The patch looks way to "advanced" for a driver. Something is going
> > > very wrong here. Or the commit message must be updated to explain
> > > it better to people like me. Or both.  
> > 
> > Does the backtrace make the problem clearer, with the annotation above ?
> 
> Sebastian, do you have any recommendation here? tl;dr is that the driver does
> 
> 	spin_lock_irqsave()
> 	__netdev_alloc_skb()
> 	spin_unlock_irqrestore()

So that is what happens in the backtrace. But not as of v7.0 if I look
at ks8851_irq():

|         if (status & IRQ_TXI) {
|                 unsigned short tx_space = ks8851_rdreg16(ks, KS_TXMIR);
|
|                 netif_dbg(ks, intr, ks->netdev,
|                           "%s: txspace %d\n", __func__, tx_space);
|
|                 spin_lock_bh(&ks->statelock);
disables bh

|                 ks->tx_space = tx_space;
|                 if (netif_queue_stopped(ks->netdev))
|                         netif_wake_queue(ks->netdev);
wakes queue, raise softirq, net-tx which does the qdisc_run() as seen in
the backtrace

|                 spin_unlock_bh(&ks->statelock);
enables bh and runs it
|         }

So this I understand and it would lead to a similar backtrace.
However this shouldn't occur from __netdev_alloc_skb(). 

> And __netdev_alloc_skb() does:
> 
> 	if (in_hardirq() || irqs_disabled()) {
> 		nc = this_cpu_ptr(&netdev_alloc_cache);
> 		data = page_frag_alloc(nc, len, gfp_mask);
> 		pfmemalloc = page_frag_cache_is_pfmemalloc(nc);
> 	} else {
> 		local_bh_disable();
> 		local_lock_nested_bh(&napi_alloc_cache.bh_lock);
> 
> 		nc = this_cpu_ptr(&napi_alloc_cache.page);
> 		data = page_frag_alloc(nc, len, gfp_mask);
> 		pfmemalloc = page_frag_cache_is_pfmemalloc(nc);
> 
> 		local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
> 		local_bh_enable();
> 	}
> 
> the local_bh_enable() seems to kick in BH processing inline,
> and BH processing takes the same spin lock the driver is already
> holding.

Yes, it does. But there is nothing between local_bh_disable() and
local_bh_enable() that raises the softirq. Looking at v6.9 there is the
following instead:

|                 spin_lock(&ks->statelock);
|                 ks->tx_space = tx_space;
|                 if (netif_queue_stopped(ks->netdev))
|                         netif_wake_queue(ks->netdev);
|                 spin_unlock(&ks->statelock);

So no _bh() here. So here netif_wake_queue() woke ksoftirqd to
handle it. _Later_ there is this alloc_skb which does
local_bh_disable()/ enable() and the latter will look at pending
softirqs. They are still set from before because ksoftirqd had no chance
processing them. And now you see the deadlock from within
__netdev_alloc_skb().

I *think* lockdep will yell here on RT.
Looking at current kernel from !RT perspective, this isn't good either.
We have:

| ks8851_irq
| {
|    ks8851_lock()
|       -> spin_lock_irqsave()
irqs are off

|    if (status & IRQ_TXI) {
|       spin_lock_bh(&ks->statelock);
|       if (netif_queue_stopped(ks->netdev))
|          netif_wake_queue(ks->netdev);
raise softirq
|       spin_unlock_bh(&ks->statelock);
bh enable with disabled interrupts. And __local_bh_enable_ip() has this
gem:

|void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
| {
|         WARN_ON_ONCE(in_hardirq());
|         lockdep_assert_irqs_enabled();
| #ifdef CONFIG_TRACE_IRQFLAGS
|         local_irq_disable();
| #endif

so lockep will yell if interrupts are disabled. And handle_softirqs()
will enable interrupts before handling softirqs and restore them later
on. But CONFIG_TRACE_IRQFLAGS will keep them enabled. Since the lock is
not acquired in hardirq, it has no other deadlock problem.

What I don't understand is why this is limited to PREEMPT_RT. !RT is
also affected by this:
- ks8851_irq() acquires the lock, disables interrupts
- netif_wake_queue() raises the softirq
- spin_unlock_bh(&ks->statelock) enables BH and handles softirqs, and
  goes to ks8851_start_xmit()

This is only possible in newer kernels due to  0913ec336a6c0 ("net:
ks8851: Fix deadlock with the SPI chip variant") because of the
irq_disabled() check in skb allocation.

So. Using _bh instead _irq remains my recommendation. Lockdep should
already yell on !RT here. 

Sebastian

