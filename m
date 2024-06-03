Return-Path: <stable+bounces-47850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155FC8D7C3F
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 09:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AE22852A1
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B8433DC;
	Mon,  3 Jun 2024 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uKigS6SR"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26362943F;
	Mon,  3 Jun 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398646; cv=none; b=r3yOMLs4n+hf6BMEWx8xnq12sGrdvIAhar1vYiq6R4h+XTm7T6AKgfmmDra8PdFjKvXZWKmi+0KU0v70Dzi9NnwN9AoMaPyShRmEfPhZqgSjR1po/M47DCZ9fx/G/dAQqsVr7inhrbZfg965OOyvVzT4pe+KW3ONX3Op1/dB18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398646; c=relaxed/simple;
	bh=qP3EDsnQnnnk2cJx3rXmkpXZbIM9X8T8YHBg2nk9I2A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=u5+qhzaFAni15y58JmcmMa3NizY2MTE/40FNw1LQT3Fqs2i3upJqoSS+66omDvCEfXstN01WXC3PJtYTV47iVKksUjBMv1XH1v/Y/ACJgrwwr7nw3usNsiKi7nxuvr2QlcmOvyM5j6UIoGh7Fe0qOJzQM4qaYXRN4pKCGVfHP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uKigS6SR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717398642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkAKTauI9zE1D31SIfiMUFTpwSR4D3xQBHUx+3vrvAw=;
	b=uKigS6SR7ErFLbfGUu8/C/afwLT3smTjbFpJWOYVa/owlyCiiN5OLctURXLVgDfaXLMJOa
	prR+58gYg/dT2ubRPq1fgMf2uHe6Z4AKMNRHx/l7aD75e3bMW5CcWvKO3LxXZ+ffQrrwGB
	YbGS4BVeXiosQXxQTDOCASunIIDHdhvfcxOhBP4Xr8vdmDGlamoGyV5VVbgPiSpqvTfP7O
	X+dI0ybL1l9ljhdqQTTaUT/SCnCZJsY3QUHGFd2EC9MuloUN2PorJJGyrq1c2TVuWaKpBf
	tRTV1aAUcgXw52YrdTY7LWJmIKKpziUOJK3CXtlSBplavEBPI0mw8pXno9cc6g==
Date: Mon, 03 Jun 2024 09:10:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Krzysztof Kozlowski
 <krzk@kernel.org>
Cc: wens@kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Diederik de Haas
 <didi.debian@cknow.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage
 on Quartz64 Model B
In-Reply-To: <d4823f8caff4fb638fd1ec9444e4f508@manjaro.org>
References: <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
 <ee74c146d1e69bef118e208fdf5cf10f@manjaro.org>
 <d0ab380955c293cf676938be5ea5bf52@manjaro.org> <2165494.3Lj2Plt8kZ@diego>
 <d4823f8caff4fb638fd1ec9444e4f508@manjaro.org>
Message-ID: <d2644af736096bc12c148c05847c4c4a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

+To: Krzysztof Kozlowski <krzk@kernel.org>

Please see the question at the very end of this message.

