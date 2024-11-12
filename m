Return-Path: <stable+bounces-92829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C8D9C60CE
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505821F23841
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B283217F27;
	Tue, 12 Nov 2024 18:51:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD22144D8;
	Tue, 12 Nov 2024 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437514; cv=none; b=jhef3NIUv9xLu4eJfKzez8ojy7y+KNVpvJ50V0CDOYbg57pAQ1GPmNPczjseC/PH/H1AIAVQ+zs85LqZLnL9mwqsEKR6ZWqi4GB/ehzNhL6RiZjwl6O2Vg71OQgK/OsM5QBDCpNOPCx9xh1MJl5YOksQd4o0cwISrXnKoT36UD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437514; c=relaxed/simple;
	bh=IZb9Qolb6oqweuQOCiBsezlbcxbtYXIsJBMpLCYyCo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFhSq9EXxiz2foKB+PZ1FYEsCMLRqrpQfRq0l/xtYZSpz5KetZjf1jvWlNgAxJO4uRDTbTkmfiA6zKD8h40Zb24dLKrNW9hiszsjtIXtZLA4z6LTjRgkkF1lyM9uf/17+JUPPqVREFnpB+6yg7U8V++oYjzaKDCRostUxTMffSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC1801516;
	Tue, 12 Nov 2024 10:52:20 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EF473F66E;
	Tue, 12 Nov 2024 10:51:49 -0800 (PST)
Message-ID: <33f8430e-0adc-4060-afb5-2cc5c79c8dec@arm.com>
Date: Tue, 12 Nov 2024 18:51:48 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Fix vdd_gpu voltage constraints on
 PinePhone Pro
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org
References: <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
 <607a731c-41e9-497a-a08c-f718339610ae@arm.com>
 <fdf58f3e9fcb4c672a4bb114fbdab60d@manjaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <fdf58f3e9fcb4c672a4bb114fbdab60d@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2024 2:36 pm, Dragan Simic wrote:
> Hello Robin,
> 
> On 2024-11-12 15:19, Robin Murphy wrote:
>> On 10/11/2024 6:44 pm, Dragan Simic wrote:
>>> The regulator-{min,max}-microvolt values for the vdd_gpu regulator in 
>>> the
>>> PinePhone Pro device dts file are too restrictive, which prevents the 
>>> highest
>>> GPU OPP from being used, slowing the GPU down unnecessarily.  Let's 
>>> fix that
>>> by making the regulator-{min,max}-microvolt values less strict, using 
>>> the
>>> voltage range that the Silergy SYR838 chip used for the vdd_gpu 
>>> regulator is
>>> actually capable of producing. [1][2]
>>
>> Specifying the absolute limits which the regulator driver necessarily
>> already knows doesn't seem particularly useful... Moreover, the RK3399
>> datasheet specifies the operating range for GPU_VDD as 0.80-1.20V, so
>> at the very least, allowing the regulator to go outside that range
>> seems inadvisable.
> 
> Indeed, which is why I already mentioned in the patch description
> that I do plan to update the constraints of all regulators to match
> the summary of the constraints of their consumers.  Though, I plan
> to do that later, as a separate directory-wide cleanup, for which
> I must find and allocate a substantial amount of time, to make sure
> there will be no mistakes.

Sure, but even if every other DT needs fixing, that still doesn't make 
it a good idea to deliberately introduce the same mistake to *this* DT 
and thus create even more work to fix it again. There's no value in 
being consistently wrong over inconsistently wrong - if there's 
justification for changing this DT at all, change it to be right.

>> However there's a separate datasheet for the
>> RK3399-T variant, which does specify this 875-975mV range and a
>> maximum GPU clock of 600MHz, along with the same 1.5GHz max.
>> Cortex-A72 clock as advertised for RK3399S, so it seems quite possible
>> that these GPU constraints here are in fact intentional as well.
>> Obviously users are free to overclock and overvolt if they wish - I do
>> for my actively-cooled RK3399 board :) - but it's a different matter
>> for mainline to force it upon them.
> 
> Well, maybe the RK3399S is the same in that regard as the RK3399-T,
> but maybe it actually isn't -- unfortunately, we don't have some
> official RK3399S datasheet that would provide us with the required
> information.  As another, somewhat unrelated example, we don't have
> some official documentation to tell us is the RK3399S supposed not
> to have working PCI Express interface, which officially isn't present
> in the RK3399-T variant.

Looking back at the original submission, v2 *was* proposing the RK3399-T 
OPPs, with the GPU capped at 600MHz, and it was said that those are what 
PPP *should* be using[1]. It seems there was a semantic objection to 
having a separate rk3399-t-opp.dtsi at the time, and when the main DTS 
was reworked for v3 the 800MHz GPU OPP seems to have been overlooked. 
However, since rk3399-t.dtsi does now exist anyway, it would seem more 
logical to just use that instead of including rk3399.dtsi and then 
overriding it to be pretty much equivalent to the T variant anyway.

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-rockchip/CAN1fySWVVTeGHAD=_hFH+ZdcR_AEiBc0wqes9Y4VRzB=zcdvSw@mail.gmail.com/

> However, I fully agree that forcing any kind of an overclock is not
> what we want to do.  Thus, I'll do my best, as I already noted in this
> thread, to extract the dtb from the "reference" Android build that
> Rockchip itself provided for the RK3399S-based PinePhone Pro.  That's
> closest to the official documentation for the RK3399S variant that we
> can get our hands on.
> 
>>> This also eliminates the following error messages from the kernel log:
>>>
>>>    core: _opp_supported_by_regulators: OPP minuV: 1100000 maxuV: 
>>> 1150000, not supported by regulator
>>>    panfrost ff9a0000.gpu: _opp_add: OPP not supported by regulators 
>>> (800000000)
>>>
>>> These changes to the regulator-{min,max}-microvolt values make the 
>>> PinePhone
>>> Pro device dts consistent with the dts files for other Rockchip 
>>> RK3399-based
>>> boards and devices.  It's possible to be more strict here, by 
>>> specifying the
>>> regulator-{min,max}-microvolt values that don't go outside of what 
>>> the GPU
>>> actually may use, as the consumer of the vdd_gpu regulator, but those 
>>> changes
>>> are left for a later directory-wide regulator cleanup.
>>>
>>> [1] 
>>> https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
>>> [2] 
>>> https://www.t-firefly.com/download/Firefly-RK3399/docs/Chip%20Specifications/DC-DC_SYR837_838.pdf
>>>
>>> Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for 
>>> Pine64 PinePhone Pro")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>> ---
>>>   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts 
>>> b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>>> index 1a44582a49fb..956d64f5b271 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>>> @@ -410,8 +410,8 @@ vdd_gpu: regulator@41 {
>>>           pinctrl-names = "default";
>>>           pinctrl-0 = <&vsel2_pin>;
>>>           regulator-name = "vdd_gpu";
>>> -        regulator-min-microvolt = <875000>;
>>> -        regulator-max-microvolt = <975000>;
>>> +        regulator-min-microvolt = <712500>;
>>> +        regulator-max-microvolt = <1500000>;
>>>           regulator-ramp-delay = <1000>;
>>>           regulator-always-on;
>>>           regulator-boot-on;

