Return-Path: <stable+bounces-47813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF278D6C8D
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 00:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69286B216AC
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 22:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648081AA5;
	Fri, 31 May 2024 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JVHMu99R"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C67F7CA;
	Fri, 31 May 2024 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195298; cv=none; b=QiaaLVdzZS/tg6U15QtBuKQ5Wi8phf3UHEZzairJmTVO2RDYfzb0wfUiMAJZgJimBGy5eJ0zjTc9Gd2O8mBT17Gh9TvAK+gqIiu+FGAP+F8ugKDd7sxAMYQl16mu4F2HPdb969bBYqUkgZr5OTrSpR/5IBZz7KODUEVEP2MY7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195298; c=relaxed/simple;
	bh=N7Pf6KBAzmgihzZBNQ1CI4c8LW381Dk5es7kBT7n4Gg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aP6sCKd/6yU42fwnzDQ1xPyTB6r+V110lzenfCXRHQqyai4FfH5Pp5H5Oeq6S4/uGtBB8QvzmchcOnZwCMBNMkW3ZxgVmNBkv/BdGn/RvgPtT9PmbKWsc1W8MXL5IODAUdEmTssv657rWHp7OwAKLSbneJQ5VptDSRcnyrXTmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JVHMu99R; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717195293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNBMrZICb0wQxUkjNFmtIiPriop70XcjlnulR8nloS8=;
	b=JVHMu99RoO1MT9X1bxJXfce1oVrxoIfGboFsOiNNYsbGJSC35fCmip/RkAkBd1wAfh8nzX
	0XM1lzo9Ir/lFiD4vvDPG7Q19ymMTPLkbKtpmjwZG6aQE1XXAppO00Hwy9HdZh4MD99WKF
	M3QM9VI58HHixZSfF91wFxXfSJ3joJ1R92puaoKSmppWd7fnhzduQb4YvdwKvPPCSR8rZj
	dMFfx9M1N3+Y9ZWW/M/PSPdh7kYxWNCEUc1sGpF9qvuTrxEOcXrnOg/B4ESwQNuhKSjKYp
	kjGAsBghKDDvM+CM2BQBJra4YmZjSsBjgnQS5RxdSIw2DNV9Rot2flicBCm/7w==
Date: Sat, 01 Jun 2024 00:41:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: wens@kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Diederik de Haas
 <didi.debian@cknow.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage
 on Quartz64 Model B
In-Reply-To: <1994616.CrzyxZ31qj@diego>
References: <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
 <CAGb2v66DPvvRcq+98vF2mCF8URW_qys1+B_FM9kcm6ppuPvyeg@mail.gmail.com>
 <20cf041dcd6f752174bf29d2a53c61b3@manjaro.org> <1994616.CrzyxZ31qj@diego>
