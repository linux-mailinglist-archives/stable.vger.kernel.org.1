Return-Path: <stable+bounces-126832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1274A72B02
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 09:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D397A4F0D
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2277E1FFC42;
	Thu, 27 Mar 2025 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aQIty+8T"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956AA3A1BA;
	Thu, 27 Mar 2025 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743062723; cv=none; b=f2AAEkc+MWKmzt/Q9vEUOykO7vtexwCRON+nEcTOvCkpUDEJ7dzXfXspKn+sXwTCuRcoOJixz+5nDCi58EFoByZK2943BJ0JpBHA58kglVpJ2Z+QR6qVN+n3IJ8whMlc89IuUl1okOCCc7kvAo8DMvPdhtiMQw3zqbpj6LBhYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743062723; c=relaxed/simple;
	bh=F9EWPBC+aRPB+clpv2QSwDl0b7NQoqlU0kHNGRoi/7Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=irn1mBKY5Q5/ZPYxptJRx3E+VkB7GfeHNUWkNo5q+397GIYdqaP58UQS6xVamLMcND11tdaqUPgSGzs8Va3C8pNv+er2qOnUZyB8sgEphKTFwUm6Ip0Zde2flHede2Y3w3+aigcwrEswNEPiuS7nNgrBbz/GMpL2whhicYOvfLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aQIty+8T; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1743062719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QtJKq+OsWpHhYsRUPr9FSDRdjBhO4gzujqqenof5Gw=;
	b=aQIty+8T2fPR116eQzueuqp4MJQLLFL/toTBOr+3/IiJoMiyAFxARk7fZhBkLVYkNqIo4y
	bb3gBpbrc4YRESUr9dGs8XiXt9c4FFpU2ILsuwLPDpQAhb1zVoMutS9C8mVk4qDkyAftnj
	VAmFu2UlBCYBMdnVz6LYK4UAZVzLfoWW/n/EwcDbuDO8hUES5wGlBdbFQnZ5f2wnglx3YH
	nrG1rJk/QQBrAvE7ojzUInZ1K9DrjLOkeHgdJ686L8IR4fLyAKf2eiUgtuOpfPg+QhZi1s
	hxBO4zlVTBBncPGd3raWKJeWlQxF9p6Q0Fv+qeg3f0hcOb7KmKtrdsyCtpZOpw==
Date: Thu, 27 Mar 2025 09:05:17 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org, Alexey Charkov
 <alchark@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Remove overdrive-mode OPPs from
 RK3588J SoC dtsi
In-Reply-To: <f73743cb-fdea-4b53-9665-4cc303498171@cherry.de>
References: <eeec0d30d79b019d111b3f0aa2456e69896b2caa.1742813866.git.dsimic@manjaro.org>
 <f73743cb-fdea-4b53-9665-4cc303498171@cherry.de>
Message-ID: <5f39aa155b2ef6e6b355b7f9f9a6ce6b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Quentin,

On 2025-03-26 11:07, Quentin Schulz wrote:
> On 3/24/25 12:00 PM, Dragan Simic wrote:
>> The differences in the vendor-approved CPU and GPU OPPs for the 
>> standard
>> Rockchip RK3588 variant [1] and the industrial Rockchip RK3588J 
>> variant [2]
>> come from the latter, presumably, supporting an extended temperature 
>> range
>> that's usually associated with industrial applications, despite the 
>> two SoC
>> variant datasheets specifying the same upper limit for the allowed 
>> ambient
>> temperature for both variants.  However, the lower temperature limit 
>> is
>> specified much lower for the RK3588J variant. [1][2]
>> 
>> To be on the safe side and to ensure maximum longevity of the RK3588J 
>> SoCs,
>> only the CPU and GPU OPPs that are declared by the vendor to be always 
>> safe
>> for this SoC variant may be provided.  As explained by the vendor [3] 
>> and
>> according to the RK3588J datasheet, [2] 
>> higher-frequency/higher-voltage
>> CPU and GPU OPPs can be used as well, but at the risk of reducing the 
>> SoC
>> lifetime expectancy.  Presumably, using the higher OPPs may be safe 
>> only
>> when not enjoying the assumed extended temperature range that the 
>> RK3588J,
>> as an SoC variant targeted specifically at higher-temperature, 
>> industrial
>> applications, is made (or binned) for.
>> 
>> Anyone able to keep their RK3588J-based board outside the 
>> above-presumed
>> extended temperature range at all times, and willing to take the 
>> associated
>> risk of possibly reducing the SoC lifetime expectancy, is free to 
>> apply
>> a DT overlay that adds the higher CPU and GPU OPPs.
>> 
>> With all this and the downstream RK3588(J) DT definitions [4][5] in 
>> mind,
>> let's delete the RK3588J CPU and GPU OPPs that are not considered 
>> belonging
>> to the normal operation mode for this SoC variant.  To quote the 
>> RK3588J
>> datasheet [2], "normal mode means the chipset works under safety 
>> voltage
>> and frequency;  for the industrial environment, highly recommend to 
>> keep in
> 
> FYI, the answer from Rockchip support about what "industrial
> environment" means is:
> 
> """
> Industrial environments encompass a wide range of settings, from
> manufacturing plants to chemical processing facilities. These
> environments are characterized by the use of complex machinery,
> stringent safety protocols, and the need for continuous operations.
> """
> 
> which is not really helping me understand when we should be able to
> use the overdrive mode.

Thanks for forwarding this!  I really can't escape comparing the
response from Rockchip support to the old funny story in which
a passenger on a plane asks a flight attendant where they are,
and the attendant responds that they're on a plane. :D

In other words, that's perfectly valid information that describes
what an industrial environment looks like, but it has nothing to
do with describing the specifics of the applications of RK3588J
in such environments.

> Why would you buy an RK3588J variant if you don't plan on using them
> on the -40 - -20°C range that isn't supported by the RK3588 variant,
> which seems to me to be the only advertised difference?

Yes, AFAICT that's the only directly related difference in the
hard numbers provided by the RK3588 and RK3588J datasheets.

> It also seems like the RK3588M supports the same operating range as
> the RK3588J but at faster speeds? c.f.
> https://en.t-firefly.com/product/industry/aio3588mq#spec and
> https://download.t-firefly.com/%E4%BA%A7%E5%93%81%E8%A7%84%E6%A0%BC%E6%96%87%E6%A1%A3/%E6%A0%B8%E5%BF%83%E6%9D%BF/iCore-3588MQ%20-%20Automotive-Grade%20AI%20Core%20Board.pdf
> 
> Couldn't find a datasheet though.

There's also the following document:
https://download.t-firefly.com/Spec/CoreBorads/iCore-3588Q_Specification_EN.pdf?v=1743061914

I've also been unable to find the RK3588M datasheet.  Regarding
the Firefly SoMs with different RK3588 variants, it does seem
that the RK3588M, i.e. the automotive variant, is capable of
reaching 2.0 GHz throughout its entire operating range.

Maybe the RK3588M datasheet will become publicly available at
some point, allowing us to learn a bit more about it.

> Talk about confusing specs...
> 
> I'll stop caring from now about this very topic :)

We've exhausted all the available resources, so there actually
isn't much more to do anyway.

