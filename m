Return-Path: <stable+bounces-92855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8579C64F4
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF42728480E
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D07021C16A;
	Tue, 12 Nov 2024 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xnSYJeBm"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076421B457;
	Tue, 12 Nov 2024 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453137; cv=none; b=FedBYKSlBgWLll5CSr4NfROmCTwBlfQM0f68/srveJEwtT+jiHUrqpnU+VkUqcjcDzp5LVlyejDcypthW+Go6mzbHwlu5b8h8WzB5rETNYctTGIPImZaBSxds5oRGhEX18XLDMWqeZGmrivRDZnqZMztoG9xYfNDaGQPxX1fxu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453137; c=relaxed/simple;
	bh=pVXkJ5pXW/TAGK884JUjhObBcVb09TxXB22O2gyPvYs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=J13Cj8KRE/5itKdVcwb5jlFX6lo6RmKLmV4wQ3dwulrfBXEFiKIjRrpkJp2dzgXwLtpex5/Ae8eE5uaqBiYwObtkYI9AFR3yrM2XwwFS4QUfZTqbYXN26A6ldcZohIFvwXNFMHeTeMy0HvkYnoFhjWYJHo6rdgew3xL3fzSCHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xnSYJeBm; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731453133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4I0/umEkHMESvC3qIgXCsO3xJ243mX0eXN3WO9pKnZc=;
	b=xnSYJeBmZn9GNFWJYuF0tjise9MfXrpkwsPLs3TvfQ+DjC2NUcrnHmAtRassDigPEKc8Ff
	p6ZGBtEAevz/3s2Hr8xzgFKODfT6Zhs1ya4NtpwjWffpqQmZeHeUS3n4pe3UbdqIm/E/Hu
	UWuY+KdW0Z7ANcddxsnWQRzHA8ByEYwmb9grAkkJO4Z6W+3OQCF4ypt7/cjRd1q6N4FjV2
	0Kl3NinqNQI7eHwEyMMCffZPgYi0ELRHwfs31s3Py5ArrKQxTEm82vEd9jr5YCPxV3wjvU
	34UuIlxNGIYuEYsHPXn2wvtsaVK0gmo+aN4FK+n4ACfXMchLM911P3F4fX/qlg==
Date: Wed, 13 Nov 2024 00:12:12 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix vdd_gpu voltage constraints on
 PinePhone Pro
In-Reply-To: <33f8430e-0adc-4060-afb5-2cc5c79c8dec@arm.com>
References: <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
 <607a731c-41e9-497a-a08c-f718339610ae@arm.com>
 <fdf58f3e9fcb4c672a4bb114fbdab60d@manjaro.org>
 <33f8430e-0adc-4060-afb5-2cc5c79c8dec@arm.com>
Message-ID: <4ba2d58cf1da5b90930b630ba0978e2c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Robin,

On 2024-11-12 19:51, Robin Murphy wrote:
> On 12/11/2024 2:36 pm, Dragan Simic wrote:
>> On 2024-11-12 15:19, Robin Murphy wrote:
>>> On 10/11/2024 6:44 pm, Dragan Simic wrote:
>>>> The regulator-{min,max}-microvolt values for the vdd_gpu regulator 
>>>> in the
>>>> PinePhone Pro device dts file are too restrictive, which prevents 
>>>> the highest
>>>> GPU OPP from being used, slowing the GPU down unnecessarily.  Let's 
>>>> fix that
>>>> by making the regulator-{min,max}-microvolt values less strict, 
>>>> using the
>>>> voltage range that the Silergy SYR838 chip used for the vdd_gpu 
>>>> regulator is
>>>> actually capable of producing. [1][2]
>>> 
>>> Specifying the absolute limits which the regulator driver necessarily
>>> already knows doesn't seem particularly useful... Moreover, the 
>>> RK3399
>>> datasheet specifies the operating range for GPU_VDD as 0.80-1.20V, so
>>> at the very least, allowing the regulator to go outside that range
>>> seems inadvisable.
>> 
>> Indeed, which is why I already mentioned in the patch description
>> that I do plan to update the constraints of all regulators to match
>> the summary of the constraints of their consumers.  Though, I plan
>> to do that later, as a separate directory-wide cleanup, for which
>> I must find and allocate a substantial amount of time, to make sure
>> there will be no mistakes.
> 
> Sure, but even if every other DT needs fixing, that still doesn't make
> it a good idea to deliberately introduce the same mistake to *this* DT
> and thus create even more work to fix it again. There's no value in
> being consistently wrong over inconsistently wrong - if there's
> justification for changing this DT at all, change it to be right.

After thinking a bit more about it, I agree.  At least, setting the
voltage regulator constraints according to the constraints of its
consumer(s) in one place sets an example for what's to be done in
the future for the other voltage regulators.