Message-ID: <99ea0e0053d3ada3325bdfaec7a937f0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-05-31 20:40, Heiko Stübner wrote:
> Am Freitag, 31. Mai 2024, 00:48:45 CEST schrieb Dragan Simic:
>> On 2024-05-29 18:27, Chen-Yu Tsai wrote:
>> > On Tue, May 21, 2024 at 1:20 AM Dragan Simic <dsimic@manjaro.org>
>> > wrote:
>> >>
>> >> Correct the specified regulator-min-microvolt value for the buck
>> >> DCDC_REG2
>> >> regulator, which is part of the Rockchip RK809 PMIC, in the Pine64
>> >> Quartz64
>> >> Model B board dts.  According to the RK809 datasheet, version 1.01,
>> >> this
>> >> regulator is capable of producing voltages as low as 0.5 V on its
>> >> output,
>> >> instead of going down to 0.9 V only, which is additionally confirmed
>> >> by the
>> >> regulator-min-microvolt values found in the board dts files for the
>> >> other
>> >> supported boards that use the same RK809 PMIC.
>> >>
>> >> This allows the DVFS to clock the GPU on the Quartz64 Model B below
>> >> 700 MHz,
>> >> all the way down to 200 MHz, which saves some power and reduces the
>> >> amount of
>> >> generated heat a bit, improving the thermal headroom and possibly
>> >> improving
>> >> the bursty CPU and GPU performance on this board.
>> >>
>> >> This also eliminates the following warnings in the kernel log:
>> >>
>> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,
>> >> not supported by regulator
>> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
>> >> (200000000)
>> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,
>> >> not supported by regulator
>> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
>> >> (300000000)
>> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,
>> >> not supported by regulator
>> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
>> >> (400000000)
>> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,
>> >> not supported by regulator
>> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
>> >> (600000000)
>> >>
>> >> Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B
>> >> device tree")
>> >> Cc: stable@vger.kernel.org
>> >> Reported-By: Diederik de Haas <didi.debian@cknow.org>
>> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> >> ---
>> >>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>> >> b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>> >> index 26322a358d91..b908ce006c26 100644
>> >> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>> >> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>> >> @@ -289,7 +289,7 @@ vdd_gpu: DCDC_REG2 {
>> >>                                 regulator-name = "vdd_gpu";
>> >>                                 regulator-always-on;
>> >>                                 regulator-boot-on;
>> >> -                               regulator-min-microvolt = <900000>;
>> >> +                               regulator-min-microvolt = <500000>;
>> >
>> > The constraints here are supposed to be the constraints of the
>> > consumer,
>> > not the provider. The latter is already known by the implementation.
>> >
>> > So if the GPU can go down to 0.825V or 0.81V even (based on the
>> > datasheet),
>> > this should say the corresponding value. Surely the GPU can't go down
>> > to
>> > 0.5V?
>> >
>> > Can you send another fix for it?
>> 
>> I can confirm that the voltage of the power supply of GPU found inside
>> the RK3566 can be as low as 0.81 V, according to the datasheet, or as
>> low as 0.825 V, according to the GPU OPPs found in rk356x.dtsi.
>> 
>> If we want the regulator-min-microvolt parameter to reflect the
>> contraint
>> of the GPU as the consumer, which I agree with, we should do that for
>> other
>> RK3566-based boards as well, and almost surely for the boards based on
>> the
>> RK3568, too.
> 
> Hmm, I'm not so sure about that.
> 
> The binding does define:
> 	regulator-min-microvolt:
> 	    description: smallest voltage consumers may set
> 
> This does not seem to describe it as a constraint solely of the 
> consumer.
> At least the wording sounds way more flexible there.
> 
> Also any regulator _could_ have multiple consumers, whose value would
> it need then.

The way I see it, the regulator-min-microvolt and 
regulator-max-microvolt
parameters should be configured in a way that protects the consumer(s)
of the particular voltage regulator against undervoltage and overvoltage
conditions, which may be useful in some corner cases.

If there are multiple consumers, which in this case may actually happen
(IIRC, some boards use the same regulator for the GPU and NPU portions
of the SoC), the situation becomes far from ideal, because the consumers
might have different voltage requirements, but that's pretty much an
unavoidable compromise.

> While true, setting it to the lowest the regulator can do in the 
> original
> fix patch, might've been a bit much and a saner value might be better.

Agreed, but the value was selected according to what the other 
RK3566-based
boards use, to establish some kind of consistency.  Now, there's a good
chance for the second pass, so to speak, which should establish another
different state, but also consistent. :)

>> This would ensure consistency, but I'd like to know are all those
>> resulting
>> patches going to be accepted before starting to prepare them?  There
>> will
>> be a whole bunch of small patches.
> 
> Hmm, though I'd say that would be one patch per soc?
> 
> I.e. you're setting the min-voltage of _one_ regulator used
> on each board to a value to support the defined OPPs.
> 
> I.e. in my mind you'd end up with:
> 	arm64: dts: rockchip: set better min voltage for vdd_gpu on rk356x 
> boards
> 
> And setting the lower voltage to reach that lower OPP on all affected
> rk356x boards.

Yes, the same thoughts have already crossed my mind, but I thought we'd
like those patches to also include Fixes tags, so they also get 
propagated
into the long-term kernel versions?  In that case, we'd need one patch 
per
board, to have a clear relation to the commits referenced in the Fixes 
tags.

OTOH, if we don't want the patches to be propagated into the long-term 
kernel
versions, then having one patch per SoC would be perfectly fine.

