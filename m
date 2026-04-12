Return-Path: <stable+bounces-235828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGDqMgjI22lHGgkAu9opvQ
	(envelope-from <stable+bounces-235828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:27:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0DA3E4C93
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDD2C300A754
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8577280CE5;
	Sun, 12 Apr 2026 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="LtQ7UezQ"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44440DFA7;
	Sun, 12 Apr 2026 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011262; cv=none; b=Kq9ci5FVRBOO6ARkPircn8n0oLMl/ibGWBwHRVJFbEWF2xtJEga7/PdHdc5R7rRqFNJSWFUT7GZlb5XyLtWtlWYavvYosVFUoNWBDW0oWCRAtGdxwvsOsKTnH74Naui2SBAMWI24CS+fPBKShNCJASsy4SC99AqtircjXX6rnVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011262; c=relaxed/simple;
	bh=9CZMM9VbvUCyJ3qeq+V4AcOepGFJDBR8tfyYLaGssQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGfPU+hSflpS/7fFB5V2Vr10fsyudNQyRCRAunyg1WhgW3ZOldXs6osRVe+WNrtMJHl3hutjPLwh0ad9mInaQ18Lt8h9k4A5dE/P0KDbRV+dyuku8Ceoh8TTBVqJjy0RCRs+cJPLWQZBlAv/FM9btoj8GSQMfzxqbtX8nzhl8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=LtQ7UezQ; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8DF37113429;
	Sun, 12 Apr 2026 18:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776011251;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0NYa0jP3cikU+1ExhmPnO8DZT/iS3QqyhXN/TSWhpDo=;
	b=LtQ7UezQwWpOGrBIyrqitZXrDRINLEa4TwW5CSHegvZvJllsS7hc/kqJkQP/IpN18OsFdH
	xFedq1iycWjdid78ZVmqjRN2+Vh1no+RVnMF2BIt6Cpmyi3tdTmYLD2nnPzhrfgk/rdj/f
	3npweXkjesanNhsUN2uATw+PCk2vuuAjHXgVX5O+ZRekp/DwJaozDNY4sONDYWFeQF4EZp
	L8U3y+FoahT5A/PZuzKFYPfC/T1FWOtN+DKzjK+GqH1JRXs0yfi3XA1Px5335SDM7jDHub
	8sawTmA2YYwV/egi6XiwgNLJCaTugqYpsJ23a9DmDI7RitnQo0KozIcT2t6EgQ==
Message-ID: <2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
Date: Sun, 12 Apr 2026 18:27:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260408162535.98108-1-marex@nabladev.com>
 <20260412090141.21bf1534@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260412090141.21bf1534@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235828-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B0DA3E4C93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/12/26 6:01 PM, Jakub Kicinski wrote:
> On Wed,  8 Apr 2026 18:24:58 +0200 Marek Vasut wrote:
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
> lock_par is a spinlock, and AFAIU softirqs run in their on thread on RT.
> I'm not following.

Please look at the backtrace in the commit message, this part, please 
read from bottom to top to observe the failure in chronological order. 
It does not seem the handle_softirqs() is running in its own thread, 
separate from the IRQ thread ?

   rt_spin_lock from ks8851_start_xmit_par+0x68/0x1a0
   ks8851_start_xmit_par from netdev_start_xmit+0x1c/0x40 <---- this 
tries to grab the same PAR spinlock, and deadlocks
   netdev_start_xmit from dev_hard_start_xmit+0xec/0x1b0
   dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
   sch_direct_xmit from __qdisc_run+0x20c/0x4fc
   __qdisc_run from qdisc_run+0x1c/0x28
   qdisc_run from net_tx_action+0x1f4/0x244
   net_tx_action from handle_softirqs+0x1c0/0x29c
   handle_softirqs from __local_bh_enable_ip+0xdc/0xf4
   __local_bh_enable_ip from __netdev_alloc_skb+0x140/0x194
   __netdev_alloc_skb from ks8851_irq+0x348/0x4d8 <---- this is called 
from ks8851_rx_pkts() via netdev_alloc_skb_ip_align()
   ks8851_irq from irq_thread_fn+0x24/0x64 <-------- this here runs with 
the PAR spinlock held

> The patch looks way to "advanced" for a driver. Something is going
> very wrong here. Or the commit message must be updated to explain
> it better to people like me. Or both.

Does the backtrace make the problem clearer, with the annotation above ?