On 2024-06-03 08:54, Dragan Simic wrote:
> On 2024-06-03 08:33, Heiko Stübner wrote:
>> Am Montag, 3. Juni 2024, 06:51:58 CEST schrieb Dragan Simic:
>>> On 2024-06-03 06:41, Dragan Simic wrote:
>>> > On 2024-06-03 05:49, Chen-Yu Tsai wrote:
>>> >> On Sat, Jun 1, 2024 at 6:41 AM Dragan Simic <dsimic@manjaro.org>
>>> >> wrote:
>>> >>> On 2024-05-31 20:40, Heiko Stübner wrote:
>>> >>> > Am Freitag, 31. Mai 2024, 00:48:45 CEST schrieb Dragan Simic:
>>> >>> >> On 2024-05-29 18:27, Chen-Yu Tsai wrote:
>>> >>> >> > On Tue, May 21, 2024 at 1:20 AM Dragan Simic <dsimic@manjaro.org>
>>> >>> >> > wrote:
>>> >>> >> >>
>>> >>> >> >> Correct the specified regulator-min-microvolt value for the buck
>>> >>> >> >> DCDC_REG2
>>> >>> >> >> regulator, which is part of the Rockchip RK809 PMIC, in the Pine64
>>> >>> >> >> Quartz64
>>> >>> >> >> Model B board dts.  According to the RK809 datasheet, version 1.01,
>>> >>> >> >> this
>>> >>> >> >> regulator is capable of producing voltages as low as 0.5 V on its
>>> >>> >> >> output,
>>> >>> >> >> instead of going down to 0.9 V only, which is additionally confirmed
>>> >>> >> >> by the
>>> >>> >> >> regulator-min-microvolt values found in the board dts files for the
>>> >>> >> >> other
>>> >>> >> >> supported boards that use the same RK809 PMIC.
>>> >>> >> >>
>>> >>> >> >> This allows the DVFS to clock the GPU on the Quartz64 Model B below
>>> >>> >> >> 700 MHz,
>>> >>> >> >> all the way down to 200 MHz, which saves some power and reduces the
>>> >>> >> >> amount of
>>> >>> >> >> generated heat a bit, improving the thermal headroom and possibly
>>> >>> >> >> improving
>>> >>> >> >> the bursty CPU and GPU performance on this board.
>>> >>> >> >>
>>> >>> >> >> This also eliminates the following warnings in the kernel log:
>>> >>> >> >>
>>> >>> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,
>>> >>> >> >> not supported by regulator
>>> >>> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
>>> >>> >> >> (200000000)
>>> >>> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,
>>> >>> >> >> not supported by regulator
>>> >>> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
>>> >>> >> >> (300000000)
>>> >>> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,
>>> >>> >> >> not supported by regulator
>>> >>> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
>>> >>> >> >> (400000000)
>>> >>> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,
>>> >>> >> >> not supported by regulator
>>> >>> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
>>> >>> >> >> (600000000)
>>> >>> >> >>
>>> >>> >> >> Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B
>>> >>> >> >> device tree")
>>> >>> >> >> Cc: stable@vger.kernel.org
>>> >>> >> >> Reported-By: Diederik de Haas <didi.debian@cknow.org>
>>> >>> >> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>> >>> >> >> ---
>>> >>> >> >>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
>>> >>> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> >>> >> >>
>>> >>> >> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>>> >>> >> >> b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>>> >>> >> >> index 26322a358d91..b908ce006c26 100644
>>> >>> >> >> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>>> >>> >> >> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>>> >>> >> >> @@ -289,7 +289,7 @@ vdd_gpu: DCDC_REG2 {
>>> >>> >> >>                                 regulator-name = "vdd_gpu";
>>> >>> >> >>                                 regulator-always-on;
>>> >>> >> >>                                 regulator-boot-on;
>>> >>> >> >> -                               regulator-min-microvolt = <900000>;
>>> >>> >> >> +                               regulator-min-microvolt = <500000>;
>>> >>> >> >
>>> >>> >> > The constraints here are supposed to be the constraints of the
>>> >>> >> > consumer,
>>> >>> >> > not the provider. The latter is already known by the implementation.
>>> >>> >> >
>>> >>> >> > So if the GPU can go down to 0.825V or 0.81V even (based on the
>>> >>> >> > datasheet),
>>> >>> >> > this should say the corresponding value. Surely the GPU can't go down
>>> >>> >> > to
>>> >>> >> > 0.5V?
>>> >>> >> >
>>> >>> >> > Can you send another fix for it?
>>> >>> >>
>>> >>> >> I can confirm that the voltage of the power supply of GPU found inside
>>> >>> >> the RK3566 can be as low as 0.81 V, according to the datasheet, or as
>>> >>> >> low as 0.825 V, according to the GPU OPPs found in rk356x.dtsi.
>>> >>> >>
>>> >>> >> If we want the regulator-min-microvolt parameter to reflect the
>>> >>> >> contraint
>>> >>> >> of the GPU as the consumer, which I agree with, we should do that for
>>> >>> >> other
>>> >>> >> RK3566-based boards as well, and almost surely for the boards based on
>>> >>> >> the
>>> >>> >> RK3568, too.
>>> >>> >
>>> >>> > Hmm, I'm not so sure about that.
>>> >>> >
>>> >>> > The binding does define:
>>> >>> >       regulator-min-microvolt:
>>> >>> >           description: smallest voltage consumers may set
>>> >>> >
>>> >>> > This does not seem to describe it as a constraint solely of the
>>> >>> > consumer.
>>> >>> > At least the wording sounds way more flexible there.
>>> >>> >
>>> >>> > Also any regulator _could_ have multiple consumers, whose value would
>>> >>> > it need then.
>>> >>>
>>> >>> The way I see it, the regulator-min-microvolt and
>>> >>> regulator-max-microvolt
>>> >>> parameters should be configured in a way that protects the
>>> >>> consumer(s)
>>> >>> of the particular voltage regulator against undervoltage and
>>> >>> overvoltage
>>> >>> conditions, which may be useful in some corner cases.
>>> >>>
>>> >>> If there are multiple consumers, which in this case may actually
>>> >>> happen
>>> >>> (IIRC, some boards use the same regulator for the GPU and NPU
>>> >>> portions
>>> >>> of the SoC), the situation becomes far from ideal, because the
>>> >>> consumers
>>> >>> might have different voltage requirements, but that's pretty much an
>>> >>> unavoidable compromise.
>>> >>
>>> >> As Dragan mentioned, the min/max voltage constraints are there to
>>> >> prevent
>>> >> the implementation from setting a voltage that would make the hardware
>>> >> inoperable, either temporarily or permanently. So the range set here
>>> >> should be the intersection of the permitted ranges of all consumers on
>>> >> that power rail.
>>> >>
>>> >> Now if that intersection happens to be an empty set, then it would up
>>> >> to the implementation to do proper lock-outs. Hopefully no one designs
>>> >> such hardware as it's too easy to fry some part of the hardware.
>>> >
>>> > Yes, such a hardware design would need fixing first on the schematic
>>> > level.  When it comes to the RK3566's GPU and NPU sharing the same
>>> > regulator, we should be fine because the RK3566 datasheet states that
>>> > both the GPU and the NPU can go as low as 0.81 V, and their upper
>>> > absolute ratings are the same at 1.2 V, so 1.0 V, which is as far as
>>> > the GPU OPPs go, should be fine for both.
>>> >
>>> > As a note, neither the RK3566 datasheet nor the RK3566 hardware design
>>> > guide specify the recommended upper voltage limit for the GPU or the
>>> > NPU.  Though, their upper absolute ratings are the same, as already
>>> > described above.
>>> 
>>> Uh-oh, this rabbit hole goes much deeper than expected.  After a 
>>> quick
>>> check, I see there are also RK3399-based boards/devices that specify
>>> the minimum and maximum values for their GPU regulators far outside
>>> the recommended operating conditions of the RK3399's GPU.
>>> 
>>> Perhaps the scope of the upcoming patches should be expanded to cover
>>> other boards as well, not just those based on the RK356x.
>>> 
>>> >>> > While true, setting it to the lowest the regulator can do in the
>>> >>> > original
>>> >>> > fix patch, might've been a bit much and a saner value might be better.
>>> >>>
>>> >>> Agreed, but the value was selected according to what the other
>>> >>> RK3566-based
>>> >>> boards use, to establish some kind of consistency.  Now, there's a
>>> >>> good
>>> >>> chance for the second pass, so to speak, which should establish
>>> >>> another
>>> >>> different state, but also consistent. :)
>>> >>>
>>> >>> >> This would ensure consistency, but I'd like to know are all those
>>> >>> >> resulting
>>> >>> >> patches going to be accepted before starting to prepare them?  There
>>> >>> >> will
>>> >>> >> be a whole bunch of small patches.
>>> >>> >
>>> >>> > Hmm, though I'd say that would be one patch per soc?
>>> >>> >
>>> >>> > I.e. you're setting the min-voltage of _one_ regulator used
>>> >>> > on each board to a value to support the defined OPPs.
>>> >>> >
>>> >>> > I.e. in my mind you'd end up with:
>>> >>> >       arm64: dts: rockchip: set better min voltage for vdd_gpu on rk356x
>>> >>> > boards
>>> >>> >
>>> >>> > And setting the lower voltage to reach that lower OPP on all affected
>>> >>> > rk356x boards.
>>> >>>
>>> >>> Yes, the same thoughts have already crossed my mind, but I thought
>>> >>> we'd
>>> >>> like those patches to also include Fixes tags, so they also get
>>> >>> propagated
>>> >>> into the long-term kernel versions?  In that case, we'd need one
>>> >>> patch
>>> >>> per
>>> >>> board, to have a clear relation to the commits referenced in the
>>> >>> Fixes
>>> >>> tags.
>>> >>>
>>> >>> OTOH, if we don't want the patches to be propagated into the
>>> >>> long-term
>>> >>> kernel
>>> >>> versions, then having one patch per SoC would be perfectly fine.
>>> >>
>>> >> It's really up to Heiko, but personally I don't think it's that
>>> >> important
>>> >> to have them backported. These would be correctness patches, but don't
>>> >> really affect functionality.
>>> >
>>> > On second thought, I also think that it might be better not to have
>>> > these changes propagated into the long-term kernel versions.  That
>>> > would keep the amount of backported changes to the bare minimum, i.e.
>>> > containing just the really important fixes, while these changes are
>>> > more on the correctness side.  Maybe together with providing a bit
>>> > of additional safety.
>> 
>> hehe, up to you I guess :-) .
>> 
>> At least we tied down the how (one patch per soc or so) and not meant
>> to be backported because more of the correctnes side. So yes I agree 
>> with
>> the arguments for changing the constraints.
> 
> Thanks. :)  I'll move forward with per-SoC patches, and I'll see
> how far it will all go when it comes to correcting the GPU voltage
> contraints for different SoCs.  Maybe some other voltage contraints
> in need of correction will pop up while checking all that.
> 
> When I think even more about it, perhaps making the descriptions
> of regulator-min-microvolt and regulator-max-microvolt a bit more
> descriptive in the bindings would make sense, which I'd be willing
> to prepare patches for.  Perhaps Krzysztof could provide an insight
> into how much sense would that make.

