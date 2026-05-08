Return-Path: <stable+bounces-244742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFSlLgzG/WkpigAAu9opvQ
	(envelope-from <stable+bounces-244742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 13:16:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 396D14F5925
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 13:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8598C301AEC5
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02D4371D00;
	Fri,  8 May 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="TGvjU0ba"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47937AA78;
	Fri,  8 May 2026 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778238982; cv=none; b=ogjzub8svk2UpaXsTb4GLp3Tump5tWoapURXjYZNKQnGkG+4v/1bneYhdtT8Cu2w3DwXxez8r3kcjiXDQTNKK8VYO0g+ObMGbVfAoWfBmraT/yhQfF+OgJwv1VMflXXIsZ9B9e2MxwPuBt+mu/Zd3X087qwEXXMqQO1kRgjtPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778238982; c=relaxed/simple;
	bh=+vuKo/u4KikV6iPHUDvHvfXw93VmuHa4RCkIWhLXjjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Upslr6yisDfpSJ60R/H/T/LwsQRY8isIgXY2x5xUqQY64+aIkcEEEcPhg6eoLtL2sb34m81FDQ4+cfbfqncJ1CduhM1nVkwF+wliF6jC11rek596tYQq9xrY3KxLex8RlqoSMByFxxqJnkJLTLB2rhBiKhSXwredTYRtSriTksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=TGvjU0ba; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [95.24.24.108])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7430645F798B;
	Fri,  8 May 2026 11:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7430645F798B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1778238968;
	bh=KjsyGIyfW+8qFLB3U0CZvRcpHM6OViQQjweKLCkixKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGvjU0banMzZdh2rPSS4yEP1kqSxcyVko3Gwc7q7WI9jj7HbSPRV3MUJQf8Y+Fjkv
	 bdyVqIMEFs09SSMtkq7Zqe95mTB1dUBvrTuUcLKw/IASiS6GQI1gdKn89kSQ2ou5ND
	 rBXHRZC0SsVwxtdHx13VM0SWn5Qwl0/0QZlJF7kw=
Date: Fri, 8 May 2026 14:16:08 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, lvc-project@linuxtesting.org, netdev@vger.kernel.org
Subject: Re: [PATCH 6.12] block: fix memory leak in in bio_map_user_iov()
Message-ID: <20260508140302-8345f67a2b30b20c27161353-pchelkin@ispras>
References: <20260505094529.406783-1-dmantipov@yandex.ru>
 <20260507212200-2614841ccc112a082cab6938-pchelkin@ispras>
 <5bd98789901e6bcd2b41d646209deb6e48ffb711.camel@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bd98789901e6bcd2b41d646209deb6e48ffb711.camel@yandex.ru>
X-Rspamd-Queue-Id: 396D14F5925
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244742-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[yandex.ru];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ispras.ru:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 08. May 11:30, Dmitry Antipov wrote:
> On Thu, 2026-05-07 at 21:52 +0300, Fedor Pchelkin wrote:
> 
> > In some form the issue is present in current upstream as well.  For
> > example, there is another callsite of iov_iter_extract_pages() in
> > block/bio-integrity.c where the same pattern still persists. 
> 
> Good point, and skb_splice_from_iter() looks suspicious as well:
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7dad68e3b518..bf053372acb2 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7343,12 +7343,16 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
>  
>                 len = iov_iter_extract_pages(iter, &ppages, maxsize, nr, 0, &off);

This function does allocate memory for @pages argument only if *@pages is
NULL.  I don't think it's NULL here, *@pages points to a stack-allocated
array.

>                 if (len <= 0) {
> +                       /* Possible memory leak - ppages should be vfree()'d
> +                          if reallocated (ppages != pages)? */
>                         ret = len ?: -EIO;
>                         break;
>                 }
>  
>                 i = 0;
>                 do {
> +                       /* This looks wrong if reallocated - ppages[i++]
> +                          should be used instead? */
>                         struct page *page = pages[i++];
>                         size_t part = min_t(size_t, PAGE_SIZE - off, len);
> 
> This issue likely crosses the boundaries of block subsystem so netdev
> people are encouraged to look as well.

Not in this case.  The situations where iov_iter_extract_pages() needs to
allocate memory for @pages on its own happen when *@pages is NULL.  In
current mainline it can occur at block/bio-integrity.c and probably
that's all.

Mind to prepare the patch, please?  There are better chances to discuss
the problem directly with the patch at hand instead of expecting someone
to look at this [PATCH 6.12] thread.

