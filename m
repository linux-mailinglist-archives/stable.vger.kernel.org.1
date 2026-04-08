Return-Path: <stable+bounces-233839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMPdAhQ01mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:55:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C9C3BAFD9
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59CD2300FA1B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E43BB9E6;
	Wed,  8 Apr 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="2kG8acJh"
X-Original-To: stable@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8C271A9A;
	Wed,  8 Apr 2026 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645704; cv=none; b=e1u+0M1chQwJfcajLpXiyyvDm1638zoPNoYuctjqQd7WhapL6eTYM/vOtHDcpBy/uPM+AdsOCXx7JthFbQYPim/i3ml47h1Qewn/DQXR8xcbul8CPwAumlyJblhdFvVRlUAOtoDRP/mZlkWi9D/4Rw8jITnxk9++NfEAVuUwIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645704; c=relaxed/simple;
	bh=K9vERO3r4Wm0Pee0HOUkFPW6kyABCG0E7jn/Bphl4iM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GBkAkpHnivn+LHmfxI7GVGyS7+3H8OpHFooTr8GgU9SPgPDvqn4QY3gcQnJb1i7NUMkSKPAi8X+/pik90uSpjKrWE/sf/akdsmJu8fmLbH4Dv4gKrl6huuPn0K842EJ4mB4NcZaH2GmEPxvcts5vkmHHX3ycNQ83KFrFJEWONLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=2kG8acJh; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0595FA26FD;
	Wed,  8 Apr 2026 12:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775645696; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ny+cR8zPTNl+JdyK7d/rOcDQJx/7poisHyXHHddlJ5k=;
	b=2kG8acJh1RsKgyv00H4Wv28b+YILwa6bjSJQrvgtEUxuJUL15D7JbHZjs9376B28YPj6JY
	Tj6U1D+bd3V+J6CpHlNWFPU/MzM+xQl99+/pFa4RSu2IcqZaqjYAnL2B85IN3fd0HFCCVh
	4zFD1+UUx2R5TQEF2gRcvFY1FFOx3RthfmWjtB652UcgxdNbYvXxZqFuG5YaNTe9axC7Vq
	qe6s6y0bpJbLJpP+LUMotnZFjlExWqN03PFRlg9XXcOus6bn6ymqJq0Y3lQYua5G1CCoYo
	2wG0oYGo8tSPeMdgVV7WlmWYgx440HwAz/epWmTgLC0/Rlg8mj39Ypt7uxTIBg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 08 Apr 2026 12:54:53 +0200
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
Message-ID: <f4010cedaa49afc1648a73775a987ee5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233839-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,redhat.com,raritan.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27C9C3BAFD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 7.4.2026 23:23, Marek Vasut wrote:

> [...]

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

This breaks the SPI variant on non-RT. The SPI path sleeps in
spi_sync() -> wait_for_completion_timeout(), which can't be
done with BH disabled. Confirmed on hardware (KS8851 SPI on
CM4S, PREEMPT non-RT):

   BUG: scheduling while atomic: irq/38-eth2/708/0x00000201
   ...
   spi_transfer_one_message+0x518/0x770
   __spi_pump_transfer_message+0x1dc/0x5f0
   __spi_sync+0x2b4/0x460
   spi_sync+0x38/0x68
   ks8851_rdfifo_spi+0x60/0xc0
   ks8851_irq+0x310/0x3c8

The fix needs to be PAR-specific since the SPI variant doesn't
have the deadlock problem anyway (ks8851_start_xmit_spi doesn't
take the lock).

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

In order to make this work I would propose something like this (which 
works in my SPI setup):

--- a/drivers/net/ethernet/micrel/ks8851_par.c
+++ b/drivers/net/ethernet/micrel/ks8851_par.c
@@ -60,12 +60,14 @@ static void ks8851_lock_par(struct ks8851_net *ks, 
unsigned long *flags)
  {
  	struct ks8851_net_par *ksp = to_ks8851_par(ks);

+	local_bh_disable();
  	spin_lock_irqsave(&ksp->lock, *flags);
  }

  static void ks8851_unlock_par(struct ks8851_net *ks, unsigned long 
*flags)
  {
  	struct ks8851_net_par *ksp = to_ks8851_par(ks);

  	spin_unlock_irqrestore(&ksp->lock, *flags);
+	local_bh_enable();
  }

Tested-by: Nicolai Buchwitz <nb@tipi-net.de>  # KS8851 SPI, non-RT 
(regression + proposed fix)