>>> However there's a separate datasheet for the
>>> RK3399-T variant, which does specify this 875-975mV range and a
>>> maximum GPU clock of 600MHz, along with the same 1.5GHz max.
>>> Cortex-A72 clock as advertised for RK3399S, so it seems quite 
>>> possible
>>> that these GPU constraints here are in fact intentional as well.
>>> Obviously users are free to overclock and overvolt if they wish - I 
>>> do
>>> for my actively-cooled RK3399 board :) - but it's a different matter
>>> for mainline to force it upon them.
>> 
>> Well, maybe the RK3399S is the same in that regard as the RK3399-T,
>> but maybe it actually isn't -- unfortunately, we don't have some
>> official RK3399S datasheet that would provide us with the required
>> information.  As another, somewhat unrelated example, we don't have
>> some official documentation to tell us is the RK3399S supposed not
>> to have working PCI Express interface, which officially isn't present
>> in the RK3399-T variant.
> 
> Looking back at the original submission, v2 *was* proposing the
> RK3399-T OPPs, with the GPU capped at 600MHz, and it was said that
> those are what PPP *should* be using[*]. It seems there was a semantic
> objection to having a separate rk3399-t-opp.dtsi at the time, and when
> the main DTS was reworked for v3 the 800MHz GPU OPP seems to have been
> overlooked. However, since rk3399-t.dtsi does now exist anyway, it
> would seem more logical to just use that instead of including
> rk3399.dtsi and then overriding it to be pretty much equivalent to the
> T variant anyway.

Ah, I see, thanks for pointing this out.  With this in mind, I think
that the RK3399S is actually just the RK3399-T binned specifically
for lower leakage values and, as a result, lower power consumption.
I've already assumed so, but this reaffirms it.

Actually, there's now also the rk3399-s.dtsi, [**] in which I just
spotted a rather small, non-critical mistake that I made, for which
I'll send a separate patch later.

Anyway, the rk3399-t.dtsi, originally known as rk3399-t-opp.dtsi and
added in the commit 9176ba910ba0 (arm64: dts: rockchip: Add RK3399-T
OPP table, 2022-09-02) specifies a bit higher voltages for the OPPs
than those found in the rk3399-s.dtsi, which fits well together with
the above-described assumption that the RK3399S is actually just the
RK3399-T specifically binned for lower leakage values...

... which also means that the RK3399S's GPU is supposed to run at
the GPU OPPs _below_ 800 MHz, just like the RK3399-T, but at slightly
lower voltages specified in the rk3399-s.dtsi.

Let me dig out that Rockchip Android dtb for the PinePhone Pro that
I mentioned already, to provide the last piece of evidence, and I'll
come back with the v2 of this patch.

[*] 
https://lore.kernel.org/linux-rockchip/CAN1fySWVVTeGHAD=_hFH+ZdcR_AEiBc0wqes9Y4VRzB=zcdvSw@mail.gmail.com/
[**] 
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=for-next&id=f7f8ec7d8cef4cf62ee13b526d59438c23bbb34f

>> However, I fully agree that forcing any kind of an overclock is not
>> what we want to do.  Thus, I'll do my best, as I already noted in this
>> thread, to extract the dtb from the "reference" Android build that
>> Rockchip itself provided for the RK3399S-based PinePhone Pro.  That's
>> closest to the official documentation for the RK3399S variant that we
>> can get our hands on.
>> 
>>>> This also eliminates the following error messages from the kernel 
>>>> log:
>>>> 
>>>>    core: _opp_supported_by_regulators: OPP minuV: 1100000 maxuV: 
>>>> 1150000, not supported by regulator
>>>>    panfrost ff9a0000.gpu: _opp_add: OPP not supported by regulators 
>>>> (800000000)
>>>> 
>>>> These changes to the regulator-{min,max}-microvolt values make the 
>>>> PinePhone
>>>> Pro device dts consistent with the dts files for other Rockchip 
>>>> RK3399-based
>>>> boards and devices.  It's possible to be more strict here, by 
>>>> specifying the
>>>> regulator-{min,max}-microvolt values that don't go outside of what 
>>>> the GPU
>>>> actually may use, as the consumer of the vdd_gpu regulator, but 
>>>> those changes
>>>> are left for a later directory-wide regulator cleanup.
>>>> 
>>>> [1] 
>>>> https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
>>>> [2] 
>>>> https://www.t-firefly.com/download/Firefly-RK3399/docs/Chip%20Specifications/DC-DC_SYR837_838.pdf
>>>> 
>>>> Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for 
>>>> Pine64 PinePhone Pro")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>>> ---
>>>>   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>> 
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts 
>>>> b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>>>> index 1a44582a49fb..956d64f5b271 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>>>> @@ -410,8 +410,8 @@ vdd_gpu: regulator@41 {
>>>>           pinctrl-names = "default";
>>>>           pinctrl-0 = <&vsel2_pin>;
>>>>           regulator-name = "vdd_gpu";
>>>> -        regulator-min-microvolt = <875000>;
>>>> -        regulator-max-microvolt = <975000>;
>>>> +        regulator-min-microvolt = <712500>;
>>>> +        regulator-max-microvolt = <1500000>;
>>>>           regulator-ramp-delay = <1000>;
>>>>           regulator-always-on;
>>>>           regulator-boot-on;

