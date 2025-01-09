Return-Path: <stable+bounces-108089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F26BA07507
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B790F7A18ED
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D003216397;
	Thu,  9 Jan 2025 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VPcoFz71"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059E2010EF;
	Thu,  9 Jan 2025 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423204; cv=none; b=KVV3m+tXYxc7qwvQQ50zBJ3kcFfweTrjcda/UiKCa3uNSJbidNjgYU8jln5J4FezNa6uJBzOeR9gc5ep2wVLqgL7wTSQVCCvZto3aMder7c+1uhvRBg+yYAmqe5a/XRt/LNTImN02JU30DnlX7o9LwYe6iYyuy+Y1fJ5Hj4Rk44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423204; c=relaxed/simple;
	bh=UwfSbEV9PVFpGl36dL/HGoNMwjBUSL+w4r1T2gsX2JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmHZusza0R4xieZyR6fnwB3IzhejFSGjR8FUtGzgjnK6uZfgGUv0cTmzAqJJG0++xExIoO8qBvZ0TYcFza60eUEJ0DMLFqGLQSOaCSBuRSK8wFP3MTpbJb3RoN2J9XNvlJb005xUNvUeT6W4G3go14+0Ech/2si/pQxRMpUc/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VPcoFz71; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736423199;
	bh=UwfSbEV9PVFpGl36dL/HGoNMwjBUSL+w4r1T2gsX2JM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VPcoFz713J3M/Sq//rlGsKAq/1jJNmWCTIzVsN5AI7nQdRzyGvfKLZdZ3pAycp7Mh
	 1Djq22h4VEPGcaTdHjaVdfBdtb9TaFtlLgUiGd8wWaC+7PLW6sErA7VuvV9vw2n8tf
	 MY+oGcQLThR+piKlCmBTQEkAke3StLXRb+PUguF8Ph8sk1G1SGEp0fVDW/PoLgDa0w
	 V/UHkp8FxFDO45ZD6usWadAXOFdlTTLUs+QCRTMObFF9OugbQloCBU1E0SxBSHiDen
	 N1GGbdBiQFAAA87yqsMyWN/lqTs1aoQhOpFAy0ygnANDijD+7rEtATz/lM5nbBN49W
	 2RU1pHmDGg3+w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D7DD17E1571;
	Thu,  9 Jan 2025 12:46:39 +0100 (CET)
Message-ID: <11028242-afe4-474a-9d76-cd1bd9208987@collabora.com>
Date: Thu, 9 Jan 2025 12:46:38 +0100
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
 <eda10efe-a301-45d3-9bf6-088275db7af5@collabora.com>
 <CAGXv+5EdU-8__5uTpcX2JT0Lw=kXraVpnMLjgcJS1jrN_zwAww@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5EdU-8__5uTpcX2JT0Lw=kXraVpnMLjgcJS1jrN_zwAww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 08/01/25 07:36, Chen-Yu Tsai ha scritto:
> On Tue, Jan 7, 2025 at 9:12 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 23/12/24 17:15, Chen-Yu Tsai ha scritto:
>>> On Tue, Dec 24, 2024 at 12:08 AM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 23/12/24 16:57, Chen-Yu Tsai ha scritto:
>>>>> On Mon, Dec 23, 2024 at 7:43 PM AngeloGioacchino Del Regno
>>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>>
>>>>>> Il 23/12/24 12:24, Chen-Yu Tsai ha scritto:
>>>>>>> On Mon, Dec 23, 2024 at 7:11 PM AngeloGioacchino Del Regno
>>>>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>>>>
>>>>>>>> Il 23/12/24 11:06, Chen-Yu Tsai ha scritto:
>>>>>>>>> Like the MT8186, the MT8188 stores GPU speed binning data in its efuse.
>>>>>>>>> The data needs post-processing into a format that the OPP framework can
>>>>>>>>> use.
>>>>>>>>>
>>>>>>>>> Add a compatible match for MT8188 efuse with post-processing enabled.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Let's just change the MT8188 compatible list to
>>>>>>>>
>>>>>>>> compatible = "mediatek,mt8188-efuse", "mediatek,mt8186-efuse";
>>>>>>>
>>>>>>> That would be "mediatek,mt8188-efuse", "mediatek,mt8186-efuse", "mediatek,efuse"
>>>>>>> then?
>>>>>>>
>>>>>>
>>>>>> No, we're dropping the generic "mediatek,efuse".
>>>>>
>>>>> That means we also drop it for MT8186?
>>>>>
>>>>> Thinking about it more, I think it's stretching things a bit. The hardware
>>>>> is clearly backwards compatible, or we wouldn't even be reading values
>>>>> out correctly. The only difference now with MT8186 and MT8188 is that
>>>>> they have a speed-bin field with a value that we want passed to the OPP
>>>>> framework, and the interpretation of that value is not really part of
>>>>> the efuse's hardware. We chose to do the conversion in the efuse driver,
>>>>> but we could also have done it in the GPU driver.
>>>>>
>>>>> What I'm saying is that we should not need to change the compatible strings
>>>>> to make this work.
>>>>>
>>>>
>>>> No we don't forcefully have to drop it from MT8186, and doing so would be kind
>>>> of hard and actually producing unnecessary breakages with (very) old kernels.
>>>>
>>>> Just add a `deprecated: true` to the binding that wants `mediatek,efuse` and
>>>> start with MT8188, where 8188 is in enum and 8186 is const.
>>>>
>>>> We can do MT8188 because that'll still work even with old kernels (since MT8186
>>>> is there since before MT8188 was introduced), and it's something to enable a new
>>>> feature.
>>>> This means that there's not going to be any breakage with new DT and old kernel.
>>>>
>>>> I want the mediatek,efuse binding to be like the majority of the others across
>>>> the kernel, so, no generic compatible.
>>>
>>> In that case shouldn't the fallback be the oldest SoC in the list?
>>> Maybe MT8173, which is currently marked as deprecated, so we undeprecate it?
>>>
>>> Certainly not the MT8186.
>>>
>>
>> MT8173 doesn't have the post processing enabled.... if you can test that the code
>> actually works for MT8173 as well, giving meaningful results, then we can just use
>> the MT8173 compatible :-)
> 
> What I'm saying is (and hopefully I regenerated my thoughts correctly)
> that if we want to get rid of the generic compatible string, then we
> need a base fallback string. The MT8173 one would be the one.

