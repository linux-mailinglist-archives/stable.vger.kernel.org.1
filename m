Return-Path: <stable+bounces-231074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFk6OFlGymnn7AUAu9opvQ
	(envelope-from <stable+bounces-231074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:46:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57035358704
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C4A4305043F
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2CB3B4E9B;
	Mon, 30 Mar 2026 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odn278ys"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715C3B52FA
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863456; cv=none; b=dbSWSFJIoYJ+ZWRZE8Q0iJ9Ge4sTvt4k08zzSKBpwPTsyYeUZxEbkq/DkY18K5QYCB/ReZhrb3cAmZQwYxZ9KegKAdmb/a7Yk/KYQbpPNuprvZaMdxRrcouBNTLwz0O4MNJnW9Od6WuGQ0H7IJU2kux2ZBQbCiKHW+v6Ptf456k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863456; c=relaxed/simple;
	bh=v/KejTXhe3Zobl17Vlv8GeZMvuW60lczEwBitAa+7XA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLAO1yFLCTvPirt2ceEOoIxZ0+JUV6VJgyaj/VilHPVZI0lHSvV+fYKyIt1iPBZA6H1Y08tLkwLetjW4Nm+pCUl8y4pFolB40dGACfWUqpFwTyWXmu9CjCEmZEGwaL3dlY4ksJQ5yNofZkVSzslP0VE5zp+1ZBlusoazixlCjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odn278ys; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso37656595e9.1
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774863449; x=1775468249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pI4JUCEtE5qRlwuJumNxTzoSp2/TgL1Oh7MLg7cH5Is=;
        b=Odn278ysLnV1x5LZUsi8JtPbQ9iLZ64GqOX3HMOTGGXka9u/T6+/ALsdkoJFdEMlLw
         VvX413eXiZAOdJvyMejA0cQAn+oJdFvX5Pspkt0R/9LSuBrOwAeCvTsGruWuIYn4jiS6
         oL4iNtuINIXrzfXUEu3cCrAhfep6ufXlEmRD9OqcwFGh/8eK+XMtg0xNnXHxfKrYa0KB
         Gj2fvWEjBEOWYmKJgYWXzZiWLsEPN9bYu9X20MCJGrQSZt68U9+jDTZ9Z2g/CndDxCMV
         4MisH/Dkx2q5AU4H5amAqLb0kUz2MknIrSyshjOzbnIdlck9qHbF1FG5+6i0lOUN7db2
         wPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774863449; x=1775468249;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI4JUCEtE5qRlwuJumNxTzoSp2/TgL1Oh7MLg7cH5Is=;
        b=KURWZW0I7afCjpQPM7SHTKn7sHfNKB9OAtN7nj1MUKt5YO5YEpQbFgryniaAmHdZd7
         Chu7EV+0PQ2DJNkj4E0H4xx5steKJ7lEXHVsTGE3oUxZ8L2GJuKNdybYYenFMTY3BARi
         sD4+LN9jmlxGeTrC+f56CHFrzKsOnkgYNgfxwOIbGNV8jO5mCQNuQXT+hXyztuSYa7uT
         R7z3SCfXB7zwt+nQgV4KrD2YHm+NMt5OJyQoAyP1rJouiLMgb1nH0Pt4IbmpENbe3OqH
         atJarhwCopds9pg3Vh0d4s3GTWq4CvW88OliBXGATQyV77ajaw5g9HwHQ4iGSooZchR1
         9kuQ==
X-Gm-Message-State: AOJu0YwdZNiIRSkEbaCQEwCcSYFgJCWxV9JrgCVUbSwhsJQMUWnqwpD9
	8eA0Ec0dLqRpQRCt732GuDFfc0I0dPrufeQpnCzwXL93cBtWfK25LDrw
X-Gm-Gg: ATEYQzy9RfnLebcx+ad0G5l/AaJpnvQG/H9h7dvjGGpw0yHz8/MF7vff/klI1RDhNCt
	P7515IpkpaABdmqX9lRfOVl7Kd1UviA9RPUXe00WYhU0UPa56ABYoAoVfDP9M8P771JH36ra3X2
	i1ugA21EmZ/EP/kmnEV3MkmGR+g8BB6VJYiq+B77Ew+Wg9VIA7o+jp1CAflAdJDnAAOCBKwuzaD
	1fhApZigJwgrmAazMd/qVZBg5jdPLXTaqb7gS/LtoxWbncTmQeJ4Vo+Ze+EnrIzv1TBWAcyfCL/
	Vsftgdrn7FATkf7Np4cXeW/p1iKRTLAzF/2Es2MKKqUmFaEv0JJLfwHfiqdkehT+zclZ1X3Qm4t
	+ru+3G8QNjXZE0iTIJ2qRMICBg2QYz2YEizf8EmPgbkz//B8n5gR1+8+R+MGTRFuIbMpJyQK8YW
	sfHmXhcjrFMDxb4eI4UO8zhn2bvSThKKz1K4mb+6+LNytgZCGBM9Fzag==
X-Received: by 2002:a05:600c:c493:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-48727ef5571mr186959755e9.24.1774863448505;
        Mon, 30 Mar 2026 02:37:28 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d49c18sm262788815e9.14.2026.03.30.02.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:37:28 -0700 (PDT)
Message-ID: <69ca4458.050a0220.3569e7.2980@mx.google.com>
X-Google-Original-Message-ID: <acpEVX2A5bhnShFI@Ansuel-XPS.>
Date: Mon, 30 Mar 2026 11:37:25 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Richard van Schagen <vschagen@icloud.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: eip93 - Fix dma_unmap_single() direction in
 eip93_hash_handle_result()
References: <20260330091817.25797-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330091817.25797-2-fourier.thomas@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gondor.apana.org.au,davemloft.net,icloud.com];
	TAGGED_FROM(0.00)[bounces-231074-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mx.google.com:mid]
