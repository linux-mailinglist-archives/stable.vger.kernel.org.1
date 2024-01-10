Return-Path: <stable+bounces-10459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C882A2E0
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 21:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89CB1C2669C
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE84E4F884;
	Wed, 10 Jan 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="er++31QG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32EA4EB5B
	for <stable@vger.kernel.org>; Wed, 10 Jan 2024 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3ec3db764so18815825ad.2
        for <stable@vger.kernel.org>; Wed, 10 Jan 2024 12:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704919899; x=1705524699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOBazkvMgX805NND/Uz9nsNSYNAIdmzax0775Z5ILnQ=;
        b=er++31QGOb++y4WvOxM0itPyZa5SkCSps36eITddCjYNFTxDpvGTgn6JxnegGBOFrA
         XKK3zyTP0ccoHAnTomYefbZTv0JqRZKWRP9viPvaPpsXaw4NlX01xv+2V8fncNqrNP5P
         vxb1ILvb838MgAFipJKq6NLF678Xtg+LeNEiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704919899; x=1705524699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOBazkvMgX805NND/Uz9nsNSYNAIdmzax0775Z5ILnQ=;
        b=OKwzCHRZbnPVZn94+rwP1j7dZ8XVO989OKhDYJjqoUcYjmUChSV/FwmnnX8OMl9jH9
         hue0yb0y3qJDmNhkpIVRvbF/ezMLUkgt9TMm85OaKp8mr2TurDbqB7rQoKmKNS2Jzo0I
         3f1rd2re820N1qtGE4MdxSnegDjsUx6DTiY28eZ23gImkw3fK/8BmebcfEfUldBBK3XS
         NaEiGS8CGPSmkT/RXgb2vvIqa+z6KbLiDG0hrOFYYfwQX0+cRg5+esItK9dMDvHf12ki
         ZTk+KuLfsALlcHivIy5T5/MvC8PXtgnXc/9FPJM9UDUUZztZY2FC6Da88gG0a0kIjV8C
         Uujg==
X-Gm-Message-State: AOJu0YxOXKeGwg3aNVi3ttwSAB9VDtBlAcr9kW4lvBJQ84JFfHphdVRQ
	ZHwVchEvIc1jvDR+GmwD1laXih9EbIks
X-Google-Smtp-Source: AGHT+IGrznJ6BRQfiWRF3XgwyFwgLMHvH7dK72c50SFsH9eK6+i9kQ932AMv+JS4DP3HOvoPRz7iKg==
X-Received: by 2002:a17:902:6ac4:b0:1d5:73b6:e1df with SMTP id i4-20020a1709026ac400b001d573b6e1dfmr151930plt.19.1704919899068;
        Wed, 10 Jan 2024 12:51:39 -0800 (PST)
Received: from [10.20.136.39] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001d4e058284esm4094902plg.89.2024.01.10.12.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 12:51:38 -0800 (PST)
Message-ID: <91232aa9-84ce-4417-97aa-449cafdc7d08@broadcom.com>
Date: Wed, 10 Jan 2024 12:51:36 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Fix possible null pointer derefence with
 invalid contexts
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, Niels De Graef <ndegraef@redhat.com>,
 Martin Krastev <martin.krastev@broadcom.com>,
 Ian Forbes <ian.forbes@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <20240110200305.94086-1-zack.rusin@broadcom.com>
Content-Language: en-US
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
In-Reply-To: <20240110200305.94086-1-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/24 12:03, Zack Rusin wrote:
> vmw_context_cotable can return either an error or a null pointer and its
> usage sometimes went unchecked. Subsequent code would then try to access
> either a null pointer or an error value.
> 
> The invalid dereferences were only possible with malformed userspace
> apps which never properly initialized the rendering contexts.
> 
> Check the results of vmw_context_cotable to fix the invalid derefs.
> 
> Thanks:
> ziming zhang(@ezrak1e) from Ant Group Light-Year Security Lab
> who was the first person to discover it.
> Niels De Graef who reported it and helped to track down the poc.
> 
> Fixes: 9c079b8ce8bf ("drm/vmwgfx: Adapt execbuf to the new validation api")
> Cc: <stable@vger.kernel.org> # v4.20+
> Reported-by: Niels De Graef  <ndegraef@redhat.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Martin Krastev <martin.krastev@broadcom.com>
> Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
> Cc: Ian Forbes <ian.forbes@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> index 272141b6164c..4f09959d27ba 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -447,7 +447,7 @@ static int vmw_resource_context_res_add(struct vmw_private *dev_priv,
>  	    vmw_res_type(ctx) == vmw_res_dx_context) {
>  		for (i = 0; i < cotable_max; ++i) {
>  			res = vmw_context_cotable(ctx, i);
> -			if (IS_ERR(res))
> +			if (IS_ERR_OR_NULL(res))
>  				continue;
>  
>  			ret = vmw_execbuf_res_val_add(sw_context, res,
> @@ -1266,6 +1266,8 @@ static int vmw_cmd_dx_define_query(struct vmw_private *dev_priv,
>  		return -EINVAL;
>  
>  	cotable_res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXQUERY);
> +	if (IS_ERR_OR_NULL(cotable_res))
> +		return cotable_res ? PTR_ERR(cotable_res) : -EINVAL;
>  	ret = vmw_cotable_notify(cotable_res, cmd->body.queryId);
>  
>  	return ret;
> @@ -2484,6 +2486,8 @@ static int vmw_cmd_dx_view_define(struct vmw_private *dev_priv,
>  		return ret;
>  
>  	res = vmw_context_cotable(ctx_node->ctx, vmw_view_cotables[view_type]);
> +	if (IS_ERR_OR_NULL(res))
> +		return res ? PTR_ERR(res) : -EINVAL;
>  	ret = vmw_cotable_notify(res, cmd->defined_id);
>  	if (unlikely(ret != 0))
>  		return ret;
> @@ -2569,8 +2573,8 @@ static int vmw_cmd_dx_so_define(struct vmw_private *dev_priv,
>  
>  	so_type = vmw_so_cmd_to_type(header->id);
>  	res = vmw_context_cotable(ctx_node->ctx, vmw_so_cotables[so_type]);
> -	if (IS_ERR(res))
> -		return PTR_ERR(res);
> +	if (IS_ERR_OR_NULL(res))
> +		return res ? PTR_ERR(res) : -EINVAL;
>  	cmd = container_of(header, typeof(*cmd), header);
>  	ret = vmw_cotable_notify(res, cmd->defined_id);
>  
> @@ -2689,6 +2693,8 @@ static int vmw_cmd_dx_define_shader(struct vmw_private *dev_priv,
>  		return -EINVAL;
>  
>  	res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXSHADER);
> +	if (IS_ERR_OR_NULL(res))
> +		return res ? PTR_ERR(res) : -EINVAL;
>  	ret = vmw_cotable_notify(res, cmd->body.shaderId);
>  	if (ret)
>  		return ret;
> @@ -3010,6 +3016,8 @@ static int vmw_cmd_dx_define_streamoutput(struct vmw_private *dev_priv,
>  	}
>  
>  	res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_STREAMOUTPUT);
> +	if (IS_ERR_OR_NULL(res))
> +		return res ? PTR_ERR(res) : -EINVAL;
>  	ret = vmw_cotable_notify(res, cmd->body.soid);
>  	if (ret)
>  		return ret;

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

Thanks,

Maaz Mombasawala <maaz.mombasawala@broadcom.com>


