Return-Path: <stable+bounces-249325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAKeKGEwC2rzEQUAu9opvQ
	(envelope-from <stable+bounces-249325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:29:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7556FFBD
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 407F63069624
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E822D379EE1;
	Mon, 18 May 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwaTKkA5"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742D3793C1
	for <stable@vger.kernel.org>; Mon, 18 May 2026 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117958; cv=none; b=rBEfuSHnxQM5Ai2hj3K4pk21Q9VtyDDnNFMlEE4v8tYUM04bfXOwKOovyA4jSftV182K1qPQWbu1KvzQhde8zb3NP9cu8jwZly9H0i7XL4H7wGlCV5Ptee5qOtKqJwDVkVB+kF9fLfBNwMwN7ofegwMd77POeRswkHFca/CDgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117958; c=relaxed/simple;
	bh=CD/xOi+hOcIPjr+saxVI036C8iZNK7iKuvD4q/eLfYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR1YRr4dYiQayJagde84C+S/GDLZIcC0II6+0pWbVGbaihybOdEdzHFYIUnJx8QQlhVq/9JteMj5uLyaU2+YzCZ5x+CJAWJE8s0TSPW+c5bJCXadysisGhw7X0DU6FV71MJXozNnTxW6spCg/8KqFd70lU2mqQsbWEvYYHWZnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwaTKkA5; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7bd5e373d07so19235267b3.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117955; x=1779722755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bj+KewWFQLB4l2VEmceKCACQWaYnSld3fnpus3EQoQg=;
        b=EwaTKkA5rRtrW7OpHaVz7gz5OdDcQseGwlIbJPyCUPLA+uDvSQmERHx9gZPT5Az9Jp
         /WkIEyKItrqZ54kKS97L1HiV+MN/7X4KeN9H1LtImJmrunrjO91f1ZECHTAyPUTzV4BE
         XfdxPiudnBqrDiONp3U65OW5H6pjdYfsEXSHDkgU5sM1Ym3Sx2gxTRtSWlGrVfyzd2q7
         CxVacEtLz7TjC2hYkxdw3P2jNyZoaNr4dCOdjArbV0uU8rBAtIj6hrz/hvUWJfzVbjcl
         UwvGF0azFBPqViUHkAV5gc894Fa9xgeqNDB9PUv9dT1fNMEJeDyOQ+txe0yK7v2gx0a3
         H/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117955; x=1779722755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj+KewWFQLB4l2VEmceKCACQWaYnSld3fnpus3EQoQg=;
        b=LyaA2JZUf7PmjSumemoRjTxvoa8sEbZBGzlUdjAYAyloE+LEU8V/XgsbwOzhqTAkEm
         4pCHkAHibA5B2yBctSor6BoQVPe6c96e+CxpIMph8mHh62ghXeuQFsSNuwnH8Hucoon7
         xpnhffOHB+CyRChXY8V0JxJgkAKIjMMQKkbANTEHiGbeAt5s+vKFoT6r2C0qAoXtoD6z
         hDOw5v8fIlQ/UpciTVF61j0auX+YFLZXXNuaMIBmG2GCAvs7ZM9behz6jANMwLB/7V0C
         h8vIq8am9H0YG7dHy1FQOvgXo4ADC25+3srTILw2+VT13uK7fqU1Vjrhz2BtlUUYlJD1
         7Emg==
X-Forwarded-Encrypted: i=1; AFNElJ+jpvkxaqyYtVivOUGC6F9eBFJ3gdhWIW+V4dHydz4K8Y4/hnljOoqS33t4G0SQScrQx25J0RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqtjUqQSl/A163+K7rvFwA2Oixi/kKj1X/GbPIqQXlWxVtsSIE
	sGp0EjLmbjef1Y4kFjgV3XxBvxn8U/lCyErWRutp0Oa7TP3PNAReE/6+
X-Gm-Gg: Acq92OHVIHnFXepz3Zqumktpy+D7QXY4ihTVZrxBs1oulyJ/OlLPun6uuwXQOMBohUZ
	aSWiZZiS3x90Et2ss2BirNb3wxaV2+AAUjgHBLvTw61UVL4kBKIA0dXUZc40d2iA+4dTyk7t36o
	Ogywa3yXi79ttscGMSsaz07+XVykrmfu0ziRM3D8xN5TJIQ9lnTwzInDvnqYIsO4LiLdpNGXitQ
	WoC0wOWXCncIKFms1t5lOt9uv2pBlys4VnUZ0ETwsMLXnfo0FzJTdI5gIHBUJ1GwQbeoa4f4/fl
	RiXC7ANnLc50kgutm54bEGr6pya/MvUnT38x9r7W0JUTsdVXJ8vrF8ZIICgoTMez0z4BGS+ioXc
	XXeVp/4zEM+/XKn2jgxylyErY8cu5oU3gtaGpmfEYFU8iOYeV/vu2igji2bRRMLDHnPkXFp848L
	2RubkD6npJhUmSeFaeKWvECSHL8ew=
X-Received: by 2002:a05:690c:e3ce:b0:7bd:d4f4:261e with SMTP id 00721157ae682-7c95b33f043mr158034857b3.31.1779117954983;
        Mon, 18 May 2026 08:25:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cd0bfdc094sm18551377b3.32.2026.05.18.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:25:54 -0700 (PDT)
Date: Mon, 18 May 2026 08:25:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: reject TX dma-buf with non-page-aligned
 size or SG length
Message-ID: <agsu4MoBYWPFEmpZ@devvm7509.cco0.facebook.com>
References: <20260517201814.222563-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260517201814.222563-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249325-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3BD7556FFBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/17, David Carlier wrote:
> The TX dma-buf bind assumes dmabuf->size and every sg_dma_len() are
> PAGE_SIZE multiples: tx_vec is sized dmabuf->size / PAGE_SIZE and
> indexed by virt_addr / PAGE_SIZE, with only a virt_addr < dmabuf->size
> bound check. A non-page-aligned size lets sendmsg() reach the tail
> region past the last populated slot and read one past tx_vec[]. A
> non-page-aligned, non-final SG entry causes the same OOB indirectly
> by desyncing later slots.

[..]

> Reject both up front. Real exporters (udmabuf, dma-buf heaps, GPU
> drivers) already page-align, so this only refuses layouts the TX path
> can't back correctly.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

If the real exported already export page-aligned, why does it need
to go into net/stable?

> ---
>  net/core/devmem.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 468344739db2..e72f48ff9094 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -193,6 +193,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  	struct dma_buf *dmabuf;
>  	unsigned int sg_idx, i;
>  	unsigned long virtual;
> +	bool todevice;
>  	int err;
>  
>  	if (!dma_dev) {
> @@ -240,7 +241,14 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  		goto err_detach;
>  	}
>  
> -	if (direction == DMA_TO_DEVICE) {
> +	todevice = direction == DMA_TO_DEVICE;

If you're being defensive here with "real exporters already page-align",
why not do this check on both rx and tx? Why single out tx side?

