Return-Path: <stable+bounces-272269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v95pCSTJS2rvaAEAu9opvQ
	(envelope-from <stable+bounces-272269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 17:26:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1261712902
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 17:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=rhrMiT2P;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=pIzjfy3t;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272269-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272269-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2469D30432C7
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 15:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DCE37F725;
	Mon,  6 Jul 2026 15:04:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEC37C93C;
	Mon,  6 Jul 2026 15:04:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350268; cv=none; b=ItQUrnnU+Ov/aQ08zWmvINaFSRV+z05FxK2E06Fciy8WPeqsJKVHXjT4M5+MBG4LKRcZCjFCZbtrcKy6URkcb+qx4TM1eQfgzxLf7rDM4wrgkauzoDiuRx/LZVoOxQNtSEL/0X5uFH9AatRQhfmC0G+XCL0rTQbNt9NoU0Hnme8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350268; c=relaxed/simple;
	bh=owEWpGSXcs6lwNMZKNUKIE+uhW1e3WdbBPjtlGXJ2bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVomlAPDdlg6dVmiApu9fjWyZFF5Jd6nUoIDoivegzUasAmveKpPOYNkMLn8nc771fXcgGZeSqKtk1HRuytmJf2EGBK7t1A8mAdP7OBJpikOBXHD7JZcehgOYTvru7VjVWGxfwFrYXXXXTS2UJAC6jcmoVR19gWhc/pjSlKwm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhrMiT2P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pIzjfy3t; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 6 Jul 2026 17:04:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783350263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4njRJkRCW35+KyLFk1zAgC1OeVYPM6ryxzAWbeONMc=;
	b=rhrMiT2PmX9/0Oe9XdAkb+mhGvw5jTQ/1XIpHOFK3jzTRgbEmlHSm7FdHaiaBqTVrHNnaN
	G5V37zDmAANuKcxH+ihraLoZrn14iNJZ+b6cDqau5mDQ9i7lnuroM0u/K59sts6gPtHOq8
	56mTAw8ADyWE4rn2C/jyGK9OqQmy3TC6PQh7Mvv/l6MbACMhtCaufmYsOlFUkhOv+lQVOU
	uhSDy5AleTGjRTHr5rMoL51+B2Ze271JFeEPnmGiNWiYNLgRbDcg5HiiH2hv+mNM9h9K+l
	kV6CRMKe4tWwKQEI4GqQTmqyuBEshm8s82fs3jAdZKRNzmCF1Kc5R+6USm2mCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783350263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4njRJkRCW35+KyLFk1zAgC1OeVYPM6ryxzAWbeONMc=;
	b=pIzjfy3twjMvHZA3jYwSADJCqrxEkARhAMmXHlMFg5VUTFk9dX1maw1076msHlHe76tkzU
	NkUex8lhFcRbOBCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: christian.taedcke@weidmueller.com
Cc: christian.taedcke-oss@weidmueller.com,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>, Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the TX
 ring on link-up
Message-ID: <20260706150422.-wYiCBuE@linutronix.de>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272269-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke@weidmueller.com,m:christian.taedcke-oss@weidmueller.com,m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:haokexin@gmail.com,m:horms@kernel.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:robert.hancock@calian.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[weidmueller.com,bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,goodmis.org,calian.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,weidmueller.com:email,linutronix.de:from_mime,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1261712902

On 2026-07-06 16:02:14 [+0200], Christian Taedcke via B4 Relay wrote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> 
> gem_shuffle_tx_one_ring() rotates the software TX ring so that the
> tail sits at index 0 and resets queue->tx_tail to 0, but it never
> reprograms the hardware transmit buffer queue pointer (TBQP). Other
> paths that reset tx_tail to the ring base (macb_init_buffers() and
> macb_tx_error_task()) also reprogram TBQP to queue->tx_ring_dma; this
> path does not, leaving TBQP pointing at a stale descriptor.
> 
> gem_shuffle_tx_rings() runs on every link-up from
> macb_mac_link_up(). After a few link up/down flaps that leave
> un-completed descriptors in the ring, the stale TBQP keeps pointing at
> a descriptor whose used bit is set. When TX is re-enabled on link-up,
> the GEM reads that used descriptor and raises TXUBR. macb_interrupt()
> schedules the TX NAPI, macb_tx_poll() makes no progress (work_done ==
> 0) and macb_tx_restart() re-issues TSTART, which makes the controller
> read the same used descriptor again and re-assert TXUBR. As the MAC
> interrupt is level-triggered, it never deasserts and one CPU is pegged
> at 100% in the threaded handler, eventually triggering "sched: RT
> throttling activated" and a dead network interface.

But this should also happen with !RT at which point the interrupt runs
at 100% CPU and the softirq has hardly an chance to make progress, no?

> Fix it by reprogramming TBQP to the ring base on every path of
> gem_shuffle_tx_one_ring() that resets tx_tail to 0, mirroring
> macb_tx_error_task(). The early return for an already-aligned tail is
> left untouched as TBQP is already consistent there. This is safe
> because the shuffle runs from macb_mac_link_up() while TE is still
> disabled, so the transmitter is halted.
> 
> Fixes: 881a0263d502 ("net: macb: Shuffle the tx ring before enabling tx")

This is v7.0-rc4. So that RT tree of yours has some backports or did you
run into this while trying to reproduce it upstream?

> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index fd282a1700fb..b11cb8f068b7 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -820,7 +820,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
>  	if (!count) {
>  		queue->tx_head = 0;
>  		queue->tx_tail = 0;
> -		goto unlock;
> +		goto reset_hw_ptr;

This update is even needed for count == 0 case? I kind of do understand
that you need to updated if you shuffled the descriptors around.

>  	}
>  
>  	shift = tail % ring_size;
> @@ -869,6 +869,13 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
>  	/* Make descriptor updates visible to hardware */
>  	wmb();
>  
> +reset_hw_ptr:
> +	/* tx_tail was reset to the ring base, so TBQP must be reprogrammed
> +	 * to match; otherwise it keeps pointing at a stale descriptor. Safe
> +	 * to write directly here as TX is still disabled (called from
> +	 * macb_mac_link_up() before TE is set).
> +	 */
> +	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
>  unlock:
>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>  }
> 

Sebastian

