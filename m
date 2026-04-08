Return-Path: <stable+bounces-235285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMcZDD3J1mkLIQgAu9opvQ
	(envelope-from <stable+bounces-235285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 23:31:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3791B3C4186
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 23:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53E8230157CC
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B562D0602;
	Wed,  8 Apr 2026 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yaina.de header.i=@yaina.de header.b="2eDip3fX"
X-Original-To: stable@vger.kernel.org
Received: from mail.yaina.de (yaina.de [95.216.117.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483BEED8;
	Wed,  8 Apr 2026 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.117.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683893; cv=none; b=JQtOBXio2VyZRaO2T0nQCifDAZ73/H0rYqQ8ISyhS584wD1mcsAIpT542fziVsGWBo8kP7pV+bbn8j7iCMnYQoSAlATf8pXbYapfv3j+YMYEIa9zMFo9PKDmpQHIb4ojJksWpbbfVPAb0HFXOnS+T1mZ6ThDtU6Br2tu5T+tMnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683893; c=relaxed/simple;
	bh=h2wqvka6vwdFL8MxOXiZdeSdFhvhq08VkB7hE6JBivM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm6p8wbEboms38CgPyYh8h5KaVzX8Gk964cxhvg7lg93zYxBClaAz3x4iwT15eJ+KLT9sIiRjd0niDu6DczhIYW3GGv0YXpK9lABDqVVFkl4sVaaBL2EnAML+IqhOrS05R8orxZOhpdIf3jkDnLBAotQ+hi+lu4WNZEQeX19lng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yaina.de; spf=pass smtp.mailfrom=yaina.de; dkim=pass (1024-bit key) header.d=yaina.de header.i=@yaina.de header.b=2eDip3fX; arc=none smtp.client-ip=95.216.117.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yaina.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yaina.de
Received: from lycaon.yaina.de (ip1f118239.dynamic.kabel-deutschland.de [31.17.130.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "lykos.yaina.de", Issuer "CAcert Class 3 Root" (not verified))
	by mail.yaina.de (Postfix) with ESMTPSA id B90AE7CDEF55;
	Wed, 08 Apr 2026 23:31:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yaina.de; s=mail;
	t=1775683887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qpp8Wxq49Fmlaf68pjkAMbJGmNpayJqChc8UNCM/Pw=;
	b=2eDip3fX96WWKgdParCpOMUMYH5ebEygJdEFycMtmq+wxR+4Wx6FVpfWP0WJKHApW8hzp5
	k9RdDF6luSv0i14IRsK0LqB3YUCap3TR4PFDSj7pxgVDR51q/xFKRNJbIETv0YMgbPN8dz
	kaQ/sbwQDVlML4Elx75lXEyV6YwVE40=
Received: by lycaon.yaina.de (Postfix, from userid 500)
	id 2F916300E57; Wed, 08 Apr 2026 23:31:27 +0200 (CEST)
Date: Wed, 8 Apr 2026 23:31:27 +0200
From: Joerg Reuter <jreuter@yaina.de>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: ax25: fix integer overflow in ax25_rx_fragment()
Message-ID: <adbJL14aPmcTLC62@yaina.de>
References: <20260408172521.281365-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408172521.281365-1-mashiro.chen@mailbox.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yaina.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yaina.de:+];
	TAGGED_FROM(0.00)[bounces-235285-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[yaina.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jreuter@yaina.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mailbox.org:email,yaina.de:dkim,yaina.de:mid,yaina.de:email,yaina.de:url]
X-Rspamd-Queue-Id: 3791B3C4186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Thu, Apr 09, 2026 at 01:25:21AM +0800 schrieb Mashiro Chen:
> An attacker on an AX.25 link that supports multi-fragment I-frames
> (AX25_SEG_FIRST / AX25_SEG_REM mechanism) can trigger this by
> sending enough continuation fragments to wrap the 16-bit counter.
> With AX.25 segment numbers limited to 6 bits (max 63 continuation
> fragments), a fragment payload of ~1040 bytes per fragment is
> sufficient to overflow.

Even worse, it's 7 bits: https://www.ax25.net/AX25.2.2-Jul%2098-2.pdf
Figure 6.2 "Segment Header Format". Sigh.

Thanks,
     Joerg

Acked-by: Joerg Reuter <jreuter@yaina.de>
> Cc: stable@vger.kernel.org
> Cc: linux-hams@vger.kernel.org
> Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
> ---
>  net/ax25/ax25_in.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
> index d75b3e9ed93de8..68202c19b19e3f 100644
> --- a/net/ax25/ax25_in.c
> +++ b/net/ax25/ax25_in.c
> @@ -41,6 +41,11 @@ static int ax25_rx_fragment(ax25_cb *ax25, struct sk_buff *skb)
>  				/* Enqueue fragment */
>  				ax25->fragno = *skb->data & AX25_SEG_REM;
>  				skb_pull(skb, 1);	/* skip fragno */
> +				if ((unsigned int)ax25->fraglen + skb->len > USHRT_MAX) {
> +					skb_queue_purge(&ax25->frag_queue);
> +					ax25->fragno = 0;
> +					return 1;
> +				}
>  				ax25->fraglen += skb->len;
>  				skb_queue_tail(&ax25->frag_queue, skb);
>  
> -- 
> 2.53.0
> 

-- 
Joerg Reuter                                    http://yaina.de/jreuter
And I make my way to where the warm scent of soil fills the evening air. 
Everything is waiting quietly out there....                 (Anne Clark)

