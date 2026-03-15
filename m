Return-Path: <stable+bounces-225477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNuMMm3WtmkDJgEAu9opvQ
	(envelope-from <stable+bounces-225477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 16:55:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E66291498
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 16:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD89D300C03D
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DDF371CE2;
	Sun, 15 Mar 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGkfcsd/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+2ZAl0y"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9217370D60
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590121; cv=none; b=XN3Uoj2VJkO+9u5fxiNVrnxFCMUTq6JeRIRpbV3mKjfGFtu6Hqn0+hMsdSO4cVG8pcthSV+jDfJlCMDtztrXOaEAEjil70Qii8aRvMPRWuzXsj3KtKDYYJzv9h4Y/D1WWHE7RH0+Rb9sMPp7brObcINSVPlfouUapXHyQR239HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590121; c=relaxed/simple;
	bh=2qTLxckE9oMDjwMxGCBaza0lbBYLuX0cOOAxPmFeG0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To1xSh3kFwgNvvuuQ9rpKt0kIe3uJfI6kQFNrO8298tmkRggr8d+Rdj4bY19W4w2EsVdpnLBOruJ9sOng2FkDMobOA4SZJUpnCHHhvCT6ZAFr3A3M6ttOkEjbBeu5WYupD2zbIK28fx6pC5f+laphuBmW1HylnLN/9Z2Jo+cUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGkfcsd/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+2ZAl0y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773590119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQ3rAvJPMukjRlEJsiY79XXn5O5j6UdqZxcxui6ZZRY=;
	b=KGkfcsd/xLDztUSyaML8zaQLFMYhRRGWYT5cL4pCuxiGAQyWiFQMK/xF41XglfYTV69H91
	jpwYziov3CZsKHowhUO2NKt/6M3DaN+4xU6Av42sqqgmR/OSwv1zCqzmCbLRa2+/0gkALn
	3S/ZokidttAMS75T+y3fqSQpjXJLgYk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-sIudZJhLPTOBnRg_PK8FCg-1; Sun, 15 Mar 2026 11:55:17 -0400
X-MC-Unique: sIudZJhLPTOBnRg_PK8FCg-1
X-Mimecast-MFC-AGG-ID: sIudZJhLPTOBnRg_PK8FCg_1773590117
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b059511554so2661755ad.0
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773590116; x=1774194916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ3rAvJPMukjRlEJsiY79XXn5O5j6UdqZxcxui6ZZRY=;
        b=F+2ZAl0yeFz29YJNQWKx8AbT6mMBx/3iserbsufjJib9A5R0ZiGwyfe/0Y1T4x6Afe
         v94+LclcBsr+V85l0yfk7jswguN//VMErIiTu55GvEWSdWSd8W8FqH1PteOm52euJt8K
         5u8koHdOUZ1pthQguz9N/95OOVqhzrFEH/Y3NXmpU3v1Wrv0sPzw2WkSoI5L/WVVIcyP
         q1zIkDyadboWs/gSLaFwX68fXVTfY2d5MOOIA4oBl1J0UCG+dRABUNaVGgvG8CdmWk7H
         rRwu+T3DMYYR4+qMPfHIFtwo/21IkZiouqgEylXFjq76Tqz0XtikKIau5md9+Yssmar2
         cRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773590116; x=1774194916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ3rAvJPMukjRlEJsiY79XXn5O5j6UdqZxcxui6ZZRY=;
        b=F4ZBfbD4jkCzuIwkd80VEWyAzoZPBcDEzwIwXjxkN37PVvwZe/oLUoNMX+RNoNlQw2
         ypIJWXmYLXUebej1xgt/FIP2kX7Plvtdm26tJzj3Nw2/XtlghEPd2l97WxGjSTVdk3xN
         GuulRqn3uO7FoiYashAH6arboCydGppFjBoE/0OhVNU6sLnp850lZsJxAmQENCP5lhiK
         pUHeiqrdC/sdO6fPfg3RzctB5HOyZDN+4GEXHSfpydL98AqAlvxj+SzBJ0ljFBy9wy8g
         224eZPZIpK9c6yJz14FqYEUq91BJL+2RGInUEQ/Cg4S+bzEos4MpfFBoiirU9J9c9qQa
         9eaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEtWg1Uhwg5uERbaRYM/AxdqTsH3bBxiDHZwDzKJUBjdr1vVwili/RgHWRlMxY8wS8ZB+EtZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzryJ4FrB8by5VAeMHFJVNc2pn8zQi7Y5xsutgeaQPq4gnF3rsW
	w9wPhiRu2J6rY9ufI46VCC4Qp/MMFJIXaivorjPbEAFwtrWFCvzwjzsiP/4X8D/hEV5nzFyOG6f
	DxkVNm123F8ntV3jRcIxQ6IhLYXRTzCRibQFzfZeO4LOuCDAtUdr/RwZEjw==
X-Gm-Gg: ATEYQzysRtAqt2rt3pQsfdeEbC4Yy70gVTRDzSYtgA/TODn0r6LrBfxA2LAlKWQeeHV
	HuUgQKb5aMfowYSGMHd+/PC+cI80euB6jtJyZioJvuqNd938RYyE8ni4f2sFQkxr3y7fK/XZJJv
	wDMcRk4HGxqM89ELxXReHWIjpW+8rEk+F+3G96S4zvV98vqFMhMMe0ismPtuvuZhH6AT6w3/xgH
	ViMyKN/3quGNFbfH7FpuToJA3CxeMabVTjjrgeQnZ9CIbdECcLjqSVD9RxzXf2GFsWBps0kI8Vu
	3zKlR1SRvmxn9bFaGS+CWJGGFkBfSmk5tMpxcXJXzQ8rbaacgHsfQqm1d3M2vjufslYXHtPhqfb
	AsGYhu/V7aQnr3N8oJw==
X-Received: by 2002:a17:902:ea06:b0:2ae:4b91:8407 with SMTP id d9443c01a7336-2aecaaa861amr105927385ad.34.1773590116493;
        Sun, 15 Mar 2026 08:55:16 -0700 (PDT)
X-Received: by 2002:a17:902:ea06:b0:2ae:4b91:8407 with SMTP id d9443c01a7336-2aecaaa861amr105927135ad.34.1773590116029;
        Sun, 15 Mar 2026 08:55:16 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c701sm106718375ad.37.2026.03.15.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:55:15 -0700 (PDT)
Date: Sun, 15 Mar 2026 23:55:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org,
	Akhil R <akhilrajeev@nvidia.com>
Subject: Re: [PATCH] crypto: tegra - Add missing CRYPTO_ALG_ASYNC
Message-ID: <20260315155510.myp3i7jhzs654zr2@doltdoltdolt>
References: <20260314165515.9678-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314165515.9678-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,vger.kernel.org,gmail.com,nvidia.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225477-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78E66291498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 09:55:15AM -0700, Eric Biggers wrote:
> The tegra crypto driver failed to set the CRYPTO_ALG_ASYNC on its
> asynchronous algorithms, causing the crypto API to select them for users
> that request only synchronous algorithms.  This causes crashes (at
> least).  Fix this by adding the flag like what the other drivers do.
> 
> Reported-by: Zorro Lang <zlang@redhat.com>
> Closes: https://lore.kernel.org/r/20260314080937.pghb4aa7d4je3mhh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com
> Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
> Cc: stable@vger.kernel.org
> Cc: Akhil R <akhilrajeev@nvidia.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Thanks for you quick response, Eric. This fix works on my side. With this patch,
same reproducer can't trigger that bug anymore.

Thanks,
Zorro

> 
> This patch is targeting crypto/master
> 
>  drivers/crypto/tegra/tegra-se-aes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/tegra-se-aes.c
> index 0e07d0523291a..cb97a59084519 100644
> --- a/drivers/crypto/tegra/tegra-se-aes.c
> +++ b/drivers/crypto/tegra/tegra-se-aes.c
> @@ -592,10 +592,11 @@ static struct tegra_se_alg tegra_aes_algs[] = {
>  			.ivsize	= AES_BLOCK_SIZE,
>  			.base = {
>  				.cra_name = "xts(aes)",
>  				.cra_driver_name = "xts-aes-tegra",
>  				.cra_priority = 500,
> +				.cra_flags = CRYPTO_ALG_ASYNC,
>  				.cra_blocksize = AES_BLOCK_SIZE,
>  				.cra_ctxsize	   = sizeof(struct tegra_aes_ctx),
>  				.cra_alignmask	   = (__alignof__(u64) - 1),
>  				.cra_module	   = THIS_MODULE,
>  			},
> @@ -1920,10 +1921,11 @@ static struct tegra_se_alg tegra_aead_algs[] = {
>  			.ivsize	= GCM_AES_IV_SIZE,
>  			.base = {
>  				.cra_name = "gcm(aes)",
>  				.cra_driver_name = "gcm-aes-tegra",
>  				.cra_priority = 500,
> +				.cra_flags = CRYPTO_ALG_ASYNC,
>  				.cra_blocksize = 1,
>  				.cra_ctxsize = sizeof(struct tegra_aead_ctx),
>  				.cra_alignmask = 0xf,
>  				.cra_module = THIS_MODULE,
>  			},
> @@ -1942,10 +1944,11 @@ static struct tegra_se_alg tegra_aead_algs[] = {
>  			.chunksize = AES_BLOCK_SIZE,
>  			.base = {
>  				.cra_name = "ccm(aes)",
>  				.cra_driver_name = "ccm-aes-tegra",
>  				.cra_priority = 500,
> +				.cra_flags = CRYPTO_ALG_ASYNC,
>  				.cra_blocksize = 1,
>  				.cra_ctxsize = sizeof(struct tegra_aead_ctx),
>  				.cra_alignmask = 0xf,
>  				.cra_module = THIS_MODULE,
>  			},
> @@ -1969,11 +1972,11 @@ static struct tegra_se_alg tegra_cmac_algs[] = {
>  			.halg.statesize = sizeof(struct tegra_cmac_reqctx),
>  			.halg.base = {
>  				.cra_name = "cmac(aes)",
>  				.cra_driver_name = "tegra-se-cmac",
>  				.cra_priority = 300,
> -				.cra_flags = CRYPTO_ALG_TYPE_AHASH,
> +				.cra_flags = CRYPTO_ALG_TYPE_AHASH | CRYPTO_ALG_ASYNC,
>  				.cra_blocksize = AES_BLOCK_SIZE,
>  				.cra_ctxsize = sizeof(struct tegra_cmac_ctx),
>  				.cra_alignmask = 0,
>  				.cra_module = THIS_MODULE,
>  				.cra_init = tegra_cmac_cra_init,
> 
> base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
> -- 
> 2.53.0
> 


