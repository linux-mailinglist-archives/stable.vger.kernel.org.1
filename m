Return-Path: <stable+bounces-125879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2FA6D858
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 11:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5280169882
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F0925DCF5;
	Mon, 24 Mar 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tzBmpe6y"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD21953A9;
	Mon, 24 Mar 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812444; cv=none; b=DsUqtElZiwmCKXQh/oH4umt7l73uTO+nL8rMUTzD1l107HBP/2of09LgJLoDt7QLD01Cetgthe5UBEBVsy9mOMgOVabhay+u9a41MgHTMXKhnvZ80pWk8ET5GOG7RdrvalWs4WUD/7zJI1YQMniQhSvXlafOIDOhB2sMax/6Tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812444; c=relaxed/simple;
	bh=yWHN60OPmraLqhtBq5lhjheIQXR/F7iBUPLr7BPi7R8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=S+n4n1vJE2NJc8xowjeAmJi0I1t7yZjRkmKyBU9N15vkA4h0HqJcdzbAb7Nn3y3kGA7wiY1Jzpihnilteccrv/lFDMS4dflOUGNaZy9XTb3mwlOKx0B7vptMKJhe6fxkBC3kaY54B5DceJigqfjKVm2Gju5HhkYPTwnN8dQQNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tzBmpe6y; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1742812433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eI7gPyQYRsRBMrw/lvACQBiN3JsT2YD+lfGEOC2JxYU=;
	b=tzBmpe6y4C9C1mC187Q2hITuYbsywdQEk9ISEptzHhtaaMWMEXT9wyejk/K91P70RuDFt0
	yh7LOLNj0Jig/SUKDRxlqgdmqpmo0oMmeKIK+xwWSbNxWJvDZzxuDLw3c6wLJ/E1WGOGGb
	pD3aBw//mpNMo6fV55zHDAWQde+ldynndHLyeALFMMmKhlOk4AcDxIJegLTXfDXjcvBPbf
	8y2M8OTgqv4oGnaNXRnoe31cVUh3p/UVivt/saEZKVSXm6SlwMWeDd/yvLXwB55zljrROj
	ibghbX+nD1lzry+Y3YGz+tUT2YxukwHAEsvzw5tGERCd5xpDHei8z2x4TjtOBg==
Date: Mon, 24 Mar 2025 11:33:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org, Alexey Charkov
 <alchark@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Remove overdrive-mode OPPs from
 RK3588J SoC dtsi
In-Reply-To: <170e4d8d-33ca-4c53-9ae7-ca9d674540a9@cherry.de>
References: <f929da061de35925ea591c969f985430e23c4a7e.1742526811.git.dsimic@manjaro.org>
 <71b7c81b-6a4e-442b-a661-04d63639962a@cherry.de>
 <960c038ad9f7b83fe14d0ded388b42f7@manjaro.org>
 <2ece5cca-50ea-4ec9-927e-e757c9c10c18@cherry.de>
 <4d25c9af4380598b35a0d55e7c77ac3d@manjaro.org>
 <170e4d8d-33ca-4c53-9ae7-ca9d674540a9@cherry.de>
Message-ID: <17b55e889838f2c989bd0efc6528801b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2025-03-24 11:20, Quentin Schulz wrote:
> On 3/24/25 10:53 AM, Dragan Simic wrote:
>> On 2025-03-24 10:23, Quentin Schulz wrote:
>>> On 3/23/25 11:19 AM, Dragan Simic wrote:
>>>> On 2025-03-21 10:53, Quentin Schulz wrote:
>>>>> On 3/21/25 4:28 AM, Dragan Simic wrote:
>>>>>> The differences in the vendor-approved CPU and GPU OPPs for the 
>>>>>> standard
>>>>>> Rockchip RK3588 variant [1] and the industrial Rockchip RK3588J 
>>>>>> variant [2]
>>>>>> come from the latter, presumably, supporting an extended 
>>>>>> temperature range
>>>>>> that's usually associated with industrial applications, despite 
>>>>>> the two SoC
>>>>>> variant datasheets specifying the same upper limit for the allowed 
>>>>>> ambient
>>>>>> temperature for both variants.  However, the lower temperature 
>>>>>> limit is
>>>>> 
>>>>> RK3588 is rated for 0-80°C, RK3588J for -40-85°C, c.f. Recommended
>>>>> Operating Conditions, Table 3-2, Ambient Operating Temperature.
>>>> 
>>>> Indeed, which is why I specifically wrote "specifying the same upper
>>>> limit", because having a lower negative temperature limit could 
>>>> hardly
>>>> put the RK3588J in danger of overheating or running hotter. :)
>>> 
>>> """
>>> despite the two SoC variant datasheets specifying the same upper 
>>> limit
>>> for the allowed temperature for both variants
>>> """
>>> 
>>> is incorrect. The whole range is different, yes it's only a 5°C
>>> difference for the upper limit, but they still are different.
>> 
>> I just commented on this separately, with a couple of datasheet
>> screenshots, before I saw your latest response.  Please, have
>> a look at that message.
> 
> I see, I had a v1.3 datasheet opened:
> 
> https://github.com/FanX-Tek/rk3588-TRM-and-Datasheet/blob/master/Rockchip_RK3588_Datasheet_V1.3-20220328.pdf

Yup, the v1.6 of the RK3588 datasheet increased the upper ambient
temperature limit from 80 to 85 oC.

> Interestingly, it seems the RK3588S (still?) has a smaller operating 
> range:
> 
> https://www.armboard.cn/download/Rockchip_RK3588S_Datasheet_V1.6-20240821.pdf

Oh, that's quite interesting, I had the v1.5 as the newest version.
The v1.6 of the RK3588S datasheet actually lowered the upper ambient
temperature limit from 85 down to 80 oC.