X-Rspamd-Queue-Id: 57035358704
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:18:14AM +0200, Thomas Fourier wrote:
> The buffer rctx->sa_record_base was mapped in eip93_hash_update();
> rctx->sa_state_ctr_base and rctx->sa_state_base in eip93_send_req()
> with direction DMA_TO_DEVICE but unmap with DMA_FROM_DEVICE in
> eip93_hash_handle_result() and eip93_handle_result().
> 
> Change the unmap to match the mapping.
> 
> Fixes: 9739f5f93b78 ("crypto: eip93 - Add Inside Secure SafeXcel EIP-93 crypto engine support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Hi,

was this tested with the crypto self test?

I need to check the code again but in theory with handle result, we should
get the data from device in sa_state and cache should be invalidated. If we
want to use matching maybe we should change to BIDIRECTIONAL?

The mismatched flag was to invalidate relevant cache on tramissing to device and
then invalidate relevant cache when reading it.

> ---
>  drivers/crypto/inside-secure/eip93/eip93-common.c | 4 ++--
>  drivers/crypto/inside-secure/eip93/eip93-hash.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/inside-secure/eip93/eip93-common.c b/drivers/crypto/inside-secure/eip93/eip93-common.c
> index f4ad6beff15e..75659a45ea5a 100644
> --- a/drivers/crypto/inside-secure/eip93/eip93-common.c
> +++ b/drivers/crypto/inside-secure/eip93/eip93-common.c
> @@ -687,12 +687,12 @@ void eip93_handle_result(struct eip93_device *eip93, struct eip93_cipher_reqctx
>  	if (rctx->sa_state_ctr)
>  		dma_unmap_single(eip93->dev, rctx->sa_state_ctr_base,
>  				 sizeof(*rctx->sa_state_ctr),
> -				 DMA_FROM_DEVICE);
> +				 DMA_TO_DEVICE);
>  
>  	if (rctx->sa_state)
>  		dma_unmap_single(eip93->dev, rctx->sa_state_base,
>  				 sizeof(*rctx->sa_state),
> -				 DMA_FROM_DEVICE);
> +				 DMA_TO_DEVICE);
>  
>  	if (!IS_ECB(rctx->flags))
>  		memcpy(reqiv, rctx->sa_state->state_iv, rctx->ivsize);
> diff --git a/drivers/crypto/inside-secure/eip93/eip93-hash.c b/drivers/crypto/inside-secure/eip93/eip93-hash.c
> index 2705855475b2..19a41a0db667 100644
> --- a/drivers/crypto/inside-secure/eip93/eip93-hash.c
> +++ b/drivers/crypto/inside-secure/eip93/eip93-hash.c
> @@ -67,7 +67,7 @@ void eip93_hash_handle_result(struct crypto_async_request *async, int err)
>  	int i;
>  
>  	dma_unmap_single(eip93->dev, rctx->sa_state_base,
> -			 sizeof(*sa_state), DMA_FROM_DEVICE);
> +			 sizeof(*sa_state), DMA_TO_DEVICE);
>  
>  	/*
>  	 * With partial_hash assume SHA256_DIGEST_SIZE buffer is passed.
> -- 
> 2.43.0
> 

-- 
	Ansuel

