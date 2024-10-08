Return-Path: <stable+bounces-81560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A47994558
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E114B26742
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D201C0DF3;
	Tue,  8 Oct 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ROf3bMgx"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E50193082;
	Tue,  8 Oct 2024 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383207; cv=none; b=QTcHf5AF9Ln7UviK8Dwx+qkxvP26JjVV5ge51jdKepZe4RrVNmRwFKq1cB1TT+EUgJ7h48cxdaXmYj3hMg8XmtVoFONlGXmKwwaDb1SVpLgHqSQJe1n70gvCnRYS4sudKcAYI0yidZxHE9b9NN+xYaLxwVylaINOIX8GgtiFUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383207; c=relaxed/simple;
	bh=e5I3Kqug+3tmd5xjuXN2W835x7u9rvw42f65vGULb4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEp5pDABo2nxY1F50qKKrWQ855ueGgmqSMzpa7AyjX+b2zUbJYRYVkx5NaIf/zJH6HeHHhz4f0ltJBVX3SuXXHyYPqJZ6+eejKSsWScWNoxAfCzQMRMuCvRd0zv4lThj3f2HdDrGLrpW7pazB0TyVZszRnGIeipd1an3rtC+6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ROf3bMgx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728383204;
	bh=e5I3Kqug+3tmd5xjuXN2W835x7u9rvw42f65vGULb4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ROf3bMgxZGjBvRU8HoNDrWwT5IpHBF1/Su7mYNjdxyyT9QTFLPdG2Boz0f/OrH7av
	 k5jI3s0U8SgDVIujSNnnxM2H4HpKQ2HwgjwrSA/8SL7aeY8aKVUwMscJcPTORR7xa9
	 ktdJlE0Qi2K+wZZx5zr8WMvZ4xrJLHqjM5RYX7KiP5aHkZ136xrjELtpUd/YVNORAl
	 LQDW8nuXhmyDsXdjxP3A+yNK370h3bX62gfq+kdspXRMlO9IiohK/Wkhkx+gUR2QTK
	 ffszIgk9OTGgFMYNFuRqPYb59iHTdGYzwDrA6Ou40FozODUJ2Ny6bt5n4wrYtntzPl
	 6IZJcKZDsmzJA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F16EA17E1131;
	Tue,  8 Oct 2024 12:26:43 +0200 (CEST)
Message-ID: <75fb08e1-2d47-4376-9ac0-c812c956bdab@collabora.com>
Date: Tue, 8 Oct 2024 12:26:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola-voltorb: Merge
 speaker codec nodes
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241008082200.4002798-1-wenst@chromium.org>
 <7caa85fa-7186-4f8f-8195-19325ebf06bd@collabora.com>
 <CAGXv+5FgPOh4kNdrG1uN-NOWEpC5rXvsr0egTsgOw+v_E3vdRg@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5FgPOh4kNdrG1uN-NOWEpC5rXvsr0egTsgOw+v_E3vdRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 08/10/24 12:14, Chen-Yu Tsai ha scritto:
> On Tue, Oct 8, 2024 at 4:51 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 08/10/24 10:21, Chen-Yu Tsai ha scritto:
>>> The Voltorb device uses a speaker codec different from the original
>>> Corsola device. When the Voltorb device tree was first added, the new
>>> codec was added as a separate node when it should have just replaced the
>>> existing one.
>>>
>>> Merge the two nodes. The only differences are the compatible string and
>>> the GPIO line property name. This keeps the device node path for the
>>> speaker codec the same across the MT8186 Chromebook line.
>>
>> Ok, I agree...
>>
>> But, at this point, can we rename `rt1019p` to `speaker_codec` instead?
>>
>> Imo, that makes a bit more sense as a phandle, as it reads generic and it's not
>> screaming "I'm RT1019P" on dts(i) files where it's actually not.
> 
> Works for me.
> 
>>>
>>> Fixes: 321ad586e607 ("arm64: dts: mediatek: Add MT8186 Voltorb Chromebooks")
>>   > Cc: <stable@vger.kernel.org>
>>
>> Well, that's not a fix - it's an improvement, so we can avoid this Fixes tag :-)
> 
> I'd like to see it backported though, so we minimize the different DTS files.
> Guess I'll add Cc stable instead? Not sure if that works without a Fixes tag.
> 

Well, try to send it to the stable mailing list as well...
I fully understand your concern but backporting is for fixes and *not* for
improvements, so I doubt that you'll get that backported.

It's Sasha's call then, anyway.

> ChenYu
> 
>> Cheers,
>> Angelo
>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>>    .../dts/mediatek/mt8186-corsola-voltorb.dtsi  | 19 ++++---------------
>>>    1 file changed, 4 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
>>> index 52ec58128d56..fbcd97069df9 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
>>> @@ -10,12 +10,6 @@
>>>
>>>    / {
>>>        chassis-type = "laptop";
>>> -
>>> -     max98360a: max98360a {
>>> -             compatible = "maxim,max98360a";
>>> -             sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
>>> -             #sound-dai-cells = <0>;
>>> -     };
>>>    };
>>>
>>>    &cpu6 {
>>> @@ -59,19 +53,14 @@ &cluster1_opp_15 {
>>>        opp-hz = /bits/ 64 <2200000000>;
>>>    };
>>>
>>> -&rt1019p{
>>> -     status = "disabled";
>>> +&rt1019p {
>>> +     compatible = "maxim,max98360a";
>>> +     sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
>>> +     /delete-property/ sdb-gpios;
>>>    };
>>>
>>>    &sound {
>>>        compatible = "mediatek,mt8186-mt6366-rt5682s-max98360-sound";
>>> -     status = "okay";
>>> -
>>> -     spk-hdmi-playback-dai-link {
>>> -             codec {
>>> -                     sound-dai = <&it6505dptx>, <&max98360a>;
>>> -             };
>>> -     };
>>>    };
>>>
>>>    &spmi {
>>


