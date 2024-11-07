Return-Path: <stable+bounces-91753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8443B9BFD54
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 05:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79661C21314
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 04:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBC1156C6A;
	Thu,  7 Nov 2024 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="Ae+uZ+VP"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1A80603
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953112; cv=none; b=itb80fKHkNfacS2iJ5bU7xE01mXmCYsHF1ZX0IQ/+S4gtlZ92sedNJFRBxF0e/mQ8nThP3znzJl+JxQ4CQee5NTKDQcYFiQv1vlQM4dqUcq2cIZ/+22E09SUUE6Rf2qhhqnY2T9eKmD1G7yLy8m0IksXhNEyislGytJhVW41NLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953112; c=relaxed/simple;
	bh=6dnQkQqfHh1sOcickMpv1JDUan6dh4Wu1yIDrpH/GKU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BxETS8+4RLpjCbCpNQyb5de3bwy15KVAJOo0XYhNQzWcdFQD+2VVjup9Rk4rsZ9HTxiXXkEzZNEa1SCO9es+gyc1oHlIp7gpkZq4nPC7cD5cMnbmM5XeFZIJx+XV2qippZk6Q47bMFZJNmLH41gKA4BNtd93zJZcpCjBLi94W+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=Ae+uZ+VP; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id 8MC6t8wVrumtX8tyQtIMxs; Thu, 07 Nov 2024 04:18:22 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id 8tyNt4SrOjcdm8tyOtlmUV; Thu, 07 Nov 2024 04:18:20 +0000
X-Authority-Analysis: v=2.4 cv=DrWd+3/+ c=1 sm=1 tr=0 ts=672c3f8c
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=-pn6D5nKLtMA:10 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=vU9dKmh3AAAA:8 a=rQIMLdAWvKoWWgQMOJcA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1yLSujXjZ1vWyoNhn9Q/+EnZQtwboxPDVegByiRGcUI=; b=Ae+uZ+VP8cnIBy/ygVfCll2Z2h
	1Aqzf+23wPlMaOpCuvSlLqS9smUrQC9QISA+tkOzEKoLfUnU09AWYs3lIQRojNJOm3caBBIurcKzi
	iMeSsWbskf4cQIru86EXaXX1A7RaBE9mQGg26z6Buwe39AB33Sdaa+f6T0HuGIr15bWRqUYRItaQE
	la1LDTaIuFLQUzIT/mNxz+2EcJHnC9XV2H6Rak0PozS2rWtRvPPGWHDPu/JBbh9MA9E0j5E9Ky00A
	FqzPxSOgIxlWUAgcFNliQ9lCzxXHZBMnWusNWs3At6uI4iWNCwSKN3f7FV6pv1RGXMXtz1zVQ5llb
	pxjLd1yA==;
Received: from [122.165.245.213] (port=38142 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1t8tyI-0040BA-0J;
	Thu, 07 Nov 2024 09:48:14 +0530
Message-ID: <411e2025-6e2c-4755-bb44-d2388ed5058e@linumiz.com>
Date: Thu, 7 Nov 2024 09:48:11 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Yangtao Li <tiny.windzz@gmail.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 stable@vger.kernel.org
Subject: Re: [PATCH] mmc: sunxi-mmc: Fix A100 compatible description
To: Andre Przywara <andre.przywara@arm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
References: <20241107014240.24669-1-andre.przywara@arm.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20241107014240.24669-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1t8tyI-0040BA-0J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:38142
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH+GeKiQ/3wizSx+MMiFDUNevWnDm64nHaon8lyN6XTt1rPURj9UHTlnnqMMQM3BqUvapmvuRS9LXcNziwKjQo/6c6i0HsAgPTvk9p/6M6MojG1ZMCb1
 rWXS+/F1iHvdreeN5v0tzdNU9ZezoquJ2oSuNWbMDfpNzgR3HeR40rIfdghAaru0yflKhVcNTQ8Vl7jPrRBODJoqYmbAPWLkzw0=

On 11/7/24 7:12 AM, Andre Przywara wrote:
> It turns out that the Allwinner A100/A133 SoC only supports 8K DMA
> blocks (13 bits wide), for both the SD/SDIO and eMMC instances.
> And while this alone would make a trivial fix, the H616 falls back to
> the A100 compatible string, so we have to now match the H616 compatible
> string explicitly against the description advertising 64K DMA blocks.
> 
> As the A100 is now compatible with the D1 description, let the A100
> compatible string point to that block instead, and introduce an explicit
> match against the H616 string, pointing to the old description.
> Also remove the redundant setting of clk_delays to NULL on the way.
> 
> Fixes: 3536b82e5853 ("mmc: sunxi: add support for A100 mmc controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Tested working with SD card in mmc0.

Tested-by: Parthiban Nallathambi <parthiban@linumiz.com>

Thanks,
Parthiban

> ---
>  drivers/mmc/host/sunxi-mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index d3bd0ac99ec46..e0ab5fd635e6c 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1191,10 +1191,9 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
>  	.needs_new_timings = true,
>  };
>  
> -static const struct sunxi_mmc_cfg sun50i_a100_cfg = {
> +static const struct sunxi_mmc_cfg sun50i_h616_cfg = {
>  	.idma_des_size_bits = 16,
>  	.idma_des_shift = 2,
> -	.clk_delays = NULL,
>  	.can_calibrate = true,
>  	.mask_data0 = true,
>  	.needs_new_timings = true,
> @@ -1217,8 +1216,9 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>  	{ .compatible = "allwinner,sun20i-d1-mmc", .data = &sun20i_d1_cfg },
>  	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
>  	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
> -	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
> +	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun20i_d1_cfg },
>  	{ .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
> +	{ .compatible = "allwinner,sun50i-h616-mmc", .data = &sun50i_h616_cfg },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);


