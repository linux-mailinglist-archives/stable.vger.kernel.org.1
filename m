Return-Path: <stable+bounces-114051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982DBA2A4B4
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC5A169033
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3324227B89;
	Thu,  6 Feb 2025 09:35:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809E226525;
	Thu,  6 Feb 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834510; cv=none; b=PIqJCB/WUI8/ImGan8Q9FAvZGAT/RC36BgctwTkJ+LyN3IL1/4PfVyOFVypw7YAt+x/SEdMGX3Mf8+F4eLZ+UPqmxSLkcT0S+DfvvSxXCZwaXzK89Rq949Nn2PilEfz6F7pzj6uEO0g23cKhWvQSr7BxZc/DiLuxwafWJRuPIc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834510; c=relaxed/simple;
	bh=SqQ8gnGSj8uW1Bp4Pzd61JpHuw3t5hDau+dUBaAn1eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMIfxHh0YXYUAFDYnumQX0iHMKBw05fzJVPq0TRivrchxwXDn/4Qh3k+DgB0a/S/eZzK1tVGc87oV2mDXaKAcx7NU++z14sRg2mZPEh+EmUYj7Lh0wYnxG4oMeLtNOVuEBrUnvRO+p4zfD8RHsBbqPi5+yuN8i4A0ozUjsCxdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E8F12FC;
	Thu,  6 Feb 2025 01:35:31 -0800 (PST)
Received: from [10.1.30.52] (e122027.cambridge.arm.com [10.1.30.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71C553F63F;
	Thu,  6 Feb 2025 01:35:05 -0800 (PST)
Message-ID: <de9aa254-dcfc-4a7d-b89d-79b41649a6b2@arm.com>
Date: Thu, 6 Feb 2025 09:35:03 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH netdev] net: stmmac: dwmac-rk: Provide FIFO sizes for
 DWMAC 1000
To: Chen-Yu Tsai <wens@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Chen-Yu Tsai <wens@csie.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org
References: <20250204161359.3335241-1-wens@kernel.org>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250204161359.3335241-1-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/02/2025 16:13, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The DWMAC 1000 DMA capabilities register does not provide actual
> FIFO sizes, nor does the driver really care. If they are not
> provided via some other means, the driver will work fine, only
> disallowing changing the MTU setting.
> 
> The recent commit 8865d22656b4 ("net: stmmac: Specify hardware
> capability value when FIFO size isn't specified") changed this by
> requiring the FIFO sizes to be provided, breaking devices that were
> working just fine.
> 
> Provide the FIFO sizes through the driver's platform data, to not
> only fix the breakage, but also enable MTU changes. The FIFO sizes
> are confirmed to be the same across RK3288, RK3328, RK3399 and PX30,
> based on their respective manuals. It is likely that Rockchip
> synthesized their DWMAC 1000 with the same parameters on all their
> chips that have it.
> 
> Fixes: eaf4fac47807 ("net: stmmac: Do not accept invalid MTU values")
> Fixes: 8865d22656b4 ("net: stmmac: Specify hardware capability value when FIFO size isn't specified")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I think it's better at this stage to apply the revert first. However
I've run this on my board (Firefly RK3288) and it works, so when rebased
onto the (reverted) revert:

Tested-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> ---
> The reason for stable inclusion is not to fix the device breakage
> (which only broke in v6.14-rc1), but to provide the values so that MTU
> changes can work in older kernels.
> 
> Since a fix for stmmac in general has already been sent [1] and a revert
> was also proposed [2], I'll refrain from sending mine.
> 
> [1] https://lore.kernel.org/all/20250203093419.25804-1-steven.price@arm.com/
> [2] https://lore.kernel.org/all/Z6Clkh44QgdNJu_O@shell.armlinux.org.uk/
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index a4dc89e23a68..71a4c4967467 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1966,8 +1966,11 @@ static int rk_gmac_probe(struct platform_device *pdev)
>  	/* If the stmmac is not already selected as gmac4,
>  	 * then make sure we fallback to gmac.
>  	 */
> -	if (!plat_dat->has_gmac4)
> +	if (!plat_dat->has_gmac4) {
>  		plat_dat->has_gmac = true;
> +		plat_dat->rx_fifo_size = 4096;
> +		plat_dat->tx_fifo_size = 2048;
> +	}
>  	plat_dat->fix_mac_speed = rk_fix_speed;
>  
>  	plat_dat->bsp_priv = rk_gmac_setup(pdev, plat_dat, data);


