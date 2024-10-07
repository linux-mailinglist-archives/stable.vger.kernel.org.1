Return-Path: <stable+bounces-81306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF7992DDB
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA5D1C22EB6
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCF11D45FF;
	Mon,  7 Oct 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DctWvKJa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45A1D4354;
	Mon,  7 Oct 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309243; cv=none; b=Y8MMP+rozfL0ve0yqMvydMCdTpsYyegoB0EYgZzGRfMw7khKxiSWlrGshO538RMQpwjODx+AmC2oz2KQxb5ARljvIbDr8RFrbiuXwxSKePtpTqb+E/Yok0qQJ1ThvqriSZ4OHqjeMaPz4kjPBh+JQhmq5+xV8CT91bgiz1vAEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309243; c=relaxed/simple;
	bh=OqTgQbaF1Wymp6tKgKCQ/wtWZC34eQBotCaVLTmxZLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKAOxhY/OF643JNmob447epqDpVAp0DmZOtpt3DrPaDTWcHoEGMEvxDyFGsXyEJJqjhs/JdxSEELxRfhmerld+mNFd3g69rH33Rhe6MtJmTCfbvGbb2mA9rNeCH+bz0Lxg1FigS2v9F7LO8WthlQ5Wvg+qUXkJy1eUvjYkSXQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DctWvKJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4082FC4CEC6;
	Mon,  7 Oct 2024 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728309243;
	bh=OqTgQbaF1Wymp6tKgKCQ/wtWZC34eQBotCaVLTmxZLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DctWvKJa5JQaX+NffcrwW411WL8HqFa26Ui3O2VffAPTPyX3gmFF3E6MzGZkQB/Xr
	 XVqZnwBA3ox8xdkaQZN+ND5N2xSDCTgIhIuwMwCVD0AIoM5K5JcfVzMmDBWzV4ihbE
	 qXUqs7r/+DuszgI++u2396nKyh9fB+JV6/IEZzv6r0XSnTPGFMe+TDUXZTcB915kBV
	 mJCPOl3lKNKLrsq3zEkG9pJvmzzmMeRG6i/AW3+rqqYL7f6EmG6I3mnx4gfH3hF0IM
	 Bf8e5JNhr9kJZOoR3jTYnIPSwCDog0idaXUpKNT7hib+e9cqs5bE0MVhcbnvI79q4K
	 AeAtnTSUf2cXw==
Date: Mon, 7 Oct 2024 15:53:57 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
	airlied@gmail.com, daniel@ffwll.ch, bskeggs@nvidia.com,
	jglisse@redhat.com, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 1/2] nouveau/dmem: Fix privileged error in copy engine
 channel
Message-ID: <ZwPn9Z1IPlB65zd-@pollux>
References: <20241007132700.982800-1-ymaman@nvidia.com>
 <20241007132700.982800-2-ymaman@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007132700.982800-2-ymaman@nvidia.com>

On Mon, Oct 07, 2024 at 04:26:59PM +0300, Yonatan Maman wrote:
> From: Yonatan Maman <Ymaman@Nvidia.com>
> 
> When `nouveau_dmem_copy_one` is called, the following error occurs:
> 
> [272146.675156] nouveau 0000:06:00.0: fifo: PBDMA9: 00000004 [HCE_PRIV]
> ch 1 00000300 00003386
> 
> This indicates that a copy push command triggered a Host Copy Engine
> Privileged error on channel 1 (Copy Engine channel). To address this
> issue, modify the Copy Engine channel to allow privileged push commands
> 
> Fixes: 6de125383a5c ("drm/nouveau/fifo: expose runlist topology info on all chipsets")
> Signed-off-by: Yonatan Maman <Ymaman@Nvidia.com>
> Signed-off-by: Gal Shalom <GalShalom@Nvidia.com>

Again, why is this signed-off by Gal? If he's a co-author, please add the
corresponding tag.

Please also see my reply to the previous version.

> Reviewed-by: Ben Skeggs <bskeggs@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index a58c31089613..0a75ce4c5021 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -356,7 +356,7 @@ nouveau_accel_ce_init(struct nouveau_drm *drm)
>  		return;
>  	}
>  
> -	ret = nouveau_channel_new(drm, device, false, runm, NvDmaFB, NvDmaTT, &drm->cechan);
> +	ret = nouveau_channel_new(drm, device, true, runm, NvDmaFB, NvDmaTT, &drm->cechan);
>  	if (ret)
>  		NV_ERROR(drm, "failed to create ce channel, %d\n", ret);
>  }
> -- 
> 2.34.1
> 

