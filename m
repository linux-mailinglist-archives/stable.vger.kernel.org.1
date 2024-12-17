Return-Path: <stable+bounces-104436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74B99F4452
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F3416C891
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 06:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF041B392E;
	Tue, 17 Dec 2024 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2XI3sKjR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072B18C008
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417766; cv=none; b=WkR1TVybV//ctMHQUcRkfz7sFASJSdVLvVrjXda+NnuNVHyuNxxho4fxQ8bnVRkkOkMzXPg8/xhjxQx9UKf3p4pOqItCJCAGdqlZM4VZaanebJhcC3rwaQeZEcz7dKVNZ20OJdDkAL12QODRu3t2dz5rtm7Cf591CdfC7w1RtUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417766; c=relaxed/simple;
	bh=5L+iHiCh2EMZUpl76aR4KY7I5tgLJUe0PiE1/64p9Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYRg1ke1PQUKxta5aCPPewcttljTDMoZgNKXkz6+u4Z/J7+53qjnOoPOgKWZDq4i3wqeJDtgYRR8cDqTqnHEUb/T88A9kWGk+5eAyeHiK6DEAxGWHu32M+q3T+rP9CeQ79ezIrGv60hrI6dEikJHfmSsH24sTowUtTuVpow+IWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2XI3sKjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AAEC4CEDD;
	Tue, 17 Dec 2024 06:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734417766;
	bh=5L+iHiCh2EMZUpl76aR4KY7I5tgLJUe0PiE1/64p9Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2XI3sKjR7GhbPLYw3KjTja2ke3pkG97YsbIEaDPUYihdCOHHhHlQTPzSFvv0Lq3wE
	 0SzJNLaNEvLIkyYKPi6qNDhWqFcDhaomhwkQwpduqB7Osh4w3AHCZXXCGV75o/M68x
	 G6TNF2PSVNaF8rsvm5igmXJnMMG2P3GaRKeSQzvw=
Date: Tue, 17 Dec 2024 07:42:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] drm/i915: Fix memory leak by correcting cache
 object name in error handler
Message-ID: <2024121753-ivy-busload-126f@gregkh>
References: <2024121517-deserve-wharf-c2d0@gregkh>
 <20241216161840.4815-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216161840.4815-1-jiashengjiangcool@gmail.com>

On Mon, Dec 16, 2024 at 04:18:40PM +0000, Jiasheng Jiang wrote:
> Replace "slab_priorities" with "slab_dependencies" in the error handler
> to avoid memory leak.
> 
> Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  drivers/gpu/drm/i915/i915_scheduler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i915_scheduler.c
> index cbb880b10c65..a58b70444abd 100644
> --- a/drivers/gpu/drm/i915/i915_scheduler.c
> +++ b/drivers/gpu/drm/i915/i915_scheduler.c
> @@ -538,6 +538,6 @@ int __init i915_global_scheduler_init(void)
>  	return 0;
>  
>  err_priorities:
> -	kmem_cache_destroy(global.slab_priorities);
> +	kmem_cache_destroy(global.slab_dependencies);
>  	return -ENOMEM;
>  }
> -- 
> 2.25.1

What is the git commit id of this change?

