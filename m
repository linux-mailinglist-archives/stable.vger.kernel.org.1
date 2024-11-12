Return-Path: <stable+bounces-92793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED0A9C5A7F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 15:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC761F2358D
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7A1FEFA6;
	Tue, 12 Nov 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lP18VSUS"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C213BAE2;
	Tue, 12 Nov 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422206; cv=none; b=VT8J53Qk3PLx28ph5nCfuBGTMAqd/Tt+/iaSOy7P9kmc+TqPjzV4kZP7aox5qNDCPrNcJd+9T+4bE6ApgngaMfDz3BdOiG9FjkF/d7Fdtq7YQDhbYhNqQMIF4WCV9xGBP9eUXBVM4eAB+whWC1Zh/N7zz9AgKXNtZamlANHx+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422206; c=relaxed/simple;
	bh=aOO9QZMTHau3vTCUo3PfPAinL0t8EQepGvynB/EOXqg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=I3yiD7EQnliVkrzPfVLuMBPwIRi8j9G9oDqlcF607tIelVBaSASBdphsrkOPNjTPXBdplElnjsadVToij2QmElYe/8pnyx+5/PeD+tjxV+PSzKyfhSLh+Wn0Zj/hCUewYpNHPnO3GECjQP/+kHUM7V82H06lQrdUpXfmIgYVD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lP18VSUS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731422201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p37w8dh3AMk4B0TEeIgVCn6S2A3tTzg9OwNCj8TrimU=;
	b=lP18VSUS81kGud5E6Mo8dEoe3wl9IDmvKcYolW5MJc+ognXnrJbr2X5ZJrLK61keBEf/Qv
	BMvVCYQyO58cp9HOood0JjU5p+M/v07hV23stEhkpiMCrWl5+Bp8RI7tTDt65dHWT/uvhG
	vcRg0UEBFgqY/ZeFkHQw9YiLIJu3kE9mei8zrGnLpeJ7zriziE96+9jCqble2bIvhimMD3
	v7SGJ/2oWxlON6KBN6pO28uws0dpOGxmYEAfNYq0WSXXNri5aEQj9wFSNVwGXiOSLe+pF7
	IGSAlw/bML6RAgQNCt1eGvz23sLb4m+S+9f/xRgGi/DNHLSwzOt2os4vweQpdQ==
Date: Tue, 12 Nov 2024 15:36:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix vdd_gpu voltage constraints on
 PinePhone Pro
In-Reply-To: <607a731c-41e9-497a-a08c-f718339610ae@arm.com>
References: <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
 <607a731c-41e9-497a-a08c-f718339610ae@arm.com>
Message-ID: <fdf58f3e9fcb4c672a4bb114fbdab60d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Robin,

On 2024-11-12 15:19, Robin Murphy wrote:
> On 10/11/2024 6:44 pm, Dragan Simic wrote:
>> The regulator-{min,max}-microvolt values for the vdd_gpu regulator in 
>> the
>> PinePhone Pro device dts file are too restrictive, which prevents the 
>> highest
>> GPU OPP from being used, slowing the GPU down unnecessarily.  Let's 
>> fix that
>> by making the regulator-{min,max}-microvolt values less strict, using 
>> the
>> voltage range that the Silergy SYR838 chip used for the vdd_gpu 
>> regulator is
>> actually capable of producing. [1][2]
> 
> Specifying the absolute limits which the regulator driver necessarily
> already knows doesn't seem particularly useful... Moreover, the RK3399
> datasheet specifies the operating range for GPU_VDD as 0.80-1.20V, so
> at the very least, allowing the regulator to go outside that range
> seems inadvisable.

Indeed, which is why I already mentioned in the patch description
that I do plan to update the constraints of all regulators to match
the summary of the constraints of their consumers.  Though, I plan
to do that later, as a separate directory-wide cleanup, for which
I must find and allocate a substantial amount of time, to make sure
there will be no mistakes.

> However there's a separate datasheet for the
> RK3399-T variant, which does specify this 875-975mV range and a
> maximum GPU clock of 600MHz, along with the same 1.5GHz max.
> Cortex-A72 clock as advertised for RK3399S, so it seems quite possible
> that these GPU constraints here are in fact intentional as well.
> Obviously users are free to overclock and overvolt if they wish - I do
> for my actively-cooled RK3399 board :) - but it's a different matter
> for mainline to force it upon them.

Well, maybe the RK3399S is the same in that regard as the RK3399-T,
but maybe it actually isn't -- unfortunately, we don't have some
official RK3399S datasheet that would provide us with the required
information.  As another, somewhat unrelated example, we don't have
some official documentation to tell us is the RK3399S supposed not
to have working PCI Express interface, which officially isn't present
in the RK3399-T variant.

However, I fully agree that forcing any kind of an overclock is not
what we want to do.  Thus, I'll do my best, as I already noted in this
thread, to extract the dtb from the "reference" Android build that
Rockchip itself provided for the RK3399S-based PinePhone Pro.  That's
closest to the official documentation for the RK3399S variant that we
can get our hands on.

>> This also eliminates the following error messages from the kernel log:
>> 
>>    core: _opp_supported_by_regulators: OPP minuV: 1100000 maxuV: 
>> 1150000, not supported by regulator
>>    panfrost ff9a0000.gpu: _opp_add: OPP not supported by regulators 
>> (800000000)
>> 
>> These changes to the regulator-{min,max}-microvolt values make the 
>> PinePhone
>> Pro device dts consistent with the dts files for other Rockchip 
>> RK3399-based
>> boards and devices.  It's possible to be more strict here, by 
>> specifying the
>> regulator-{min,max}-microvolt values that don't go outside of what the 
>> GPU
>> actually may use, as the consumer of the vdd_gpu regulator, but those 
>> changes
>> are left for a later directory-wide regulator cleanup.
>> 
>> [1] 
>> https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
>> [2] 
>> https://www.t-firefly.com/download/Firefly-RK3399/docs/Chip%20Specifications/DC-DC_SYR837_838.pdf
>> 
>> Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for 
>> Pine64 PinePhone Pro")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> index 1a44582a49fb..956d64f5b271 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> @@ -410,8 +410,8 @@ vdd_gpu: regulator@41 {
>>   		pinctrl-names = "default";
>>   		pinctrl-0 = <&vsel2_pin>;
>>   		regulator-name = "vdd_gpu";
>> -		regulator-min-microvolt = <875000>;
>> -		regulator-max-microvolt = <975000>;
>> +		regulator-min-microvolt = <712500>;
>> +		regulator-max-microvolt = <1500000>;
>>   		regulator-ramp-delay = <1000>;
>>   		regulator-always-on;
>>   		regulator-boot-on;

