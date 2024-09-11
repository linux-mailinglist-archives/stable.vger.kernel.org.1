Return-Path: <stable+bounces-75799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D1974BC2
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 09:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADC21F25A1F
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E5144D18;
	Wed, 11 Sep 2024 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JuZJx16U"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADE143889
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040845; cv=none; b=sGVWdG37lGL8tHRnihDc5cfd/PgG0vFgN+N8uu+KgaF4G6SZooj/RrMNk1oLNzUFuebpytgHngaKe3Q2ByQCwMM0VbfKUbyGiTk2hDVRsWmmaxpJ6BCkAzZC//++VzTF+WqYIy4Y55o0ghhqiPwkNBQIKShHq+nT/dUFSamzbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040845; c=relaxed/simple;
	bh=tTek+IULww2Ug4NMvT78CfoL7rlhrwqBsLlLsBmVw8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSisgNSPX8+IytM7Kuwg/48vJiCBnSAvFDqmX8k31qr2i+EwEL/BV/SUz/uiDydO7pRVZbz78iAYRg+minaXvJwIgD/8zBF45qg4Bc575ghCFmGTpcQ+KOZgjgw7rJIN5+v3cC6CLr8ZNpmOGtrz0+7+jo1F4DefHJRm2P+F1AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JuZJx16U; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f753375394so45533851fa.0
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726040842; x=1726645642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=02hgjzCFneoGj+Gs0ZYdmNXG9j+pI21SmbwPw8IGCh8=;
        b=JuZJx16UFRA71KPJrHHG+25v58INeD+R+aR2WVh7cv/5I1373oFm7kGv5+/PAjzk4u
         5AP6TxEH5j/0YveL1EEW5CnojrmiEQJzAKoLogYdx+2vAyo6WXalwIB9Z5kz8FRH4UJb
         69MAMpUBl7wLJHbdW7tYw7yKCt4KjwqXlr5lKbFbegAJh+80lTunA2D6Es2AUrN/3AZL
         LtomKyGZZdr+TH3aBKi25Z+bcRI6ap4YpsLiSJ2Ne6inst8s1RgZfV3aF0ePNEncYFmB
         OSCoqta4AxIgnTEO468dTv5syjwaHJnpwgTHKOZV2Lxc3M+EukEivbE8GzomEyoQRv6A
         jAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040842; x=1726645642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02hgjzCFneoGj+Gs0ZYdmNXG9j+pI21SmbwPw8IGCh8=;
        b=nDfIO7RircBMHC0EF7YEQmoUumJNvHwLb3HkThzQT+TXTIQtvvHKX6JzZRwrD/zQT/
         agSgGkW3+QVqSqFm2yMfVKEQlQCUzokJIx5IOFz7RKraomhJgSgWLA9gLvyIVt8vS+Km
         x8xLbFgPBHAV3v+fY/8smt+X2KLZO8YKBr+HEuHhs05XihNzLZ51MNwfUb7ACfDx6DFq
         +sgJ+tME2NNhcTEIqdwk3bNTdyr3wlBTQ8JcNZIO6GI2r2XBLE7jSkyryvzrKvcifJMF
         R15L9UuzL1Q8pOag6t0X0bTfZqf0mF5Zb1jVDxG38pEmwA3oO1nsAT5MYk3TmnPtAHIo
         Og0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHpkpXuuYPUWuZ5tunEcIvdMYIIBv04uciIiHvuecGggBvaDmPDA5jGrDoTCff4F5Igk1sut4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxSHZXmqKizgpCadWRp6ZCU4No83PrCqNgEpantwY9wl6MoJi
	nsyEHU2VoMuP9HZWDOz0zEMjkvuMnM8kVxKvfQiHwyso8oYGoPlQGyQbgkqvqg==
X-Google-Smtp-Source: AGHT+IHBeUa+sGLr0tImNUVMM9psqauQTY48vuHKwYoz6UU+t4460e8uf9t4REIKAvZBF5ozaNRW1w==
X-Received: by 2002:a2e:a581:0:b0:2f7:5a95:3a11 with SMTP id 38308e7fff4ca-2f75a953b16mr78532301fa.6.1726040840864;
        Wed, 11 Sep 2024 00:47:20 -0700 (PDT)
Received: from google.com (172.118.147.34.bc.googleusercontent.com. [34.147.118.172])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd467f5sm5104816a12.36.2024.09.11.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:47:19 -0700 (PDT)
Date: Wed, 11 Sep 2024 07:47:13 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, stable@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0
Message-ID: <ZuFLAacshitXFZ42@google.com>
References: <20240911055508.9588-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911055508.9588-1-song@kernel.org>

On Tue, Sep 10, 2024 at 10:55:08PM -0700, Song Liu wrote:
> bpf task local storage is now using task_struct->bpf_storage, so
> bpf_lsm_blob_sizes.lbs_task is no longer needed. Remove it to save some
> memory.

Makes sense to me.

Acked-by: Matt Bobrowski <mattbobrowski@google.com>

> Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
> Cc: stable@vger.kernel.org
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Matt Bobrowski <mattbobrowski@google.com>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/bpf/hooks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 57b9ffd53c98..3663aec7bcbd 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -31,7 +31,6 @@ static int __init bpf_lsm_init(void)
>  
>  struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
>  	.lbs_inode = sizeof(struct bpf_storage_blob),
> -	.lbs_task = sizeof(struct bpf_storage_blob),
>  };
>  
>  DEFINE_LSM(bpf) = {
> -- 
> 2.43.5

/M

