Return-Path: <stable+bounces-107853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C9FA04089
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 14:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8551A1885C99
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3ED1EBA04;
	Tue,  7 Jan 2025 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Hq/irzVo"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839811EE02F;
	Tue,  7 Jan 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255545; cv=none; b=h3NrW/kKjzR3nxNLC/4t6OXsUg9vmv1oOeeMhz+jybvEK3H3GumbTQkkCvjGvQjw6a+v0aqcyK70ryvBpiLzIeKuSvfkvtebYMPbAc8aNaFyT38fZVhPoiI7DHnWp9NL2I/wuExXxH+EGEK+BenUxWuP/gIylL/pVxbM5U5WbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255545; c=relaxed/simple;
	bh=/yaQvBxN92WBph6vXqky+w7V6dYWSvkNwdgX/ZOAW9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lij6ftkiqkG+aXSpA2q/S+7SE+CGvYNW4L6qE/WTJoNQZlam86pCmwWOU+JuASyAWn53vNGbH3Qls//02HgBjg2Ta9l7lzcUbW59gaaL1vRBh+vULErQy8G5ZKEJeC6F9K6S4tJlIbl4EVazZLWq4vTjfvZQ/WmwcohYstaHa8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Hq/irzVo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736255537;
	bh=/yaQvBxN92WBph6vXqky+w7V6dYWSvkNwdgX/ZOAW9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hq/irzVoEOQUNndEXpvhYpZJZ+dRSDryELIilqoMSAyskCJ+Z+RZvXikChS/Wc5t1
	 te++ypatMZc9BExcx6+IIb6w7ZYmhBUfhJal+FI0eBi3asIj4yYi1C/MeGQBWtRUh8
	 lgERLUBkqex86n/ywFni0doKfpGvGjXKy0BbxNglOU+XCuvu5+oREGMsKoSs8X+Hbt
	 ZQ0fFTRLKofTI67/KUTiSXw1RpI1egfMqLm9emXD1qn/hJqi0xuvilCLW3PPzUx0l1
	 /FWNBzkWxYQ8DBA2CCxPeNDSNglC7kigB9zrMQ9Bpl/hCI8ickvr1vcPyzwmpzTX/L
	 A5K2uNGV74vwA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 28EA517E1574;
	Tue,  7 Jan 2025 14:12:17 +0100 (CET)
Message-ID: <eda10efe-a301-45d3-9bf6-088275db7af5@collabora.com>
Date: Tue, 7 Jan 2025 14:12:16 +0100
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
 <efb88dd0-3b66-49fe-b279-e66c4574cf9d@collabora.com>
 <CAGXv+5HWcYrCzWJD4e=WP1WVNfqG5Y2_z+_oetWZq2ZKjXP75g@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5HWcYrCzWJD4e=WP1WVNfqG5Y2_z+_oetWZq2ZKjXP75g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/12/24 17:15, Chen-Yu Tsai ha scritto:
> On Tue, Dec 24, 2024 at 12:08 AM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 23/12/24 16:57, Chen-Yu Tsai ha scritto:
>>> On Mon, Dec 23, 2024 at 7:43 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 23/12/24 12:24, Chen-Yu Tsai ha scritto:
>>>>> On Mon, Dec 23, 2024 at 7:11 PM AngeloGioacchino Del Regno
>>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>>
>>>>>> Il 23/12/24 11:06, Chen-Yu Tsai ha scritto:
>>>>>>> Like the MT8186, the MT8188 stores GPU speed binning data in its efuse.
>>>>>>> The data needs post-processing into a format that the OPP framework can
>>>>>>> use.
>>>>>>>
>>>>>>> Add a compatible match for MT8188 efuse with post-processing enabled.
>>>>>>>
>>>>>>
>>>>>> Let's just change the MT8188 compatible list to
>>>>>>
>>>>>> compatible = "mediatek,mt8188-efuse", "mediatek,mt8186-efuse";
>>>>>
>>>>> That would be "mediatek,mt8188-efuse", "mediatek,mt8186-efuse", "mediatek,efuse"
>>>>> then?
>>>>>
>>>>
>>>> No, we're dropping the generic "mediatek,efuse".
>>>
>>> That means we also drop it for MT8186?
>>>
>>> Thinking about it more, I think it's stretching things a bit. The hardware
>>> is clearly backwards compatible, or we wouldn't even be reading values
>>> out correctly. The only difference now with MT8186 and MT8188 is that
>>> they have a speed-bin field with a value that we want passed to the OPP
>>> framework, and the interpretation of that value is not really part of
>>> the efuse's hardware. We chose to do the conversion in the efuse driver,
>>> but we could also have done it in the GPU driver.
>>>
>>> What I'm saying is that we should not need to change the compatible strings
>>> to make this work.
>>>
>>
>> No we don't forcefully have to drop it from MT8186, and doing so would be kind
>> of hard and actually producing unnecessary breakages with (very) old kernels.
>>
>> Just add a `deprecated: true` to the binding that wants `mediatek,efuse` and
>> start with MT8188, where 8188 is in enum and 8186 is const.
>>
>> We can do MT8188 because that'll still work even with old kernels (since MT8186
>> is there since before MT8188 was introduced), and it's something to enable a new
>> feature.
>> This means that there's not going to be any breakage with new DT and old kernel.
>>
>> I want the mediatek,efuse binding to be like the majority of the others across
>> the kernel, so, no generic compatible.
> 
> In that case shouldn't the fallback be the oldest SoC in the list?
> Maybe MT8173, which is currently marked as deprecated, so we undeprecate it?
> 
> Certainly not the MT8186.
> 

MT8173 doesn't have the post processing enabled.... if you can test that the code
actually works for MT8173 as well, giving meaningful results, then we can just use
the MT8173 compatible :-)


>> Cheers,
>> Angelo
>>
>>>
>>> ChenYu
>>>
>>>> Cheers!
>>>>
>>>>> Fine by me. :D
>>>>>
>>>>> ChenYu
>>>>>
>>>>>> instead :-)
>>>>>>
>>>>>> Cheers,
>>>>>> Angelo
>>>>>>
>>>>>>> Cc: <stable@vger.kernel.org>
>>>>>>> Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add support for MT8188")
>>>>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>>>>> ---
>>>>>>>
>>>>>>> I'm not exactly sure about pointing to the dt bindings commit for the
>>>>>>> fixes tag.
>>>>>>> ---
>>>>>>>      drivers/nvmem/mtk-efuse.c | 1 +
>>>>>>>      1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
>>>>>>> index af953e1d9230..e8409e1e7fac 100644
>>>>>>> --- a/drivers/nvmem/mtk-efuse.c
>>>>>>> +++ b/drivers/nvmem/mtk-efuse.c
>>>>>>> @@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pdata = {
>>>>>>>      static const struct of_device_id mtk_efuse_of_match[] = {
>>>>>>>          { .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
>>>>>>>          { .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
>>>>>>> +     { .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8186_efuse_pdata },
>>>>>>>          { .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
>>>>>>>          {/* sentinel */},
>>>>>>>      };
>>>>>>
>>>>



