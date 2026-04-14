Return-Path: <stable+bounces-237862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELcjC9053mkxpgkAu9opvQ
	(envelope-from <stable+bounces-237862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:58:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BE43FA39A
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11B9930252B8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64A3E63A2;
	Tue, 14 Apr 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sv7iUGM+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tvRFN1Za"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA512472B6;
	Tue, 14 Apr 2026 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171479; cv=none; b=p3fakYUW2eb/cc5pRwXscZwx/x8IR8NAXUyAd36TK7NLd+rFW6PvODLIX00bbQ2LCVj1xXLCWB1MsX8vhmTrNuJm0KufiioZdLgXSJYIwiS7xBMDXngd6kaCu+qJratpTIYGX56BxwDrVFWFEcToLb/Xq0fm5pqhdHDq0YAhT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171479; c=relaxed/simple;
	bh=e/0lHKOvgcWf2Zrk+6tNU9NIf7s+Ti5kJPa+Y10F3c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGCU6Mce4c0pGPzRxRF2K3FnF0XbuIB4lm8v3as5RNlEpDj65jLWgXT3qnsmE97XWZRANwKQSC+cgSYA1S0vEEas8sreks36kdJD7grL/tlFlzvn5DwJU05VJUFpdbr9YyDq9A911SE2WpkgD35OajCwBPrkLC0zYLwBkre6ZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sv7iUGM+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tvRFN1Za; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Apr 2026 14:57:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776171475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QvqkN2kc2jG1EPUl+z7gcg+ViG5hTylKgu0C0kIyBFw=;
	b=sv7iUGM+PIaP1kEvu78/0jATc16pPZxkEkVqQZFne/QoxQNxult2lE35N7syeHNBnT8STQ
	u3W85ycamJrJ+f8j+nmp7LvkHrpXuf9fc556jpIhE50hlivPqf4Um5Gs1kw/NwZxB9eoV8
	GT+l0lU6kkX+frqGKRB4U44x0ryOF8cyDXDO//k+bxyVCzoKZVsf5eP9AL7JAXXmpxKpCU
	7CiMF9BNg/WzFp4KVoMVpNR0hYyWy2C7Q/vVl0VPR+axx5L5FxiBC6zOLHaf2+rCFAp+x8
	pqa8Z9ZMYwQoBoPdUqC+VawVqmiuuFcMQnv8Y5xt2u9egFNvAesgQg4j0rzbKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776171475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QvqkN2kc2jG1EPUl+z7gcg+ViG5hTylKgu0C0kIyBFw=;
	b=tvRFN1ZahxnMVWRYZIEAAWBTytPbKkBcSO4aQmdKJeLvOfkM93B06XF7BmZrYuVgU+hjGF
	a7cKEiQC94bBu+BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs
 around IRQ handler
Message-ID: <20260414125753.Im6GAIHn@linutronix.de>
References: <20260414103327.113500-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414103327.113500-1-marex@nabladev.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237862-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,tipi-net.de,redhat.com,raritan.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:email]
X-Rspamd-Queue-Id: C6BE43FA39A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-14 12:32:52 [+0200], Marek Vasut wrote:
> If CONFIG_PREEMPT_RT=y is set AND the driver executes ks8851_irq() AND
> KSZ_ISR register bit IRQ_RXI is set AND ks8851_rx_pkts() detects that
> there are packets in the RX FIFO, then netdev_alloc_skb_ip_align() is
> called to allocate SKBs. If netdev_alloc_skb_ip_align() is called with
> BH enabled, local_bh_enable() at the end of netdev_alloc_skb_ip_align()
> will call __local_bh_enable_ip(), which will call __do_softirq(), which
> may trigger net_tx_action() softirq, which may ultimately call the xmit
> callback ks8851_start_xmit_par(). The ks8851_start_xmit_par() will try
> to lock struct ks8851_net_par .lock spinlock, which is already locked
> by ks8851_irq() from which ks8851_start_xmit_par() was called. This
> leads to a deadlock, which is reported by the kernel, including a trace
> listed below.

#1 [received RX packet and a] TX packet has been sent
#2 Driver enables TX queue via netif_wake_queue() which schedules TX
   softirq to queue packets for this device.
#2 After spin_unlock_bh(&ks->statelock) the pending softirqs will be
   processed
#3 This deadlocks because of recursive locking via ks8851_net::lock in
   ks8851_irq() and ks8851_start_xmit_par().

This is what happens since commit 0913ec336a6c0 ("net: ks8851: Fix
deadlock with the SPI chip variant"). Before that commit the softirq
execution will be picked up by netdev_alloc_skb_ip_align() and requires
PREEMPT_RT and a RX packet in #1 to trigger the deadlock.

> Fix the problem by disabling BH around critical sections, including the
> IRQ handler, thus preventing the net_tx_action() softirq from triggering
> during these critical sections. The net_tx_action() softirq is triggered
> at the end of the IRQ handler, once all the other IRQ handler actions have
> been completed.
> 
>  __schedule from schedule_rtlock+0x1c/0x34
>  schedule_rtlock from rtlock_slowlock_locked+0x548/0x904
>  rtlock_slowlock_locked from rt_spin_lock+0x60/0x9c
>  rt_spin_lock from ks8851_start_xmit_par+0x74/0x1a8
>  ks8851_start_xmit_par from netdev_start_xmit+0x20/0x44
>  netdev_start_xmit from dev_hard_start_xmit+0xd0/0x188
>  dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
>  sch_direct_xmit from __qdisc_run+0x1f8/0x4ec
>  __qdisc_run from qdisc_run+0x1c/0x28
>  qdisc_run from net_tx_action+0x1f0/0x268
>  net_tx_action from handle_softirqs+0x1a4/0x270
>  handle_softirqs from __local_bh_enable_ip+0xcc/0xe0
>  __local_bh_enable_ip from __alloc_skb+0xd8/0x128
>  __alloc_skb from __netdev_alloc_skb+0x3c/0x19c
>  __netdev_alloc_skb from ks8851_irq+0x388/0x4d4
>  ks8851_irq from irq_thread_fn+0x24/0x64
>  irq_thread_fn from irq_thread+0x178/0x28c
>  irq_thread from kthread+0x12c/0x138
>  kthread from ret_from_fork+0x14/0x28

The backtrace here and the description is based on an older kernel.
However

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Fixes: e0863634bf9f ("net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Sebastian

