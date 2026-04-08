Return-Path: <stable+bounces-235281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EfhACPD1mlDIAgAu9opvQ
	(envelope-from <stable+bounces-235281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 23:05:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7002F3C3F3E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 23:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72B803017FAE
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940D437AA92;
	Wed,  8 Apr 2026 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yaina.de header.i=@yaina.de header.b="N2j4UfeW"
X-Original-To: stable@vger.kernel.org
Received: from mail.yaina.de (yaina.de [95.216.117.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2462F7478;
	Wed,  8 Apr 2026 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.117.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682330; cv=none; b=C+1x46jkfZLJp4gzRDSgQ82QD8pDOrxbVJ63v+P16/V9QsrDDDBV0ol71svy3B3PWBaPONjGIvnRD1ADYviJAA2YiQFC5dp3dnuzbQN4oHqDOpSqRZl2Hdc7QO0Q6Q4gw/KjIuGNBRxD9UikuaFF4SdhtmbK/EzbKqRU67KELGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682330; c=relaxed/simple;
	bh=4WCg/ETMuwIk9WQula/mVorQiRkH0nGmB+WjIV8Frq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVNq3Z/lQKBVfZmNOCkEehcQ6hoX6IJDEf+uIPcnyEdR00k5y24Chw33qDPbuLya/goM7l/9J7bss1eopaWTgo96VL/SNNR+7kGKjHGGy0vOOJsg+xHJeXSIdQhWE2ANOpPgPR0Z9msCocqyO+qtW2GHhwUQILf8BpQnBd7N+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yaina.de; spf=pass smtp.mailfrom=yaina.de; dkim=pass (1024-bit key) header.d=yaina.de header.i=@yaina.de header.b=N2j4UfeW; arc=none smtp.client-ip=95.216.117.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yaina.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yaina.de
Received: from lycaon.yaina.de (ip1f118239.dynamic.kabel-deutschland.de [31.17.130.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "lykos.yaina.de", Issuer "CAcert Class 3 Root" (not verified))
	by mail.yaina.de (Postfix) with ESMTPSA id B93077CDEF0A;
	Wed, 08 Apr 2026 23:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yaina.de; s=mail;
	t=1775682325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zefjOB7yqJPmfzvG2WtGAjKoz/HAkvcpX+jjgaaV4RU=;
	b=N2j4UfeWLTPuDjzJ0Ast94dRIX58RHKQztp4F0AEB568mqMKrENfFaTIe8PRMEDRjnXZR3
	1999n2CU3eJwts/SpHjuwq3G/UQ+c3bocrtMMoDCWQMJgkmzULPfGr2CWIqdRxZnlyj+a0
	/ZI0aXs7ItI1pYjmTla/LK27WrZQ95U=
Received: by lycaon.yaina.de (Postfix, from userid 500)
	id 0DF82300E49; Wed, 08 Apr 2026 23:05:25 +0200 (CEST)
Date: Wed, 8 Apr 2026 23:05:25 +0200
From: Joerg Reuter <jreuter@yaina.de>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: hamradio: bpqether: validate frame length
 in bpq_rcv()
Message-ID: <adbDFVlrqnldyBXz@yaina.de>
References: <20260408172358.281186-1-mashiro.chen@mailbox.org>
 <20260408172358.281186-2-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408172358.281186-2-mashiro.chen@mailbox.org>
X-Face: #DGJ)DCeau/h"w7G~n9r|/jxvQQrtU)nat27v-><7':==-=.mfnXc+8&qOj`*R|qPr14[|4
 E_BUo5T*NT\(+fE7wr3}QoN*!c7\.Z.DiA{ko;01^TCi$K}1TIV|bNO.$jm;i<A,|
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[yaina.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[yaina.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235281-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[yaina.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jreuter@yaina.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,yaina.de:dkim,yaina.de:mid,yaina.de:email,yaina.de:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7002F3C3F3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Thu, Apr 09, 2026 at 01:23:57AM +0800 schrieb Mashiro Chen:
> The BPQ length field is decoded as:
> 
>   len = skb->data[0] + skb->data[1] * 256 - 5;
> 
> If the sender sets bytes [0..1] to values whose combined value is
> less than 5, len becomes negative.  Passing a negative int to
> skb_trim() silently converts to a huge unsigned value, causing the
> function to be a no-op.  The frame is then passed up to AX.25 with
> its original (untrimmed) payload, delivering garbage beyond the
> declared frame boundary.

I don't even know why there is a length field in the first place, and John
G8BPQ doesn't seem to remember either. 

There is nothing supposed to come after the payload, and there should be no
need to skb_trim() at all. 

However, since an obviously wrong length field indicates that something is
indeed wrong with that frame, I'm in favor of dropping those frames.

Acked-by: Joerg Reuter <jreuter@yaina.de>

> Cc: stable@vger.kernel.org
> Cc: linux-hams@vger.kernel.org
> Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
> ---
>  drivers/net/hamradio/bpqether.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
> index 045c5177262eaf..214fd1f819a1bb 100644
> --- a/drivers/net/hamradio/bpqether.c
> +++ b/drivers/net/hamradio/bpqether.c
> @@ -187,6 +187,9 @@ static int bpq_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_ty
>  
>  	len = skb->data[0] + skb->data[1] * 256 - 5;
>  
> +	if (len < 0 || len > skb->len - 2)
> +		goto drop_unlock;
> +
>  	skb_pull(skb, 2);	/* Remove the length bytes */
>  	skb_trim(skb, len);	/* Set the length of the data */
>  
> -- 
> 2.53.0
> 

-- 
Joerg Reuter                                    http://yaina.de/jreuter
And I make my way to where the warm scent of soil fills the evening air. 
Everything is waiting quietly out there....                 (Anne Clark)

