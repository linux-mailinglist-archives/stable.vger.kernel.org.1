Return-Path: <stable+bounces-75218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB879734E3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9EB3B28C1D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525CE192D60;
	Tue, 10 Sep 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqQOuWIe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C818F2DF
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964094; cv=none; b=Hgp2EVdKMCy4KnYaKH6+n77FxaxSYKjijHUfQsDlbLOWSYt8NHL9U6IaxF/k3nLsplAY23avyisdvUDVrsuVNVMMA5k3LlGo+iG1PWHi93q5FTHPk27GhD+HDg+5RXcR5vZZpX5bZLB0dCsQjRvvWFEpMJhYQYGZaJEbJmfYsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964094; c=relaxed/simple;
	bh=ZQp6yIcnl8l2XxeN3rYblPdnQi7olLMlw6LPzBLJN5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+S2utHDJnE69BE1EtXZj3xUUvizcT0uAsh2yPLSxD/X22FxMAMB/sjhNIZPgUW8s0CLxEF0b+txsAKlkSJXh6QDRze4OMKIOqNZR/spjac5pFWKaz4yr1xf74/JreDwA4TVo5tf5oIlGHVqmB5HOh+HXq4k7hx1p4J4drJkRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqQOuWIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28407C4CEC3;
	Tue, 10 Sep 2024 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725964093;
	bh=ZQp6yIcnl8l2XxeN3rYblPdnQi7olLMlw6LPzBLJN5M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qqQOuWIer2Jh9SIDWgHoFcyynKz9sH3lSCjaBqYfpYLfAYA/rFYGsPeuhjnH1Dvss
	 2I2X3bSubAkqOYzb23Xh5VV/G+1KkU40xrM8GCJIBZt46FWTPGlPujrcgGbRwgFnBD
	 +ZUH/hqGF7aunexGEi+UZWiqrmU9DzfwwswCY9gOqanop8kAyvsC+hIrC3Wf7fGgBD
	 1yXN/beZ1U9NnLkTQAXib/uizA4m3PvhgasmFSgEGv0ARjfkPoviEE1Uku34IeJqPf
	 JtnEMbAI9wGsnkG7lwmMI1hLAWz/JenSvu0a8vYwwKDvkL4LwH04+gjM8L7KLtqL3y
	 6I99ionpXxr0Q==
Message-ID: <6d2da30d-96ed-4a55-97f2-50a0eadbb41f@kernel.org>
Date: Tue, 10 Sep 2024 12:28:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/nouveau/fb: restore init() for ramgp102
To: Ben Skeggs <bskeggs@nvidia.com>
Cc: nouveau@lists.freedesktop.org, stable@vger.kernel.org
References: <20240904232418.8590-1-bskeggs@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20240904232418.8590-1-bskeggs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 1:24 AM, Ben Skeggs wrote:
> init() was removed from ramgp102 when reworking the memory detection, as
> it was thought that the code was only necessary when the driver performs
> mclk changes, which nouveau doesn't support on pascal.
> 
> However, it turns out that we still need to execute this on some GPUs to
> restore settings after DEVINIT, so revert to the original behaviour.
> 
> v2: fix tags in commit message, cc stable
> 
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/319
> Fixes: 2c0c15a22fa0 ("drm/nouveau/fb/gp102-ga100: switch to simpler vram size detection method")
> Cc: <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>

Applied to drm-misc-fixes, thanks!

> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h      | 2 ++
>   drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c | 1 +
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h
> index 50f0c1914f58..4c3f74396579 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h
> @@ -46,6 +46,8 @@ u32 gm107_ram_probe_fbp(const struct nvkm_ram_func *,
>   u32 gm200_ram_probe_fbp_amount(const struct nvkm_ram_func *, u32,
>   			       struct nvkm_device *, int, int *);
>   
> +int gp100_ram_init(struct nvkm_ram *);
> +
>   /* RAM type-specific MR calculation routines */
>   int nvkm_sddr2_calc(struct nvkm_ram *);
>   int nvkm_sddr3_calc(struct nvkm_ram *);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
> index 378f6fb70990..8987a21e81d1 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
> @@ -27,7 +27,7 @@
>   #include <subdev/bios/init.h>
>   #include <subdev/bios/rammap.h>
>   
> -static int
> +int
>   gp100_ram_init(struct nvkm_ram *ram)
>   {
>   	struct nvkm_subdev *subdev = &ram->fb->subdev;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c
> index 8550f5e47347..b6b6ee59019d 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c
> @@ -5,6 +5,7 @@
>   
>   static const struct nvkm_ram_func
>   gp102_ram = {
> +	.init = gp100_ram_init,
>   };
>   
>   int

