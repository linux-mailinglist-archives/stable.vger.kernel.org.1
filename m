Return-Path: <stable+bounces-105600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD66B9FADD5
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E93C1883868
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BDB19E971;
	Mon, 23 Dec 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P+uCfPwn"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA891946BB;
	Mon, 23 Dec 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734954206; cv=none; b=q04L1Onjb3uVr4RHx9OV9KLtXzYd+j4FHXYfWqRzcezSMvYarODpWub8W1HyuE16vRuvongm67ecrN2rxdCNT+Ntb6MW4BYSsU1glYmTmLwf+5fuwoD8eqIcdYRglRkdo45wMOoP2wN5z9qf4ek6H2oK1KqjZBsL7YEW3IpcNxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734954206; c=relaxed/simple;
	bh=M3WuYSWs0zHI98S5beONgrZ1qO8VjPrSO1Yc8PMbt4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWtbSkcuqk8oeBDBYPm0v0dQWLiVFiKdOYAPlWo4lCmMaHU28CuRHv0OqBIsl6Km1Qtpmiet2b8y1wLnRZrg4BTK3+C6L2/L/90gtFE+6liNB8BTpYtapUZEzNbIVXrdu/232hih3/FlWvEkXJXJCjSIsu0lP/+3UxnUDvnTTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P+uCfPwn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734954202;
	bh=M3WuYSWs0zHI98S5beONgrZ1qO8VjPrSO1Yc8PMbt4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P+uCfPwn5Wi/Rmt6SUZuwur04l5evK1m1dOFxgBRY+q/WF3qe+oqM3VxuxFmLj6hU
	 XvPcKTkW55V2tUGrAV+4+SlrHQGbu8lUNRPMI/DHWHzMBb+wSpN8oKUg8d0hFK51jl
	 BbnnHkVRT6xH7wMDquv2g4bctZTt02GpiELuYAXGiI7Nd9dDUI2chKu72qGrWUoZhq
	 aHbP/UQDDGMci5RPTbpdHqWi87DK/qCWeTXGs8bjKmMYudp8EBZ685kWEHyAUrT7mI
	 QA8UiAOgAhrAK+4TR+bBRGJ8fajn6TE29aoB76glkRkID6GQnIIkDQ3cZBjP4JEAyW
	 xJhN5H8oSpk5Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 452B317E3684;
	Mon, 23 Dec 2024 12:43:22 +0100 (CET)
Message-ID: <bbc6aa2a-fe48-4e06-b070-fd66dbd00e15@collabora.com>
Date: Mon, 23 Dec 2024 12:43:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: mtk-efuse: Enable GPU speed bin post-processing
 for MT8188
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
References: <20241223100648.2166754-1-wenst@chromium.org>
 <481a6eec-c428-45cd-98a6-5a91f3ceb187@collabora.com>
 <CAGXv+5Fj5s9FUyaxmEkGimxjEcS6OEfm4_5Zso+YocSi+Vt4pg@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5Fj5s9FUyaxmEkGimxjEcS6OEfm4_5Zso+YocSi+Vt4pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/12/24 12:24, Chen-Yu Tsai ha scritto:
> On Mon, Dec 23, 2024 at 7:11 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 23/12/24 11:06, Chen-Yu Tsai ha scritto:
>>> Like the MT8186, the MT8188 stores GPU speed binning data in its efuse.
>>> The data needs post-processing into a format that the OPP framework can
>>> use.
>>>
>>> Add a compatible match for MT8188 efuse with post-processing enabled.
>>>
>>
>> Let's just change the MT8188 compatible list to
>>
>> compatible = "mediatek,mt8188-efuse", "mediatek,mt8186-efuse";
> 
> That would be "mediatek,mt8188-efuse", "mediatek,mt8186-efuse", "mediatek,efuse"
> then?
> 

No, we're dropping the generic "mediatek,efuse".

Cheers!

> Fine by me. :D
> 
> ChenYu
> 
>> instead :-)
>>
>> Cheers,
>> Angelo
>>
>>> Cc: <stable@vger.kernel.org>
>>> Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add support for MT8188")
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>>
>>> I'm not exactly sure about pointing to the dt bindings commit for the
>>> fixes tag.
>>> ---
>>>    drivers/nvmem/mtk-efuse.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
>>> index af953e1d9230..e8409e1e7fac 100644
>>> --- a/drivers/nvmem/mtk-efuse.c
>>> +++ b/drivers/nvmem/mtk-efuse.c
>>> @@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pdata = {
>>>    static const struct of_device_id mtk_efuse_of_match[] = {
>>>        { .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
>>>        { .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
>>> +     { .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8186_efuse_pdata },
>>>        { .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
>>>        {/* sentinel */},
>>>    };
>>



