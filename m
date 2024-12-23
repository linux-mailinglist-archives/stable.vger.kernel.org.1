Return-Path: <stable+bounces-105597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1265D9FAD82
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E6C161667
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A3219995A;
	Mon, 23 Dec 2024 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="owpGwXqO"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEFC1991BA;
	Mon, 23 Dec 2024 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952294; cv=none; b=JfGvAwOWXVbMkeW+uOomtbutkDVoj6GyYmfLlILRvDzL6ZTgb3ye5zVzb2TLDcRO0HAz1bc3QkInFScjLxvSUniy01Gx+xW+u124AQ6xtC8NNtnjpqPQFgNBuK5PGauJK9LNOLAkXXks1beeCyfWNkXvLWbV4/vN/p2BxriTHIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952294; c=relaxed/simple;
	bh=09Szq+5ED+uJC+jXFmk42U3WThXQRASetEvE4j3m3ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xo8QkZanG9WlRh2qV8f2MiSE0JakCU5xU+cAhoOPCNqhuHBCiuaOBkijc9MHdlSxx3LFiPqWJGinoJ4eOc8xlJTqTnxCmzo/ySDY5OwBy/F4VF2bBWYvhz42GzeRP67VkcQOClWX/X/xxqixhCqCP7T+MrHGVuICkfeXsHiNMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=owpGwXqO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734952290;
	bh=09Szq+5ED+uJC+jXFmk42U3WThXQRASetEvE4j3m3ag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=owpGwXqOVkNyohhBx6ON/khFurTZ0K+k1gp0sCEkTblE7f4R9OGRI88ETZAWKJKA4
	 rLPYj6Kc48ezBk8f66XBOIyKCWB03beLbfbk9VB/9ghMl6+GUgfADtyEXHAPsS3VPR
	 I1Pf+bhz3NdROPdOsKNoBaDDQAfQxgs0LX8iwyR0DeOLnrG6uTE+CKsSuXom84T2S1
	 s3/2CVkY+8immgVaviZ6/t+il8qAi+rBjedwMXWfD6PchuEzZSi5XP5OrNuZ90T3wg
	 WeLCcMXr9VaErC1bKGN3xTLMumDjs8g0LmnhxLI4tD7mQU+ZpfaH+pLhrBS/ueo3CO
	 ZgC43l1TydyzA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B67417E362F;
	Mon, 23 Dec 2024 12:11:30 +0100 (CET)
Message-ID: <481a6eec-c428-45cd-98a6-5a91f3ceb187@collabora.com>
Date: Mon, 23 Dec 2024 12:11:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: mtk-efuse: Enable GPU speed bin post-processing
 for MT8188
To: Chen-Yu Tsai <wenst@chromium.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, stable@vger.kernel.org
References: <20241223100648.2166754-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241223100648.2166754-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/12/24 11:06, Chen-Yu Tsai ha scritto:
> Like the MT8186, the MT8188 stores GPU speed binning data in its efuse.
> The data needs post-processing into a format that the OPP framework can
> use.
> 
> Add a compatible match for MT8188 efuse with post-processing enabled.
> 

Let's just change the MT8188 compatible list to

compatible = "mediatek,mt8188-efuse", "mediatek,mt8186-efuse";

instead :-)

Cheers,
Angelo

> Cc: <stable@vger.kernel.org>
> Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add support for MT8188")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> 
> I'm not exactly sure about pointing to the dt bindings commit for the
> fixes tag.
> ---
>   drivers/nvmem/mtk-efuse.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index af953e1d9230..e8409e1e7fac 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pdata = {
>   static const struct of_device_id mtk_efuse_of_match[] = {
>   	{ .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
>   	{ .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
> +	{ .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8186_efuse_pdata },
>   	{ .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
>   	{/* sentinel */},
>   };


