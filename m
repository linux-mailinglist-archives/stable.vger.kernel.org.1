Return-Path: <stable+bounces-52560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B910C90B3F9
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7FB1C22F01
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C38E15EFBE;
	Mon, 17 Jun 2024 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgZTHipW"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686EA15EFB5
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635342; cv=none; b=ALBcKu0z7sDbN7pZpD/42LhjIOdH1SXfshQhBHkHx7mimt9uhqH/0DuCgILr/gnylEaWTeZ+mklyE409ZsjG7fqu2dQY82WZDZeDdJUQKtmU4ELv+ack5rZvPzuP9QO4M8H+jcUUww6L7gXh/RvsnVMGQJJwoovxCnvJcWvq8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635342; c=relaxed/simple;
	bh=JR4bM3IEVw9/uptU8LIQo4w5Uach0rp8uHcOdCmDgt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vwby05f1twPpQtIlJjvPUx7xws+aZ+pHIJ7tSuQPF5ccJ+kbwo1GMK514AHtqx8Zh9wWSJmB7bwfoGJwJWoPEYCjtyuewBPGB+UW96A9m/5zUke7WZIA0hGGJj00774//T0kIgzYObyli3P/PycqNPd0V9Yiy4IhJBDPuFKNmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RgZTHipW; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-375b2fe7003so17962185ab.1
        for <stable@vger.kernel.org>; Mon, 17 Jun 2024 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718635339; x=1719240139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEZjeteQXfzQdcWVQrn0yV9Qj7kNGp+WUXl9yT7pJIM=;
        b=RgZTHipWzDLWD0NcP+D0ZnzLsnhYll/JN2zMyMyLtj1iXCdDpMeuBRtLrjHZ+i3c9h
         2RmcYtmBljwlstWIfPJHqVzY/Y5mjO1bm7D6tjTZTTj+vBiBcBEqzVfktDrbTlMXABsU
         Wl+QwuZhI8LM34WKbXFb/1p6+BIRVo0ixTwMLRk+wqeaAQQxB2CiCM5tR/brJunfzRx6
         /UwYyuKdCGMt8NgnFgAPhyydg5f4HOcOuakmEEQC/z7AsBr6h2cU102nkOMSGjsmxv9q
         /OrdEj2avr8eBbP0q4EmQd/PC1a4P+3Dea7TJXPCe3ASQxifhD6K7Ogt1sluyC5kgD6P
         APzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635339; x=1719240139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEZjeteQXfzQdcWVQrn0yV9Qj7kNGp+WUXl9yT7pJIM=;
        b=KZR6SIvI1RirBp62bEwbEFNsWlHo8RQglmv7/bE96AfUPByRNQs8+w0oufpjVgXjFO
         mF/Qn8GrpdCdLAW7ZC1Zs4Pt4my4mRM2wevuH/5S3xGTFM1qzkjls/pV1MBkSHoWJFLq
         /twU9VPvlj/kcNqxxLcLDnnwUeFpWvgZQzZSuxo6BVqV0Lq2YT61muemo0ZYtodlWyzM
         J9uhwtq3+QjpohkNoo5l3yoAPm6s/fuT1sgZALMbYe+kPMyGeoPA4TaEHgZnJBWG/NqB
         kkcZpXs1D6JiLCGtYU7Xsr9g+Gorzjzp2EWTc3SAgpf0SWXBAKM6pwPmNmNZFKc4xziF
         /y0w==
X-Forwarded-Encrypted: i=1; AJvYcCUO8p982uGFQyYZbBRDBr+rntOnGyoHtfmYuvIgKl6MxJLQXpyvf6BsrfrMHtJXz8geAW2Hc5OinKFhRTZScy0NzH4HpFBH
X-Gm-Message-State: AOJu0YxprVPK2VnPM4zhxycdyhBCjb/usJkHxFbGOdlXdAZCZKO/anlh
	CZm3q+QXpKkhxdnv80ATALwZFriIsP83IEVq1Dg9Cn5oroHE7nmbuy8E0V/WBeo=
X-Google-Smtp-Source: AGHT+IEYXBLlZaTCF/KozlYWXmX+1dC92NpMDk5cKK1l7LyVT2phM7sLrhcf7MZdinEAwBHySA2uwA==
X-Received: by 2002:a05:6e02:152e:b0:374:8928:83a4 with SMTP id e9e14a558f8ab-375e0e30792mr118277925ab.14.1718635339363;
        Mon, 17 Jun 2024 07:42:19 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e681:7328:24ae:62a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fede16ad2fsm6720686a12.32.2024.06.17.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:42:18 -0700 (PDT)
Date: Mon, 17 Jun 2024 08:42:16 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Peng Fan <peng.fan@nxp.com>, Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: imx_rproc: Fix refcount mistake in
 imx_rproc_addr_init
Message-ID: <ZnBLSG/Yy1E4A+Og@p14s>
References: <20240612131714.12907-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612131714.12907-1-amishin@t-argos.ru>

On Wed, Jun 12, 2024 at 04:17:14PM +0300, Aleksandr Mishin wrote:
> In imx_rproc_addr_init() strcmp() is performed over the node after the
> of_node_put() is performed over it.
> Fix this error by moving of_node_put() calls.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 5e4c1243071d ("remoteproc: imx_rproc: support remote cores booted before Linux Kernel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/remoteproc/imx_rproc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 39eacd90af14..144c8e9a642e 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -734,25 +734,29 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  			continue;
>  		}
>  		err = of_address_to_resource(node, 0, &res);
> -		of_node_put(node);
>  		if (err) {
>  			dev_err(dev, "unable to resolve memory region\n");
> +			of_node_put(node);
>  			return err;
>  		}
>  
> -		if (b >= IMX_RPROC_MEM_MAX)
> +		if (b >= IMX_RPROC_MEM_MAX) {
> +			of_node_put(node);
>  			break;
> +		}
>  
>  		/* Not use resource version, because we might share region */
>  		priv->mem[b].cpu_addr = devm_ioremap_wc(&pdev->dev, res.start, resource_size(&res));
>  		if (!priv->mem[b].cpu_addr) {
>  			dev_err(dev, "failed to remap %pr\n", &res);
> +			of_node_put(node);
>  			return -ENOMEM;
>  		}
>  		priv->mem[b].sys_addr = res.start;
>  		priv->mem[b].size = resource_size(&res);
>  		if (!strcmp(node->name, "rsc-table"))
>  			priv->rsc_table = priv->mem[b].cpu_addr;
> +		of_node_put(node);
>  		b++;
>  	}
>  
> -- 
> 2.30.2
> 
> 

