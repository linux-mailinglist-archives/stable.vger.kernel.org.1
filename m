Return-Path: <stable+bounces-233812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAAeCKAJ1mlnAwgAu9opvQ
	(envelope-from <stable+bounces-233812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:54:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4633B89A6
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63F7A3051A96
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DB5397E61;
	Wed,  8 Apr 2026 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="SELL1tTO"
X-Original-To: stable@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE3396B91;
	Wed,  8 Apr 2026 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634668; cv=none; b=oW8ANZ9/bzHHkSbw5LVBbmSd4BZfYHKw/6uPT/uaK1sBZfX9g7LVYa1dVnw6He9Yzzgap4aS/S4GM35wpdfabTmqam2rRjVQUJb/jOScXRgM1aY3z5wxM0LB5xhAsNwwECz48pq6SktQHHBUFQRoc1Ub0tbOp452CkM2yEi7q6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634668; c=relaxed/simple;
	bh=uMX7cTSquH9bxls2joBp2SY4uUxTFOoB48ikknbF4GM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qFdqqqYApRcVRI51I/m7muUAuXWAkf6zBe9+p7alqD9Rd9M7swhOMBD8rzShIMXSdBTLy2Y/hLRgVEXW+XVVCv3KGFuBuSstBhbNiyP8oVxCeG3eLigzLH/xuUvOR4iuvMrayCuzvHTC9DCm4+KQKcoxA6tlx5yUAonAyKZE4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=SELL1tTO; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D4ABA5884;
	Wed,  8 Apr 2026 09:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775634664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XKxP0eM+E8RMBq0MUnzOFAZbFCvAKCeCZ8ebWegyIKQ=;
	b=SELL1tTO+klnMV/NGb0DQf4TI/mSjTSWVqdCeOKyxcoQrTN/Im72miPrvn/sABkS2jHivo
	j1o6oAkGEQV4FpnH1UFlIEVV7XnZZQ3xODDf4H5//Vzs+wSFXCFMZn4cnbcjXnGrujtBx0
	LARHwcS4zw0ELYRH/Upz5Jh+Td0soFwgqcGuqVEj+J3jud6tVL0sQzZEREdr4Cjx0K77FD
	SGj2z6rdDrNhEsPf6wHSxfzkC43CFS/o0cUjQFNtUCJpDbaj8hrlyLDZt39ieTEvgkLmcy
	1DAtWecUSgw4SdcdnDNGWi8W0lz/MUbS1hddUIcrBlU/VRx82wVJiRUmM7xp2Q==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 08 Apr 2026 09:51:02 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui
 <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
In-Reply-To: <20260407212344.80265-1-marex@nabladev.com>
References: <20260407212344.80265-1-marex@nabladev.com>
Message-ID: <fec257469a693e5df7f5739740c1764c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233812-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,redhat.com,raritan.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,nabladev.com:email,raritan.com:email,davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 8A4633B89A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 7.4.2026 23:23, Marek Vasut wrote:
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
> 
> Fix the problem by disabling BH around the IRQ handler, thus preventing
> the net_tx_action() softirq from triggering during the IRQ handler. The
> net_tx_action() softirq is now triggered at the end of the IRQ handler,
> once all the other IRQ handler actions have been completed.
> 
>   __schedule from schedule_rtlock+0x1c/0x34
>   schedule_rtlock from rtlock_slowlock_locked+0x538/0x894
>   rtlock_slowlock_locked from rt_spin_lock+0x44/0x5c
>   rt_spin_lock from ks8851_start_xmit_par+0x68/0x1a0
>   ks8851_start_xmit_par from netdev_start_xmit+0x1c/0x40
>   netdev_start_xmit from dev_hard_start_xmit+0xec/0x1b0
>   dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
>   sch_direct_xmit from __qdisc_run+0x20c/0x4fc
>   __qdisc_run from qdisc_run+0x1c/0x28
>   qdisc_run from net_tx_action+0x1f4/0x244
>   net_tx_action from handle_softirqs+0x1c0/0x29c
>   handle_softirqs from __local_bh_enable_ip+0xdc/0xf4
>   __local_bh_enable_ip from __netdev_alloc_skb+0x140/0x194
>   __netdev_alloc_skb from ks8851_irq+0x348/0x4d8
>   ks8851_irq from irq_thread_fn+0x24/0x64
>   irq_thread_fn from irq_thread+0x110/0x1dc
>   irq_thread from kthread+0x104/0x10c
>   kthread from ret_from_fork+0x14/0x28
> 
> Fixes: e0863634bf9f ("net: ks8851: Queue RX packets in IRQ handler 
> instead of disabling BHs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Ronald Wahl <ronald.wahl@raritan.com>
> Cc: Yicong Hui <yiconghui@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/ethernet/micrel/ks8851_common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c 
> b/drivers/net/ethernet/micrel/ks8851_common.c
> index 8048770958d60..dadedea016fac 100644
> --- a/drivers/net/ethernet/micrel/ks8851_common.c
> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> @@ -316,6 +316,7 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
>  	unsigned int status;
>  	struct sk_buff *skb;
> 
> +	local_bh_disable();
>  	ks8851_lock(ks, &flags);

I suspect this breaks the SPI variant on non-RT since
ks8851_lock_spi() uses mutex_lock() which can't sleep with
BH disabled. I have KS8851 SPI hardware and will test, will
get back to you.

> 
>  	status = ks8851_rdreg16(ks, KS_ISR);
> @@ -381,6 +382,7 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
>  	if (status & IRQ_RXI)
>  		while ((skb = __skb_dequeue(&rxq)))
>  			netif_rx(skb);
> +	local_bh_enable();
> 
>  	return IRQ_HANDLED;
>  }

Thanks
Nicolai

