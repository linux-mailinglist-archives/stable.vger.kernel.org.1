Return-Path: <stable+bounces-125877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2610BA6D7DD
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D71D167B0C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA00325D52A;
	Mon, 24 Mar 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FobUkMLH"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038E8494;
	Mon, 24 Mar 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810034; cv=none; b=g4ceRSxEvEfW6CqdmlD5WFH+s97Ni23Q0Gszc0U/5ssSpI3I4aKPZs+sZFRnzYf8gWQXY7HFXVHznoEgxChwhD7L38kD0AFmsTkclHHRQCCvnuKmn9EYmEOKiglbneZ8fb3z/JX4RXwbX82WJsz0ewBKBl/OY4tX/mVbSCZG6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810034; c=relaxed/simple;
	bh=qgqPMtRSr40Ccfot6UgbHPRueY6p7D9B661XBz7lvAM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sYRfbg7/qbirok1pJ1MT3kCaF6Et49b8bY2tCVPXUoT/1kO8A/q7TAYFUFzlzX3er/hbBgqpycAmgHECZt03ZhUZHty29s8dsUEsNuz8YonYZRK7/ZyR5xbp1J0YClCBGWwipBbDkFQwwmXdAC/vnH2jPwfKAr5hKsqc0UWSG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FobUkMLH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1742810030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XERG4fHTRlBSKZ7O9h54QbkOrIztH+Lz87Rz4mphs4o=;
	b=FobUkMLHzOSyOc4vvxt3chAceAe1ueFbrWsmTvLcLgLFx6DMMUAhCGlPBGdfebE2Xstk0x
	cJ8CDVdI3836LwlxSq8VN6AGAVGCu78x/jzI+aDgpAniinYsuelmTsdcbwAZ8qB+0MXaa3
	YUn+eTXy1rPLPvLp35oVNOb0t+jZUFbJjwqwAyp4J/VfrTnKeKwwXTl5sBJTfUgWH84iBq
	nZ9Nz5aFtN1PH2IJo6IwVmCLx9bAfntiZ4AH+eB17tyZYQc6ZQ2KUFOqtoXKILr63YX+5+
	04yl2AjaiVUyJAhsp32aKUocxWx4ZpCiMRhXlGa7dNMh5xiJSUTWM0ekHBnCXQ==
Date: Mon, 24 Mar 2025 10:53:49 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org, Alexey Charkov
 <alchark@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Remove overdrive-mode OPPs from
 RK3588J SoC dtsi
In-Reply-To: <2ece5cca-50ea-4ec9-927e-e757c9c10c18@cherry.de>
References: <f929da061de35925ea591c969f985430e23c4a7e.1742526811.git.dsimic@manjaro.org>
 <71b7c81b-6a4e-442b-a661-04d63639962a@cherry.de>
 <960c038ad9f7b83fe14d0ded388b42f7@manjaro.org>
 <2ece5cca-50ea-4ec9-927e-e757c9c10c18@cherry.de>
Message-ID: <4d25c9af4380598b35a0d55e7c77ac3d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Quentin,

On 2025-03-24 10:23, Quentin Schulz wrote:
> On 3/23/25 11:19 AM, Dragan Simic wrote:
>> On 2025-03-21 10:53, Quentin Schulz wrote:
>>> On 3/21/25 4:28 AM, Dragan Simic wrote:
>>>> The differences in the vendor-approved CPU and GPU OPPs for the 
>>>> standard
>>>> Rockchip RK3588 variant [1] and the industrial Rockchip RK3588J 
>>>> variant [2]
>>>> come from the latter, presumably, supporting an extended temperature 
>>>> range
>>>> that's usually associated with industrial applications, despite the 
>>>> two SoC
>>>> variant datasheets specifying the same upper limit for the allowed 
>>>> ambient
>>>> temperature for both variants.  However, the lower temperature limit 
>>>> is
>>> 
>>> RK3588 is rated for 0-80°C, RK3588J for -40-85°C, c.f. Recommended
>>> Operating Conditions, Table 3-2, Ambient Operating Temperature.
>> 
>> Indeed, which is why I specifically wrote "specifying the same upper
>> limit", because having a lower negative temperature limit could hardly
>> put the RK3588J in danger of overheating or running hotter. :)
> 
> """
> despite the two SoC variant datasheets specifying the same upper limit
> for the allowed temperature for both variants
> """
> 
> is incorrect. The whole range is different, yes it's only a 5°C
> difference for the upper limit, but they still are different.

