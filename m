Return-Path: <stable+bounces-236143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNTKBuUN3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:38:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 732A83EE0EB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8DB7308FD61
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2763C2763;
	Mon, 13 Apr 2026 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Zv1AhI0n"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C4223DEA;
	Mon, 13 Apr 2026 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094302; cv=none; b=DWVmqdat02KxeKK6koyMVKKQa05+RyazAFTmBLD2tNf68UEfQb9QKsWVW8i5oZIOz+xA/8Pqb3Cli4OVK7OOOA5ZbIQgBC7/vhJVfRyiEFnY8+x8xwdQPoBgnQxfkiGbHrbe29dZWOWcXtud53RaKGrmzjrRvRkWxjbwgb0EKsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094302; c=relaxed/simple;
	bh=F+Be4AKYfqex3e9DjTIHE6/rw1/MNxaW1WaCXDd1wrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TB0TVhP7+T80+q+IHgzPMalPJUxv7v+XPLCg01s1WrvpbokrEoQp3MUUuK55YJIAqrzJ1dUuPEEYLLQrJj0W9nN6snBSbiQGkqYfvEVNPS88DSeazUYBPF4RRc8R/ebBv7icPspCOhObVH4yIkc+/qBOK2GEYUIL+n09lYzro/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Zv1AhI0n; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CC0B112E56;
	Mon, 13 Apr 2026 17:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776094297;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cZrEa467yOyHEcLpgiiG8kuxyNlS6nPgT0FI3HuiB3s=;
	b=Zv1AhI0nBWwDHGstbEb8l9szv1E8jSi3MC/P4OytrGeNwIfWQU8Feo8QX6baq/Qo4Gba3E
	Mp1Hul7zGlAXcJC+tAY/OhmC3tindJipzletBrmCd9tWCQODZwhGjJpMsiLWibsFCnc4Y6
	hPzTU6yruALkopuQGIE+W2yfcJBFE17mMBP6kOvep1Hvu8e3bg7KJ5L5zNo/HgjJJuQcng
	yLO3dunhtbdr3Li2JZBh7V7RyOaJH5cLKHTwxkicci2g5eGmDNdGfA9WnemxYisEaHHIbw
	98T8RE1fwjsLVdAULPS2rHfKOcWjv6lXf7q8gPBUfSWMEfoVRhrrq8eFz8bkMA==
Message-ID: <16fdeec9-9208-4c9b-b228-d6c6e045e116@nabladev.com>
Date: Mon, 13 Apr 2026 17:31:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>
References: <20260408162535.98108-1-marex@nabladev.com>
 <20260412090141.21bf1534@kernel.org>
 <2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
 <20260412105125.48f0c58f@kernel.org> <20260413125744.TVKkZcEK@linutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260413125744.TVKkZcEK@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236143-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:mid]
X-Rspamd-Queue-Id: 732A83EE0EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 2:57 PM, Sebastian Andrzej Siewior wrote:
> On 2026-04-12 10:51:25 [-0700], Jakub Kicinski wrote:
>>> Does the backtrace make the problem clearer, with the annotation above ?
>>
>> Sebastian, do you have any recommendation here? tl;dr is that the driver does
> …
> 
> What about this:
> 
> --- a/drivers/net/ethernet/micrel/ks8851_par.c
> +++ b/drivers/net/ethernet/micrel/ks8851_par.c
> @@ -63,7 +63,7 @@ static void ks8851_lock_par(struct ks8851_net *ks, unsigned long *flags)
>   {
>   	struct ks8851_net_par *ksp = to_ks8851_par(ks);
>   
> -	spin_lock_irqsave(&ksp->lock, *flags);
> +	spin_lock_bh(&ksp->lock);
>   }
>   
>   /**
> @@ -77,7 +77,7 @@ static void ks8851_unlock_par(struct ks8851_net *ks, unsigned long *flags)
>   {
>   	struct ks8851_net_par *ksp = to_ks8851_par(ks);
>   
> -	spin_unlock_irqrestore(&ksp->lock, *flags);
> +	spin_unlock_bh(&ksp->lock);
>   }
>   
>   /**
> 
> 
> I don't see why it needs to disable interrupts.

Because when the lock is held, the PAR code shouldn't be interrupted by 
an interrupt, otherwise it would completely mess up the state of the 
KS8851 MAC. The spinlock does not protect only the IRQ handler, it 
protects also ks8851_start_xmit_par() and ks8851_write_mac_addr() and 
ks8851_read_mac_addr() and ks8851_net_open() and ks8851_net_stop() and 
other sites which call ks8851_lock()/ks8851_unlock() which cannot be 
executed concurrently, but where BHs can be enabled.

> ? This seems to be used by
> the _par driver and the _common part. The comments refer to DMA but I
> see only FIFO access.

The KS8851 does its own internal DMA into the SRAM, from which the data 
are copied by the driver into system DRAM.

> And while at it, I would recommend to
> 
> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
> index 8048770958d60..f1c662887646c 100644
> --- a/drivers/net/ethernet/micrel/ks8851_common.c
> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> @@ -378,9 +378,12 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
>   	if (status & IRQ_LCI)
>   		mii_check_link(&ks->mii);
>   
> -	if (status & IRQ_RXI)
> +	if (status & IRQ_RXI) {
> +		local_bh_disable();
>   		while ((skb = __skb_dequeue(&rxq)))
>   			netif_rx(skb);
> +		local_bh_enable();
> +	}
>   
>   	return IRQ_HANDLED;
>   }
> 
> Because otherwise it will kick-off backlog NAPI after every packet if
> multiple packets are available.
I think this patch will do the same, but the above should be done for 
the SPI part ?

