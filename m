Return-Path: <stable+bounces-249337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BxVDmc/C2pdFAUAu9opvQ
	(envelope-from <stable+bounces-249337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:33:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E66B0570FA0
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E82B430454F4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4CF378832;
	Mon, 18 May 2026 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezXdf2Qn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A61C84A2
	for <stable@vger.kernel.org>; Mon, 18 May 2026 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121581; cv=none; b=Lzcq6Cw3pGQkP2Zs4w4EralfmuMVVat4cP5RO1XPEfVzxglC2zU4lJUL3zqmWNqA7KxdXhj08wxF4PlA6YA56cJMGtod2poh6J4Q650oF6XUp2Q7v1wmq6ZssuPcKGFydt7iwazPYz/lnSaFI6Mihgt/rXc1TUykAoyd6ZLZqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121581; c=relaxed/simple;
	bh=9ibhTgmdgaVzvd0/WVlmmQhIMZ5I9GFkwHv21SR22uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEbHM+aL+5XvFbCVf1CGU0nEJM+k6RmYE5KPM9YkztRU0dBlcnyWud7j9RFhGBTsw+reTqu85TQbMYWzG4TZ0qr8RxVeBP2uBrMrBggam3xP9b7D2il0f519pTxwSOGJl+JNLRpfeHcQxyDmKH7q0u/EumkijjmNR5EyGAiyTkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezXdf2Qn; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bf02533706so18946437b3.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779121578; x=1779726378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEH0kDlr/EF8Y5XVB7DOIIT0Vo/0czOU72ejpPKh4QE=;
        b=ezXdf2QnlBjLWokkUmX16ocXYZ/LeIlHH2ECdtigw0mbWF0vSqN700a8yVSs2K8qRc
         sOXRsaMPE9+7ddA+YcZaE6iENq2voDaEUTrVWNu+hBaLbB7mv9zopUIFe9XdOIJieNx5
         A8jpdfey4jZJfnyzLPQ75+h/3dkVqqXJgdCOav+XWMfQwUIGVrXz7jOq2S3U9eMabZh3
         NFRITIdrkHjNI+TezhUiHaMCuOSTwX46vOZKjZC3QQiGnN6ITkXcqvognDXOtTzx/TE4
         xfKZuNXm/BahjtUUamJQljbyL6dcVljxggubKNUUSdOaWAq5YSH+vOf95VK1zuEFxgm8
         3igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779121578; x=1779726378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEH0kDlr/EF8Y5XVB7DOIIT0Vo/0czOU72ejpPKh4QE=;
        b=XwzMj0If1mDS7OYp+65zWmh/2cHe/MSVnJV8CLFHkxeaNiP0BRjhYWx411OKRqo1YU
         sax/6q+3AjsnRCTLCCFnQPwA7NOido042E6xmCZnyoBsB6hevT7kWDdB/V9BxbVibvVQ
         MrCj31/XJVyzSx3NadC+QLcrcZx6QHLe+2R4cVoPMbncefUAJFmnnobnzrGCwHyoNzBZ
         6uHashuKprllQK1e+RM0qSpj9vCHprGTVmeC+9GqHUd3qcn8UJjb/rTMqKkQZqjDSn4i
         Irv33UXkEjrZjm2Y52lUV57CqiXHiW+BEykIH3UIGWFzdhdhaX8QBCDVquV2iWYCah+M
         4lhg==
X-Forwarded-Encrypted: i=1; AFNElJ9t49igVh3jzn5fnl9LDSsDBZb/TKMp3BCYr4QOwBmFfF7VVCUaxqqwkb1JPnbFcIjgsrsw0KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytaqTEl1BLOOHM4cS1cDv8hCWP9NXpjB80I39cpk9RTLC0XyW8
	07umCfanWECQHlXKa8MbLP1fdd79TNSPSJ2/6XR70AtDoCy/ekROgUjF
X-Gm-Gg: Acq92OFKDjMDC9bWznID+XMzNoINI6j9y2CBh+yD0idi7AQGIusD/UwDw01faEP3GVI
	vzOVBOltkcXaIo0moc3rHO4IqUnJCrIuYIdmsuxF20Y0EvyeODn9aKlrxfsyIvnaxORW9fNqcaa
	aNe3dtBTLKtSjCGTyvZi9/Wge2mHxD8HXYZMsspG4BF9kQFMtO4fuaF4yjYyFQYhLV+bEOi6Azc
	v1BmsUIKpnbFxdTR/z5qVTmHqx+CmSc0j0n6MLJz0ypbEWfh9GAZO0udPpWQXQ/RrT4pmu7HNCj
	ryKcy+yI3LqXacHdYhTRzi67rVLyY+mb52UitBtoimK1z+Bwuu7vOjnXg4kRAQXffCFhHWKeFvj
	0BbJv27PBdBVSq9VCRH+fotOoNwgZNmyudbVPS2UPbR5pgo0i7mMwUKwCvM2Vm2hDghNQiAX7ek
	e2gk7Y0sn6bMTqidf7JL0lPqhwn26I/rRic/ZlcbiO5el0Dpo=
X-Received: by 2002:a05:690c:9304:b0:78f:bc2b:83f5 with SMTP id 00721157ae682-7c95a087a51mr151158297b3.20.1779121577988;
        Mon, 18 May 2026 09:26:17 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f806:18::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c6ce2f4sm23597927b3.39.2026.05.18.09.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:26:17 -0700 (PDT)
Date: Mon, 18 May 2026 09:26:14 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: reject TX dma-buf with non-page-aligned
 size or SG length
Message-ID: <ags9po+uLZ++7FaP@devvm29614.prn0.facebook.com>
References: <20260517201814.222563-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517201814.222563-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249337-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm29614.prn0.facebook.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E66B0570FA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 09:18:14PM +0100, David Carlier wrote:
> The TX dma-buf bind assumes dmabuf->size and every sg_dma_len() are
> PAGE_SIZE multiples: tx_vec is sized dmabuf->size / PAGE_SIZE and
> indexed by virt_addr / PAGE_SIZE, with only a virt_addr < dmabuf->size
> bound check. A non-page-aligned size lets sendmsg() reach the tail
> region past the last populated slot and read one past tx_vec[]. A
> non-page-aligned, non-final SG entry causes the same OOB indirectly
> by desyncing later slots.
> 
> Reject both up front. Real exporters (udmabuf, dma-buf heaps, GPU
> drivers) already page-align, so this only refuses layouts the TX path
> can't back correctly.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
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

nit: this code already has precedent for comparing direction directly to
DMA_TO_DEVICE in line, so probably don't need to store in a new
variable. The binding->tx_vec[] assignment down near line 300 also does
this and is missed in this conversion.

Best,
Bobby

> +
> +	if (todevice) {
> +		if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
> +			err = -EINVAL;
> +			NL_SET_ERR_MSG(extack, "TX dma-buf size must be a multiple of PAGE_SIZE");
> +			goto err_unmap;
> +		}
>  		binding->tx_vec = kvmalloc_objs(struct net_iov *,
>  						dmabuf->size / PAGE_SIZE);
>  		if (!binding->tx_vec) {
> @@ -267,6 +275,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  		size_t len = sg_dma_len(sg);
>  		struct net_iov *niov;
>  
> +		if (todevice && !IS_ALIGNED(len, PAGE_SIZE)) {
> +			err = -EINVAL;
> +			NL_SET_ERR_MSG(extack, "TX dma-buf SG length must be PAGE_SIZE aligned");
> +			goto err_free_chunks;
> +		}
> +
>  		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
>  				     dev_to_node(&dev->dev));
>  		if (!owner) {
> -- 
> 2.53.0
> 

