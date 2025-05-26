Return-Path: <stable+bounces-146332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2023AC3C56
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 11:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33E17A5ACD
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 09:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919831E51EA;
	Mon, 26 May 2025 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AZPFdMco"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931919D88F;
	Mon, 26 May 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250335; cv=none; b=luW15YhtLzgRU//V3Dl7L1AxjDwbPllHH5g9s5nIazqo8UchfkO/+Hy59LPHqjFSdP8bP5+fRSazBOYUsiiwydodvFen7scCKESL+Ro2RTfRSqxSqcvT3mRftrCc8dxD0dicNmhuLLpozKkzxAKilRLMA+/jegE1RqNzf2XW83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250335; c=relaxed/simple;
	bh=vcMTXAzTiY0mStel4N+6Gk6K2+W/6O20TELFymJTcK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejswtrtoubml/nE8wEHl6YBQHLiQuCecNq5T8pwfUvfm7HwzcCy4zzknt8yAY4X+4YYRrBrjZ4akCT+xbeCQ/xKxqXNiQc35VmV98PriSGx8FuSfK0TIQV/chMW8EtV8Q1zpXB2agBWJtfnGj4WeCsPmHksWMTcNcwv0Ij0XxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AZPFdMco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F28AC4CEE7;
	Mon, 26 May 2025 09:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748250334;
	bh=vcMTXAzTiY0mStel4N+6Gk6K2+W/6O20TELFymJTcK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZPFdMcoc0LslowRmZ8t+cKbpMAmIM28iJfJAuIGtj2VpTephFMItg/PQ/PJrEuu3
	 9Ttg3JLaHaRSUfONoDrWXyXUUAyZxfyo8hmog0s3Z3uXhQfmAVXztaP7ERodkBAay0
	 xeFAUgXQnYjPYbAlQv8H/DQNlmFv96ZE6aU62EcI=
Date: Mon, 26 May 2025 11:03:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: ioana.ciornei@nxp.com, agraf@suse.de, German.Rivera@freescale.com,
	stuart.yoder@freescale.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: Fix an API misuse in fsl_mc_device_add()
Message-ID: <2025052622-nautical-suitably-486c@gregkh>
References: <20250526083622.3671123-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526083622.3671123-1-haoxiang_li2024@163.com>

On Mon, May 26, 2025 at 04:36:22PM +0800, Haoxiang Li wrote:
> In fsl_mc_device_add(), use put_device() to give up the
> device reference instead of kfree().
> 
> Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index a8be8cf246fb..dfd79ecf65b6 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -905,9 +905,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  	return 0;
>  
>  error_cleanup_dev:
> -	kfree(mc_dev->regions);
> -	kfree(mc_bus);
> -	kfree(mc_dev);
> +	put_device(&mc_dev->dev);
>  
>  	return error;
>  }

No, sorry, this is not corrrect at all.  Always test your patches before
submitting them.

greg k-h

