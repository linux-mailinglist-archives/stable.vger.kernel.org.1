Return-Path: <stable+bounces-235836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHhCCKXb22lMHgkAu9opvQ
	(envelope-from <stable+bounces-235836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:51:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D973E53C5
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4F63010532
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C943358C6;
	Sun, 12 Apr 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kbx+DzDP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F562BE057;
	Sun, 12 Apr 2026 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016288; cv=none; b=qNuphX0bCUIahf5S246SgSnUYWoUOHJ4mu2nu1ry0I96p4ZoH7Ec5bNvwmzPS+S7f4HL7Do7HlMfvKnDvNOmHIdZ8gQhtyBkK8bdhd+I0hhUWbBVXQIrHjRIfrvQviz34vCU19HkbUbhhvLm9La0En6gh1dudsA4xSkn0+5v7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016288; c=relaxed/simple;
	bh=cmCE9mhMOGi9q+/jfxHcwxJG2DOOS41bwAlubEISatM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgjPy8pDDEJiDFQJ/8fV5F2M9GhfAyk4pkDfw4de2ykMVM/ham7VZtCjFlCT8WYx/OrYMi9/saw5Fc/fa9MZk9QSaQEGY2A1iEZI+kI/WNLkGtTdPRhGPGZVYzXGUnRaGvDUh1pxYnLSoJWasLOs+btMtePiJZG31pyhPZ1zzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kbx+DzDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12916C19424;
	Sun, 12 Apr 2026 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016287;
	bh=cmCE9mhMOGi9q+/jfxHcwxJG2DOOS41bwAlubEISatM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kbx+DzDPM2Gz5qPuSDNAY/rVfcP8ccE2lyYR1GW3Q6bpOq949KSU2o+I5dm5htrF7
	 KQChOSAvHG+skK2Ik4nSqkO9lGLojMB5bQGaSaGW8m7iTNlM8NEQOZmHIKoWG/tn8d
	 mQ1blSOaUWn+ZzNc7nBDW+QAJTYT2g3uwrws+XsK9Z4HgT2u/tI5cYkxgMBMmWr4u1
	 EusfGH9qEi7sCyauDDV3tR+DS4bYWXbArQ17pzRBot/MWcn22BClxa2VtVpMtkTVxl
	 AaGj9uSTCwJO0JlKxizMCXY5gtNtP0tyWjMz/x+zTUHA5v9NxPxBWU0q11KSQbW/6y
	 jtBq2dQaDZfzA==
Date: Sun, 12 Apr 2026 10:51:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marek Vasut <marex@nabladev.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Nicolai
 Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>, Ronald Wahl
 <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
Message-ID: <20260412105125.48f0c58f@kernel.org>
In-Reply-To: <2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
References: <20260408162535.98108-1-marex@nabladev.com>
	<20260412090141.21bf1534@kernel.org>
	<2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235836-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[nabladev.com,vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 55D973E53C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 18:27:28 +0200 Marek Vasut wrote:
> On 4/12/26 6:01 PM, Jakub Kicinski wrote:
> > On Wed,  8 Apr 2026 18:24:58 +0200 Marek Vasut wrote:  
> >> If CONFIG_PREEMPT_RT=y is set AND the driver executes ks8851_irq() AND
> >> KSZ_ISR register bit IRQ_RXI is set AND ks8851_rx_pkts() detects that
> >> there are packets in the RX FIFO, then netdev_alloc_skb_ip_align() is
> >> called to allocate SKBs. If netdev_alloc_skb_ip_align() is called with
> >> BH enabled, local_bh_enable() at the end of netdev_alloc_skb_ip_align()
> >> will call __local_bh_enable_ip(), which will call __do_softirq(), which
> >> may trigger net_tx_action() softirq, which may ultimately call the xmit
> >> callback ks8851_start_xmit_par(). The ks8851_start_xmit_par() will try
> >> to lock struct ks8851_net_par .lock spinlock, which is already locked
> >> by ks8851_irq() from which ks8851_start_xmit_par() was called. This
> >> leads to a deadlock, which is reported by the kernel, including a trace
> >> listed below.  
> > 
> > lock_par is a spinlock, and AFAIU softirqs run in their on thread on RT.
> > I'm not following.  
> 
> Please look at the backtrace in the commit message, this part, please 
> read from bottom to top to observe the failure in chronological order. 
> It does not seem the handle_softirqs() is running in its own thread, 
> separate from the IRQ thread ?
> 
>    rt_spin_lock from ks8851_start_xmit_par+0x68/0x1a0
>    ks8851_start_xmit_par from netdev_start_xmit+0x1c/0x40 <---- this 
> tries to grab the same PAR spinlock, and deadlocks
>    netdev_start_xmit from dev_hard_start_xmit+0xec/0x1b0
>    dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
>    sch_direct_xmit from __qdisc_run+0x20c/0x4fc
>    __qdisc_run from qdisc_run+0x1c/0x28
>    qdisc_run from net_tx_action+0x1f4/0x244
>    net_tx_action from handle_softirqs+0x1c0/0x29c
>    handle_softirqs from __local_bh_enable_ip+0xdc/0xf4
>    __local_bh_enable_ip from __netdev_alloc_skb+0x140/0x194
>    __netdev_alloc_skb from ks8851_irq+0x348/0x4d8 <---- this is called 
> from ks8851_rx_pkts() via netdev_alloc_skb_ip_align()
>    ks8851_irq from irq_thread_fn+0x24/0x64 <-------- this here runs with 
> the PAR spinlock held
> 
> > The patch looks way to "advanced" for a driver. Something is going
> > very wrong here. Or the commit message must be updated to explain
> > it better to people like me. Or both.  
> 
> Does the backtrace make the problem clearer, with the annotation above ?

Sebastian, do you have any recommendation here? tl;dr is that the driver does

	spin_lock_irqsave()
	__netdev_alloc_skb()
	spin_unlock_irqrestore()

And __netdev_alloc_skb() does:

	if (in_hardirq() || irqs_disabled()) {
		nc = this_cpu_ptr(&netdev_alloc_cache);
		data = page_frag_alloc(nc, len, gfp_mask);
		pfmemalloc = page_frag_cache_is_pfmemalloc(nc);
	} else {
		local_bh_disable();
		local_lock_nested_bh(&napi_alloc_cache.bh_lock);

		nc = this_cpu_ptr(&napi_alloc_cache.page);
		data = page_frag_alloc(nc, len, gfp_mask);
		pfmemalloc = page_frag_cache_is_pfmemalloc(nc);

		local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
		local_bh_enable();
	}

the local_bh_enable() seems to kick in BH processing inline,
and BH processing takes the same spin lock the driver is already
holding.