I think I had misunderstood your statement... so:

For the previously supported ones (including MT8186), yes, I agree.

> 
> The MT8186 efuse at the hardware level AFAIK is no different to the
> MT8173 one. They simply store bits. How the bits are allocated is
> defined by the layout. How the bits are interpreted is also not
> a property of the hardware.
> 

I confirm, there's no difference.

> In the current design the need for post-processing does not depend on
> the SoC itself, but rather the node name being "gpu-speedbin". Even
> if we turned on post processing for all models, it wouldn't matter
> for the other SoCs.
> 

It wouldn't, but in the event that another SoC needs a different algorithm
for post-processing (hopefully not!!!) I would still like the node name to
actually be consistent between all of them, even if the algo is different.

The gpu-speedbin efuse would always be gpu-speedbin, regardless of any
post-processing differences.

> And the reason the conversion is in the nvmem driver (the provider)
> rather than panfrost (the consumer) has nothing to do with the
> hardware.

That's correct.

> IIRC you simply wanted to provide a generic implementation.

And yes, that's why the conversion is in the nvmem driver, of course.

> If the conversion were in the GPU driver, we wouldn't special case
> MT8186 here.

We would special case MediaTek SoCs in the GPU driver instead, but then
the GPU driver is supposed to deal with GPU stuff, not with SoC-specific
stuff whenever this is possible - I'm sure you agree with that, anyway.

> If the speedbin value were split into two or more
> cells, we probably would have stuck the conversion in the GPU
> driver.
> 

Not sure about that, I think there's still a way, but it's all hypotetical
for now, so let's not cross any bridges before coming to them :-)

> So, we could have "mediatek,mt8173-efuse" replace "mediatek,efuse"
> as the fallback compatible, and turn on post processing for it,
> and things would be the same as before, and also work for MT8188.
> How does that sound?
> 

If MT8173 has (PowerVR!) GPU speedbin efuses, and that requires the same
post-processing algorithm as MT8186 and the others, I agree with turning
on the post processing for MT8173 with the same algo as MT8186.

Otherwise, I disagree, as that would effectively add faulty code to MT8173.

> 
> Interestingly, the new "fixed layout" description actually allows
> for compatible strings in the NVMEM cells. That would allow matching
> against a cell's compatible string instead of its name.

If the post-processing stuff ever becomes complicated in the future (in
the sense that we start getting more and more post-processing and/or
more and more algo differences between SoCs), that'd probably save us
some headaches and would most probably be cleaner (at least to the eye)
than what we're doing right now.

Though, I'm not sure if it'd be a good idea to consider doing this right
now... or the other way around...

Cheers!
Angelo

> 
> 
> Thanks
> ChenYu
> 
>>>> Cheers,
>>>> Angelo
>>>>
>>>>>
>>>>> ChenYu
>>>>>
>>>>>> Cheers!
>>>>>>
>>>>>>> Fine by me. :D
>>>>>>>
>>>>>>> ChenYu
>>>>>>>
>>>>>>>> instead :-)
>>>>>>>>
>>>>>>>> Cheers,
>>>>>>>> Angelo
>>>>>>>>
>>>>>>>>> Cc: <stable@vger.kernel.org>
>>>>>>>>> Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add support for MT8188")
>>>>>>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> I'm not exactly sure about pointing to the dt bindings commit for the
>>>>>>>>> fixes tag.
>>>>>>>>> ---
>>>>>>>>>       drivers/nvmem/mtk-efuse.c | 1 +
>>>>>>>>>       1 file changed, 1 insertion(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
>>>>>>>>> index af953e1d9230..e8409e1e7fac 100644
>>>>>>>>> --- a/drivers/nvmem/mtk-efuse.c
>>>>>>>>> +++ b/drivers/nvmem/mtk-efuse.c
>>>>>>>>> @@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pdata = {
>>>>>>>>>       static const struct of_device_id mtk_efuse_of_match[] = {
>>>>>>>>>           { .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
>>>>>>>>>           { .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
>>>>>>>>> +     { .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8186_efuse_pdata },
>>>>>>>>>           { .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
>>>>>>>>>           {/* sentinel */},
>>>>>>>>>       };
>>>>>>>>
>>>>>>
>>
>>

