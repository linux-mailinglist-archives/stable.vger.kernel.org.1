Return-Path: <stable+bounces-105787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0952A9FB1AA
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519AB1884946
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD291B21B5;
	Mon, 23 Dec 2024 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c3J5VlAA"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F519E98B;
	Mon, 23 Dec 2024 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970136; cv=none; b=YqZyN8Td/MhoTqE7qLw7LHK8H/vqGzuA5UerbefVwGnUCjxsLhRN65UbsooXeo8hBaBoinAnjle30jfSEBrzQ7HjMpOYGNAKDyMT9HK8sLLmBqytWyJ8ZyNBY8cr+taTNnN4VtHEkLRkcnwMN6oeP60L8Ezou0N7CmroZJozo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970136; c=relaxed/simple;
	bh=FlS1NQ3sR/hUwwr2iqlUaS8K3ilVnp4Z1h3bBLmwQek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ichs6WopvC/nZcI5n6blwBhEbGOjXEm2rOspKiGbpBWwoSmpufcO2lts8m1m3MyBdzzlReldO7qE1TiAgZzQqF6/bSK8dyhnoRJsrMazr48lVCQ7U71G2NVQY/+O+BRafT7FCc59xsGG/qqCerCpP4FATRur/yeaLh61IOaH/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c3J5VlAA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734970132;
	bh=FlS1NQ3sR/hUwwr2iqlUaS8K3ilVnp4Z1h3bBLmwQek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c3J5VlAA34O63VZuBbBo13CnOwUyE04M0s8HxRcHmSaZwaGUDOLRZKW5CBVLMH9w2
	 ir1s9dYWUjRdHlNAsygmWviPcJU+QcTal8rIRwK3ziR/uFhsE3zdRnwpGvYbC7JeaU
	 6ViRSXM3DatP1nqJc8fWVq3j21ikCWLE29M/LLHi7K5J5QRvhaw/5FD6bi6DAwEMK6
	 98F8YHK49yXUhSuvfWyQn8wIYiY7A6fWidU6kTEBe/IjtzFYsAIdqpIDlqSVnYPV4B
	 foB8opbkSFzEYpKjawx8RviWs6xA+klp/djtjdD9hc64O5VHzYLGjSM1w5XOVHIIxo
	 v5XsUdRhevx6A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D4C7717E0E95;
	Mon, 23 Dec 2024 17:08:51 +0100 (CET)
Message-ID: <efb88dd0-3b66-49fe-b279-e66c4574cf9d@collabora.com>
Date: Mon, 23 Dec 2024 17:08:51 +0100
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
 <bbc6aa2a-fe48-4e06-b070-fd66dbd00e15@collabora.com>
 <CAGXv+5FoOM=ZUCWigdCaPbc4FCBtLVX2xnUJnVnVsBH=7yoZ=Q@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5FoOM=ZUCWigdCaPbc4FCBtLVX2xnUJnVnVsBH=7yoZ=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/12/24 16:57, Chen-Yu Tsai ha scritto:
> On Mon, Dec 23, 2024 at 7:43 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 23/12/24 12:24, Chen-Yu Tsai ha scritto:
>>> On Mon, Dec 23, 2024 at 7:11 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 23/12/24 11:06, Chen-Yu Tsai ha scritto:
>>>>> Like the MT8186, the MT8188 stores GPU speed binning data in its efuse.
>>>>> The data needs post-processing into a format that the OPP framework can
>>>>> use.
>>>>>
>>>>> Add a compatible match for MT8188 efuse with post-processing enabled.
>>>>>
>>>>
>>>> Let's just change the MT8188 compatible list to
>>>>
>>>> compatible = "mediatek,mt8188-efuse", "mediatek,mt8186-efuse";
>>>
>>> That would be "mediatek,mt8188-efuse", "mediatek,mt8186-efuse", "mediatek,efuse"
>>> then?
>>>
>>
>> No, we're dropping the generic "mediatek,efuse".
> 
> That means we also drop it for MT8186?
> 
> Thinking about it more, I think it's stretching things a bit. The hardware
> is clearly backwards compatible, or we wouldn't even be reading values
> out correctly. The only difference now with MT8186 and MT8188 is that
> they have a speed-bin field with a value that we want passed to the OPP
> framework, and the interpretation of that value is not really part of
> the efuse's hardware. We chose to do the conversion in the efuse driver,
> but we could also have done it in the GPU driver.
> 
> What I'm saying is that we should not need to change the compatible strings
> to make this work.
> 

No we don't forcefully have to drop it from MT8186, and doing so would be kind
of hard and actually producing unnecessary breakages with (very) old kernels.

Just add a `deprecated: true` to the binding that wants `mediatek,efuse` and
start with MT8188, where 8188 is in enum and 8186 is const.

We can do MT8188 because that'll still work even with old kernels (since MT8186
is there since before MT8188 was introduced), and it's something to enable a new
feature.
This means that there's not going to be any breakage with new DT and old kernel.

I want the mediatek,efuse binding to be like the majority of the others across
the kernel, so, no generic compatible.

Cheers,
Angelo

> 
> ChenYu
> 
>> Cheers!
>>
>>> Fine by me. :D
>>>
>>> ChenYu
>>>
>>>> instead :-)
>>>>
>>>> Cheers,
>>>> Angelo
>>>>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add support for MT8188")
>>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>>> ---
>>>>>
>>>>> I'm not exactly sure about pointing to the dt bindings commit for the
>>>>> fixes tag.
>>>>> ---
>>>>>     drivers/nvmem/mtk-efuse.c | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
>>>>> index af953e1d9230..e8409e1e7fac 100644
>>>>> --- a/drivers/nvmem/mtk-efuse.c
>>>>> +++ b/drivers/nvmem/mtk-efuse.c
>>>>> @@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pdata = {
>>>>>     static const struct of_device_id mtk_efuse_of_match[] = {
>>>>>         { .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
>>>>>         { .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
>>>>> +     { .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8186_efuse_pdata },
>>>>>         { .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
>>>>>         {/* sentinel */},
>>>>>     };
>>>>
>>

