Return-Path: <stable+bounces-71550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2A965345
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 01:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722CAB219D1
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D0718E37E;
	Thu, 29 Aug 2024 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dUn3iWfy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988B18B47D
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972928; cv=none; b=SEelFZ0z5cV0PtlFmeaMdS79qs2XZgeevh29oKiJbvYjWU36dJDhSuTFZF5JKipUnzaCb19+sFwBpMLrpvHoKSuMy/ofx4zq3V8Hu9t0VPGRNeMVyWb39w7z0FyHz8kfemLZOV/iSxcMI4t5Ltbi7AHrn3TpsJRVzVmXqeu9vX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972928; c=relaxed/simple;
	bh=oEhdU27rm+H122x0J06f7tWH2tcOqaSJecjN31uJNgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J//4XV1Uh93Ukpsoy+qnQwPDhufqYlfaaBcibnk2zP6xMniF5TtJLbZcP3HkGvOrCVqyDSw+0nkZxe9QqHSo8v8uIwLk15PKjPkklQGEy6AspD2PSplbGP67zbEIKtFetuuY5BXNLP17ZpaAD69Rm+V2P5fHRBTmMO4GUKZFI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dUn3iWfy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20230059241so11098655ad.3
        for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724972925; x=1725577725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgVDj+jfQTykac+tyDyMarRYMWlwS6Q2qsgwnJuZfh0=;
        b=dUn3iWfyizWQTAk4TYMnk3flYOK9+ai5VXNDL2Lf46S6F9AX0u689wDcPxot9XEc4O
         bJYBon/MajEE+tERXc5DnvE2wOydKQjUqcwvVRjX+fQLT1mhIDBWMRlnoBGqKn4KaGzj
         voCqIjgdj0td8q+b6ZiMfgZ/hE67cyqoYfBt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724972925; x=1725577725;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgVDj+jfQTykac+tyDyMarRYMWlwS6Q2qsgwnJuZfh0=;
        b=SFDQjmy0sCqoRxnBPuIa0avlU+isw82yM+M68tfd2NcPFFKpfTPpsDykwng1mE1XDC
         msm0F+TReJSeIDTAE+mwAKUv3KuB3BfzT4qnmyDYW/My3RwDYlD5pLOoaBqQPRgBICkj
         jrmf5HpZ4HG4/pAF5mkzaJ/piTeGjhwVoqN73qBOpT1ynkcQilnaYfuuLa+LzsWiptg8
         koirUfqWGZNSGB6CwefQ36m/UI0P79Xw/UpuScv7k6kNVp86ZD37Sgg5yCh7HPzAVuqp
         ps1JrmQsRrGq+NJxa6nNHkrAfc2lsLZk0NNjjqj9yEGARWNZ0MyNvUygiskFDOcH0kHJ
         b2OA==
X-Forwarded-Encrypted: i=1; AJvYcCVj8fyuoIL6fYlj8sxIsJ9VU6ldGN+wk/eazA+qEzdMSesYrHQJiAtJ8xwdUrs2Z6XcTzzaaDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+/YBpkY0bxROs0Vp3BWe5Ozfl1dchUTCq1hpCdLeNIL5d4jc
	yARi6YNgv5qL/MA1kcJFViuxFpDbvHzbcPEmCkF8nd3xd7MaeVkZv6+YqVuNyQ==
X-Google-Smtp-Source: AGHT+IHx0S+q6RNjDk9ZvBL2wqUSFukR2NjucZxBJM3TzlabNfu6Puq9dgskFALAl15H42KIm5Whaw==
X-Received: by 2002:a17:90b:1a8a:b0:2c3:2557:3de8 with SMTP id 98e67ed59e1d1-2d8564a29d3mr4791127a91.33.1724972925314;
        Thu, 29 Aug 2024 16:08:45 -0700 (PDT)
