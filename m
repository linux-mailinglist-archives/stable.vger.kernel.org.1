Return-Path: <stable+bounces-42795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B08B7A40
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFF11C2274B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDAF173344;
	Tue, 30 Apr 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="11b+x3A2"
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42FF1527AF;
	Tue, 30 Apr 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487835; cv=none; b=NJBizbVEilWvBJi1evqXV5hvmNZjWGppNS4YHL43BkOXI05+5myobgu9TDwp6hAdeeSzk8Kl0lLSUVDbHMAwuhKP449U3Tr2O4KYJpWpLVsUqqbDVcvUq/GXl6IZ4+7sqpJErzzMBilwT67kCqmSfiJWPKHCuRoJEmGKa7Tv+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487835; c=relaxed/simple;
	bh=9rSMcuzwwI4PZXYWrwTd12QwuXTRkoqlwdLl9+RkQRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wh3SzqaJHFdPadbz5mjfUAfdMrfaNQFylTuUlLcGaAFDLNoEKQO3OoUu1w30olhbZTawhrCpMEFzKHjSIVpRz/vW6Wm6FunHbqlh+2vkpkhNcuaBoxmU8KdMoQWcmHW92wFFANYv2d6b014Wt5GJI+zDUREwqKLgO1BHx7PgHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=11b+x3A2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714487831;
	bh=9rSMcuzwwI4PZXYWrwTd12QwuXTRkoqlwdLl9+RkQRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=11b+x3A2LoV33qAbm8z7E2/OtwouJCH3Dze4nn/7xdxRdyGQLmAD3n9HxQF9jx6TM
	 AYsRJdxUU+AwcwcHhG4+pFoRWIEVcKbKgqVb7yQaBbOOKat/jU3jATY6m0Vs3oNcD0
	 9IxpyEPHyEjrxoElf7H/6gmt3JDX8ull5sUTZPoPvg19dmxaKE5lv3GwoWL7paOkVj
	 OF3uBz2sQ4DNad7v6g1rXimlLfqxi0D20KXu2vDofBnpAY8WVr9fhIlt4nDJyFwBxU
	 uumfBWP5JbCvT9Dq2ZdgSvVq2m1/fpxQL2O9JgNzD2ofAINpkjWgWbIRoc/iV+4ri/
	 1JB8uZpnUD5qw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6F270378212D;
	Tue, 30 Apr 2024 14:37:11 +0000 (UTC)
Message-ID: <d145f7d8-73f2-40db-b65f-dd56000d2e25@collabora.com>
Date: Tue, 30 Apr 2024 16:37:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "arm64: dts: mediatek: mt7622: drop "reset-names" from
 thermal block" has been added to the 4.19-stable tree
To: Matthias Brugger <matthias.bgg@gmail.com>, stable@vger.kernel.org,
 stable-commits@vger.kernel.org, rafal@milecki.pl
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240428112459.2019420-1-sashal@kernel.org>
 <8ca4ceee-b64d-49ca-8eb8-0dd894181051@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <8ca4ceee-b64d-49ca-8eb8-0dd894181051@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 30/04/24 16:24, Matthias Brugger ha scritto:
> 
> 
> On 4/28/24 13:24, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
>>
>> to the 4.19-stable tree which can be found at:
>>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>       arm64-dts-mediatek-mt7622-drop-reset-names-from-ther.patch
>> and it can be found in the queue-4.19 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit 9628765c4a0eefa9474ef4a0698691a10395a469
>> Author: Rafał Miłecki <rafal@milecki.pl>
>> Date:   Sun Mar 17 23:10:50 2024 +0100
>>
>>      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
>>      [ Upstream commit ecb5b0034f5bcc35003b4b965cf50c6e98316e79 ]
>>      Binding doesn't specify "reset-names" property and Linux driver also
>>      doesn't use it.
> 
> I think that's an open discussion item if fixes to DTS checks are valid stable 
> backports. From my point of view there is no bug so it shouldn't be in stable.
> 

The only benefit apart from one less warning is a few bytes less in a *.dtb file...

I don't feel like I agree with you, but at the same time I also don't feel like
disagreeing - as those are not "fixing practical issues" in the end.

Passing the word to devicetree/bindings maintainers... :-)

Cheers,
Angelo

> Regards,
> Matthias
> 
>>      Fix following validation error:
>>      arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: thermal@1100b000: Unevaluated 
>> properties are not allowed ('reset-names' was unexpected)
>>              from schema $id: 
>> http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
>>      Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related 
>> device nodes")
>>      Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>      Reviewed-by: AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
>>      Link: https://lore.kernel.org/r/20240317221050.18595-5-zajec5@gmail.com
>>      Signed-off-by: AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
>>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>> index 76297dac2d459..f8df34ac1e64d 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>> @@ -459,7 +459,6 @@ thermal: thermal@1100b000 {
>>                <&pericfg CLK_PERI_AUXADC_PD>;
>>           clock-names = "therm", "auxadc";
>>           resets = <&pericfg MT7622_PERI_THERM_SW_RST>;
>> -        reset-names = "therm";
>>           mediatek,auxadc = <&auxadc>;
>>           mediatek,apmixedsys = <&apmixedsys>;
>>           nvmem-cells = <&thermal_calibration>;




