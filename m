Return-Path: <stable+bounces-237890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ7ID/dO3mndqAkAu9opvQ
	(envelope-from <stable+bounces-237890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:28:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C82B3FB318
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC04530CADCE
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A413E7141;
	Tue, 14 Apr 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="KeSBYpyx"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA23E6DC1;
	Tue, 14 Apr 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176455; cv=none; b=VgjbuQ0BFWh/uesmoCyckrPH3ELFWfkZDyO8K8cUmEPU2Ktrdza4XdZVe5G1Eh1t66d1QqXU8iZ2aQwViZrCd6vqZF409CQmXTz1xNAky5vhr2Oi+Dj4ADBmHYIC6wdf8U52b8SA5HfBwX0wCDyDi8s/wrOBYyjZNEtsk/cthvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176455; c=relaxed/simple;
	bh=B5dMtFOs6kq3A5Ov7eNkJuTcT6gEoY2pp8/XAmqnkbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAsrbgcAHCbGasmZngvYQIUB2qMzYrttxEOLb34VQ6czhk36jVp65ySmEaW9/rymckAcQlbz8uQihMjWMg+vKAW1h2S8aTaKhnl2OEWcytI7orP18CilFaneQKSVwGQwSgiOn3fceuGSkPEzYUybwHXmu2Mci9V9LUe9Lase6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=KeSBYpyx; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AA11112505;
	Tue, 14 Apr 2026 16:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776176451;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eNZ9AyAMBhe+pcTZPe0oBKKSK8EzT1VMTf3KG2FuHP4=;
	b=KeSBYpyxW3kiMDRjUSk2Aoskm2CggKEyq+vX+F+iXinaMMFTMY4Uf7a1S4RSga07ca/XY7
	IfNLm3t21Hsix0JnoqATkJl0N2WIW4w8aPWFDcOb2ezkxSVGFNkn+FB0WzJF8LNJUtn1j3
	l6QPwdUTRdOeY9AWgsLRBwmQcxgL1OnPAGI7jXt5ENhTeMAH/pRMIYEaA/KwwlUulPJVuN
	Q5/2+DrfpKmcOivpyVN7JmJFIJ3ob28ufcCLm9qqsfzuYhHFebGhOAwNOswubLRbdaWjLX
	YRWcJGDHymtsj6t12YZjhYvvJJjNWcOHdztB0Qq0MKF9ao07WV9SVDCZjaVY8Q==
Message-ID: <2fcfb84f-69f6-493e-94d6-95d85d8000f6@nabladev.com>
Date: Tue, 14 Apr 2026 16:20:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
 Paolo Abeni <pabeni@redhat.com>, Ronald Wahl <ronald.wahl@raritan.com>,
 Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
References: <20260414103327.113500-1-marex@nabladev.com>
 <20260414125753.Im6GAIHn@linutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260414125753.Im6GAIHn@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237890-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,tipi-net.de,redhat.com,raritan.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:mid]
X-Rspamd-Queue-Id: 9C82B3FB318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 2:57 PM, Sebastian Andrzej Siewior wrote:
> On 2026-04-14 12:32:52 [+0200], Marek Vasut wrote:
>> If CONFIG_PREEMPT_RT=y is set AND the driver executes ks8851_irq() AND
>> KSZ_ISR register bit IRQ_RXI is set AND ks8851_rx_pkts() detects that
>> there are packets in the RX FIFO, then netdev_alloc_skb_ip_align() is
>> called to allocate SKBs. If netdev_alloc_skb_ip_align() is called with
>> BH enabled, local_bh_enable() at the end of netdev_alloc_skb_ip_align()
>> will call __local_bh_enable_ip(), which will call __do_softirq(), which
>> may trigger net_tx_action() softirq, which may ultimately call the xmit
>> callback ks8851_start_xmit_par(). The ks8851_start_xmit_par() will try
>> to lock struct ks8851_net_par .lock spinlock, which is already locked
>> by ks8851_irq() from which ks8851_start_xmit_par() was called. This
>> leads to a deadlock, which is reported by the kernel, including a trace
>> listed below.
> 
> #1 [received RX packet and a] TX packet has been sent
> #2 Driver enables TX queue via netif_wake_queue() which schedules TX
>     softirq to queue packets for this device.
> #2 After spin_unlock_bh(&ks->statelock) the pending softirqs will be
>     processed
> #3 This deadlocks because of recursive locking via ks8851_net::lock in
>     ks8851_irq() and ks8851_start_xmit_par().
> 
> This is what happens since commit 0913ec336a6c0 ("net: ks8851: Fix
> deadlock with the SPI chip variant"). Before that commit the softirq
> execution will be picked up by netdev_alloc_skb_ip_align() and requires
> PREEMPT_RT and a RX packet in #1 to trigger the deadlock.

Do you want me to add this into the V4 commit message ?

>> Fix the problem by disabling BH around critical sections, including the
>> IRQ handler, thus preventing the net_tx_action() softirq from triggering
>> during these critical sections. The net_tx_action() softirq is triggered
>> at the end of the IRQ handler, once all the other IRQ handler actions have
>> been completed.
>>
>>   __schedule from schedule_rtlock+0x1c/0x34
>>   schedule_rtlock from rtlock_slowlock_locked+0x548/0x904
>>   rtlock_slowlock_locked from rt_spin_lock+0x60/0x9c
>>   rt_spin_lock from ks8851_start_xmit_par+0x74/0x1a8
>>   ks8851_start_xmit_par from netdev_start_xmit+0x20/0x44
>>   netdev_start_xmit from dev_hard_start_xmit+0xd0/0x188
>>   dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
>>   sch_direct_xmit from __qdisc_run+0x1f8/0x4ec
>>   __qdisc_run from qdisc_run+0x1c/0x28
>>   qdisc_run from net_tx_action+0x1f0/0x268
>>   net_tx_action from handle_softirqs+0x1a4/0x270
>>   handle_softirqs from __local_bh_enable_ip+0xcc/0xe0
>>   __local_bh_enable_ip from __alloc_skb+0xd8/0x128
>>   __alloc_skb from __netdev_alloc_skb+0x3c/0x19c
>>   __netdev_alloc_skb from ks8851_irq+0x388/0x4d4
>>   ks8851_irq from irq_thread_fn+0x24/0x64
>>   irq_thread_fn from irq_thread+0x178/0x28c
>>   irq_thread from kthread+0x12c/0x138
>>   kthread from ret_from_fork+0x14/0x28
> 
> The backtrace here and the description is based on an older kernel.
> However
I actually did update the backtrace in V3 with the one from current next 
20260413 .