Received: from [10.211.103.201] ([216.221.25.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b39d90csm2275967a91.38.2024.08.29.16.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 16:08:44 -0700 (PDT)
Message-ID: <1ab03e92-9b3d-45a8-8561-d0b527d6d4a7@broadcom.com>
Date: Thu, 29 Aug 2024 16:08:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vmwgfx: Cleanup kms setup without 3d
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com,
 martin.krastev@broadcom.com, stable@vger.kernel.org
References: <20240827043905.472825-1-zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20240827043905.472825-1-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/24 21:39, Zack Rusin wrote:
> Do not validate format equality for the non 3d cases to allow xrgb to
> argb copies and make sure the dx binding flags are only used
> on dx compatible surfaces.
> 
> Fixes basic 2d kms setup on configurations without 3d. There's little
> practical benefit to it because kms framebuffer coherence is disabled
> on configurations without 3d but with those changes the code actually
> makes sense.
> 
> v2: Remove the now unused format variable
> 
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.9+
> Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
> Cc: Martin Krastev <martin.krastev@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c     | 29 -------------------------
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  9 +++++---
>  2 files changed, 6 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> index 288ed0bb75cb..282b6153bcdd 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -1283,7 +1283,6 @@ static int vmw_kms_new_framebuffer_surface(struct vmw_private *dev_priv,
>  {
>  	struct drm_device *dev = &dev_priv->drm;
>  	struct vmw_framebuffer_surface *vfbs;
> -	enum SVGA3dSurfaceFormat format;
>  	struct vmw_surface *surface;
>  	int ret;
>  
> @@ -1320,34 +1319,6 @@ static int vmw_kms_new_framebuffer_surface(struct vmw_private *dev_priv,
>  		return -EINVAL;
>  	}
>  
> -	switch (mode_cmd->pixel_format) {
> -	case DRM_FORMAT_ARGB8888:
> -		format = SVGA3D_A8R8G8B8;
> -		break;
> -	case DRM_FORMAT_XRGB8888:
> -		format = SVGA3D_X8R8G8B8;
> -		break;
> -	case DRM_FORMAT_RGB565:
> -		format = SVGA3D_R5G6B5;
> -		break;
> -	case DRM_FORMAT_XRGB1555:
> -		format = SVGA3D_A1R5G5B5;
> -		break;
> -	default:
> -		DRM_ERROR("Invalid pixel format: %p4cc\n",
> -			  &mode_cmd->pixel_format);
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * For DX, surface format validation is done when surface->scanout
> -	 * is set.
> -	 */
> -	if (!has_sm4_context(dev_priv) && format != surface->metadata.format) {
> -		DRM_ERROR("Invalid surface format for requested mode.\n");
> -		return -EINVAL;
> -	}
> -
>  	vfbs = kzalloc(sizeof(*vfbs), GFP_KERNEL);
>  	if (!vfbs) {
>  		ret = -ENOMEM;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> index 1625b30d9970..5721c74da3e0 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -2276,9 +2276,12 @@ int vmw_dumb_create(struct drm_file *file_priv,
>  	const struct SVGA3dSurfaceDesc *desc = vmw_surface_get_desc(format);
>  	SVGA3dSurfaceAllFlags flags = SVGA3D_SURFACE_HINT_TEXTURE |
>  				      SVGA3D_SURFACE_HINT_RENDERTARGET |
> -				      SVGA3D_SURFACE_SCREENTARGET |
> -				      SVGA3D_SURFACE_BIND_SHADER_RESOURCE |
> -				      SVGA3D_SURFACE_BIND_RENDER_TARGET;
> +				      SVGA3D_SURFACE_SCREENTARGET;
> +
> +	if (vmw_surface_is_dx_screen_target_format(format)) {
> +		flags |= SVGA3D_SURFACE_BIND_SHADER_RESOURCE |
> +			 SVGA3D_SURFACE_BIND_RENDER_TARGET;
> +	}
>  
>  	/*
>  	 * Without mob support we're just going to use raw memory buffer

LGTM

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>

