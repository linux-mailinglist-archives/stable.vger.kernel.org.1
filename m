Return-Path: <stable+bounces-12720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1A836FA9
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415731C28D12
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755953EA97;
	Mon, 22 Jan 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7R7SCGZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A5495DD
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945772; cv=none; b=Zeq2lqZWlDHxHNtl2ksK4afpSW9UY0rO8n59PznR9siXrspzqET4yDRk/4YqcQmbQ6hHL/XcZOYUeWX/sOSYU5h/CgORFHYD9G3YPJGTltDxSo53PpSfMCg7Y2LwAs6gSuyfTNpykLBWN4EiT6Ho5NUbKZxFmu/bGvrfIJCySF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945772; c=relaxed/simple;
	bh=CW8wPrXgosoI2Sl7OIZKWB5pJe7By5QhC97R3dQ+BKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du57pgxcP6IEyIynbIrlo2BDFaBmJSLG0Q1+9NkF/h2TkP4X31U7QblWfYtDijDrU70nuOtjkHvG6Fp4BjqzXhkrqZAdQxtSt6fw3MDXiIdFd9iWMWiWEn7sg0Fb32sRajEvHh1OaW8J0kZv/LejFi6bqwJK/r1Bep3YrYrNByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w7R7SCGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89917C433F1;
	Mon, 22 Jan 2024 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705945770;
	bh=CW8wPrXgosoI2Sl7OIZKWB5pJe7By5QhC97R3dQ+BKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w7R7SCGZBHEbfGJqwn6c6Ec9Sv4LeqRSCR6LivO7riDxfdal2WRoDeK4zsP19Eh1a
	 kAA51SprWpFErWae2m4e9GXKYJpD0VGIhXLvk6NL5qOKAYRevPoxCBtBCAav9Ueixf
	 D6O9agw2iAtYNrS3bPMwBJkdFBi26F/25vDkHLpE=
Date: Mon, 22 Jan 2024 09:49:29 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y 1/1] net: ethernet: mtk_eth_soc: remove duplicate
 if statements
Message-ID: <2024012205-neon-tabasco-7628@gregkh>
References: <20240122130219.220316-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122130219.220316-1-amadeus@jmu.edu.cn>

On Mon, Jan 22, 2024 at 09:02:19PM +0800, Chukun Pan wrote:
> It seems that there was something wrong with backport,
> causing `if (err)` to appear twice in the same place.
> 
> Fixes: da86a63479e ("net: ethernet: mtk_eth_soc: fix error handling in mtk_open()")
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index aa9e616cc1d5..011210e6842d 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -2302,7 +2302,6 @@ static int mtk_open(struct net_device *dev)
>  	if (!refcount_read(&eth->dma_refcnt)) {
>  		int err = mtk_start_dma(eth);
>  
> -		if (err)
>  		if (err) {
>  			phylink_disconnect_phy(mac->phylink);
>  			return err;
> -- 
> 2.25.1
> 
> 

Now queued up, thanks.  Odd that no one actually caught this, I guess
the driver is NOT being built by any type of test configurations?  Why
is that?

thanks,

greg k-h

