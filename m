Return-Path: <stable+bounces-33089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95E78902A5
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 16:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7016028DF08
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056683A14;
	Thu, 28 Mar 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvKoS0N1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1BE1F956
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638540; cv=none; b=q9ywVTYQlieFhOGtp84U9+OiAhyLGa0H4KtYAFflMJEhvqzK0PjStUmDfoD3GMZ5bMnegJdizBAjTIocwzvHb52hjNlvcI1zWpGrpVQxTQQXIf4Fv9yEYU4QnCJgnu6dtVUsBhV3XUDjBELTKJXbaq+7Vbo6PzR0gjdKuKUUMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638540; c=relaxed/simple;
	bh=MJjNKJHOjyXQEhxmtw95z+KdJ3i3xDYWsBDk0pLDFn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InVkVQXJ71v3YZZdlydpf93xRHrrm4Ze03Oakroe08K+7keU4zMPRlJMG8u6c94aL5LeS6PxlWtRcO+dW24Ul6Tjfh4l3XOz8v0fPxRP/uBawXwxi0bYJ7IIvmijVfyDc7bLN+mQ4TR5wmhl22tpbod1+IsT2LLBcpZl31Cy2nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvKoS0N1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711638537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mSa1UH5ZKNr2vj44ux4HGmes84oVNKmwJwueXqJQ4U=;
	b=OvKoS0N1nHV3sHZmZ+PVyMjVsPTZ7vxQiZ5jBWbmuN2M+hD7F9dsoO4yI7rltucF4lHpTR
	h+ff8Z8ugzka/D3HRyvKWCFR/Bj3kWe6KWXn5e7EOA1if96GSESPgjVmduOQKTWLSbXaQQ
	cMJNA2vhRC8uN+K3eyoJyhC9U4HdNas=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-kmgBGwmONxyOifJYvMr29g-1; Thu, 28 Mar 2024 11:08:56 -0400
X-MC-Unique: kmgBGwmONxyOifJYvMr29g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a467a6d4e3eso54320166b.3
        for <stable@vger.kernel.org>; Thu, 28 Mar 2024 08:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711638535; x=1712243335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mSa1UH5ZKNr2vj44ux4HGmes84oVNKmwJwueXqJQ4U=;
        b=oQwrZnvB/BOqy3OCBaZpSz70UlnvdGv13sVpBzrOofkx2Z1diVEbszTHLUZgwwRP8l
         G+Q/wRryvqE9l0iVmrEdbFtwuB2iJh2j951mIqlXLryhU+qXhevbgC5qtKb8WstOeSON
         1Bd2whsKpxIYEdEUiNMH6XkQ9arvf15Gp8EpJ/Ei3T4g9z6PudlDeR5G/nRvEL9XJhlW
         meK4L9jff3Fn0tZanJaf5PpON5WrFgBi9CmV/3hUNOEddAHDpLZgVtx8ObQJBOq5LvYO
         z+DLkBWgDdpPO/pEFpJiRXrazjKBJFVWosriCoLFoB+bxjbKt9OAjMNIgaZxuKfejm0f
         IMQg==
X-Forwarded-Encrypted: i=1; AJvYcCUJRnWFqk/Qt+EzwLNFkq2/CdCnsx6kjIEr0dlBS7nXD+wIM1RCe/GOCxpE/unnqGZXNtUKPkxAtzT7FmOh0n95VvTvq6yK
X-Gm-Message-State: AOJu0YwIw9cnom2RwmTDGye36s8fVxotQ9eKEmLEMFabSDliDR9ZGXV+
	G34/eQi7aWxqlDluuikg7Fp2GNKghog3w6a+aqn4LR01fjGbbQuzmFcIUdLFQNfMaef5532OuwD
	St7yJUyJw9azeZxbdjA6KVvsgd6hUkP6HZGOzQgHYSSQLM0SmljVd9A==
X-Received: by 2002:a17:906:4892:b0:a46:1e:d199 with SMTP id v18-20020a170906489200b00a46001ed199mr1956519ejq.39.1711638535052;
        Thu, 28 Mar 2024 08:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmoRnXa/JwIx9zBLHhHcHVuXLVxEg2Lqq6CX5yBHRgZ9vkobqCqz2BC79Zlbht5nZYPQLa4A==
X-Received: by 2002:a17:906:4892:b0:a46:1e:d199 with SMTP id v18-20020a170906489200b00a46001ed199mr1956503ejq.39.1711638534707;
        Thu, 28 Mar 2024 08:08:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bu13-20020a170906a14d00b00a46aba003eesm840957ejb.215.2024.03.28.08.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 08:08:54 -0700 (PDT)
Message-ID: <04bdb05b-6054-4c6e-bbb1-7dc6898352cb@redhat.com>
Date: Thu, 28 Mar 2024 16:08:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: ov2680: Clear the 'ret' variable on success
Content-Language: en-US, nl
To: Fabio Estevam <festevam@gmail.com>, sakari.ailus@linux.intel.com
Cc: rmfrfs@gmail.com, hansg@kernel.org, linux-media@vger.kernel.org,
 Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
References: <20240328145841.2514534-1-festevam@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240328145841.2514534-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/28/24 3:58 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint
> property verification") even when the correct 'link-frequencies'
> property is passed in the devicetree, the driver fails to probe:
> 
> ov2680 1-0036: probe with driver ov2680 failed with error -22
> 
> The reason is that the variable 'ret' may contain the -EINVAL value
> from a previous assignment:
> 
> ret = fwnode_property_read_u32(dev_fwnode(dev), "clock-frequency",
> 			       &rate);
> 
> Fix the problem by clearing 'ret' on the successful path.
> 
> Tested on imx7s-warp board with the following devicetree:
> 
> port {
> 	ov2680_to_mipi: endpoint {
> 		remote-endpoint = <&mipi_from_sensor>;
> 		clock-lanes = <0>;
> 		data-lanes = <1>;
> 		link-frequencies = /bits/ 64 <330000000>;
> 	};
> };
> 
> Cc: stable@vger.kernel.org
> Fixes: 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint property verification")
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
> Changes since v1:
> - Use Hans' suggestion to clear 'ret'.
> 
>  drivers/media/i2c/ov2680.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
> index 39d321e2b7f9..3e3b7c2b492c 100644
> --- a/drivers/media/i2c/ov2680.c
> +++ b/drivers/media/i2c/ov2680.c
> @@ -1135,6 +1135,7 @@ static int ov2680_parse_dt(struct ov2680_dev *sensor)
>  		goto out_free_bus_cfg;
>  	}
>  
> +	ret = 0;
>  out_free_bus_cfg:
>  	v4l2_fwnode_endpoint_free(&bus_cfg);
>  	return ret;