I just commented on this separately, with a couple of datasheet
screenshots, before I saw your latest response.  Please, have
a look at that message.

>>>> specified much lower for the RK3588J variant. [1][2]
>>>> 
>>>> To be on the safe side and to ensure maximum longevity of the 
>>>> RK3588J SoCs,
>>>> only the CPU and GPU OPPs that are declared by the vendor to be 
>>>> always safe
>>>> for this SoC variant may be provided.  As explained by the vendor 
>>>> [3] and
>>>> according to its datasheet, [2] the RK3588J variant can actually run 
>>>> safely
>>>> at higher CPU and GPU OPPs as well, but only when not enjoying the 
>>>> assumed
>>>> extended temperature range that the RK3588J, as an SoC variant 
>>>> targeted
>>> 
>>> "only when not enjoying the assumed extended temperature range" is
>>> extrapolated by me/us and not confirmed by Rockchip themselves. I've
>>> asked for a statement on what "industrial environment" they specify 
>>> in
>>> the Normal Mode explanation means since it's the only time they use
>>> the term. I've yet to receive an answer. The only thing Rockchip in
>>> their datasheet is that the overdrive mode will shorten lifetime when
>>> used for a long time, especially in high temperature conditions. It's
>>> not clear whether we can use the overdrive mode even within the 
>>> RK3588
>>> typical range of operation.
>> 
>> True.  I'll see to rephrase the patch description a bit in the v2,
>> to avoid this kind of speculation.  I mean, perhaps the speculation
>> is right, but it hasn't been confirmed officially by Rockchip.
> 
> Speculation is fine, but it should be worded as such.

Agreed, because that's our understanding so far, but it needs
to be explained a bit better.

>>>> The provided RK3588J CPU OPPs follow the slightly debatable "provide 
>>>> only
>>>> the highest-frequency OPP from the same-voltage group" approach 
>>>> that's been
>>> 
>>> Interesting that we went for a different strategy for the GPU OPPs :)
>> 
>> Good point, and I'm fully aware of that. :)  Actually, I'm rather
>> sure that omitting the additional CPU OPPs does no good to us, but
>> I didn't want to argue about that when they were dropped originally,
>> before I can have some hard numbers to prove it in a repeatable way.
> 
> I assume we'll have some patch in the future with those added and
> those hard numbers you're talking about, so looking forward to seeing
> it on the ML :)

Indeed, that's the plan, and there should be even more patches,
which should remove the slightly annoying "xyz OPP is inefficient"
warnings emitted by the IPA governor. :)

>>>> Helped-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> 
>>> Reported-by/Suggested-by?
>>> 
>>> I don't see Helped-by in
>>> https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fsubmitting-patches.html%23using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdc754791b6844506b11c08dd69f444a7%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638783220330058516%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4bv9pUh6aSD0GVLJ4Zvuyvox1K0xxwf83KXX86QsvMo%3D&reserved=0
>>> 
>>> I see 2496b2aaacf137250f4ca449f465e2cadaabb0e8 got the Helped-by
>>> replaced by a Suggested-by for example, but I see other patches with
>>> Helped-by... if that is a standard trailer for kernel patches, then
>>> maybe we should add it to that doc?
>> 
>> Actually, I already tried to get the Helped-by tag added to the
>> kernel documentation, by submitting a small patch series. [*]
>> Unfortunately, it got rejected. :/
>> 
>> However, Heiko accepts Helped-by tags and nobody higher up the
>> tree seems to complain, so we should be fine. :)  It isn't the
>> case with all maintainers, though.
>> 
>> [*] https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flore.kernel.org%2Fall%2Fcover.1730874296.git.dsimic%40manjaro.org%2FT%2F%23u&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdc754791b6844506b11c08dd69f444a7%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638783220330070422%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3dZgSG%2FBT6f%2Ffqs7D30HvEl18SzqYPwNeUGWBZfMAqM%3D&reserved=0
> 
> Are you trying to up the numbers of Helped-by in commit logs to make
> it a reasonable request to add the trailer in the documentation :) ?

It's just that Helped-by is, to me, of a bit "higher value" than
Suggested-by or Reported-by, because Helped-by means that the
tagged person contributed more to the patch than just suggesting
it or reporting a bug.  In addition, having more Helped-by tags
present in various commits can help a bit with, possibly, making
it officially supported at some point in the future. :)

