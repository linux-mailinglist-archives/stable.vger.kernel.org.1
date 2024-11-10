Return-Path: <stable+bounces-92053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD29C3497
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 21:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007471C20EF5
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAD1146000;
	Sun, 10 Nov 2024 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fzQRJyNl"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71291386C9;
	Sun, 10 Nov 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731271639; cv=none; b=TfxPCO3/6tUv6CNRnC797t/sgLQ59kwJzneqWY/xiVC97Lvh3Ls7meZmVR9EZRMYTnQuvU8NRZ6reGb6CW+nOyNFOOm25PvlPxt7lesp3EnU1iQNAk44QnoFxr1i0VrUOc0cpwWPBYY5CFNqkjzXKuEt7fAM0q5kZRDpGQs9VZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731271639; c=relaxed/simple;
	bh=zc8NKS13iX4iibiy8m8tItY5i99PREFHvVcdkSImP04=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EQ7K3yIuBP7LzBKJM7Ix08rzsS8fUHLEBgZVu7v3PD2mGKd412CF+9gxDSgvta3M8O+Lf9kNgyRVnWZPJgvpXYf+GP35JdgttVXQ46l4FZLBRAmohODC8nQjfBkSd1S7zMC4jdh1yX3+k3vCaVqo1/+qeHxtojag1Iv+j6ZAN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fzQRJyNl; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731271635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fE5VOA6KuTjnNYq44e0OK4y8UXNT3ZzXaRBBD23Kw9o=;
	b=fzQRJyNl79XOFtkcXecX9QesKQ+w0dR5wqTkVeTCqmTSlhjQq2YgVauWWn0PmmCpEo53Dx
	NYurR7lpapDRp4/2pTqqs0rvP7lJS4tcCpJuPInGhJCKhunal76raAuh52KK3+EvApvsgp
	0OJCdUVAIYpO5uhjMxbpXMeNaduy7xSqemW6gaKwR/xjpeevX7MrpRlYCDgbPqqqmrCniz
	J1mjfbyA0EK8x4jxEEjk4O6PhOKYEIZk+1+PMZ0UYIU9pc/y94DDInoJxJWQqet8UQSph3
	qx04O0kgmXu2gcig+EUGKo6Of+ig/g5KG7hssiSIpYKDs23emvPB4BnYMCKQmA==
Date: Sun, 10 Nov 2024 21:47:15 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix vdd_gpu voltage constraints on
 PinePhone Pro
In-Reply-To: <4386271.ejJDZkT8p0@diego>
References: <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
 <4386271.ejJDZkT8p0@diego>
Message-ID: <fb3700f2d67c7f062c66cb8eb0f59b17@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-11-10 21:08, Heiko Stübner wrote:
> Am Sonntag, 10. November 2024, 19:44:31 CET schrieb Dragan Simic:
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
>> 
>> This also eliminates the following error messages from the kernel log:
>> 
>>   core: _opp_supported_by_regulators: OPP minuV: 1100000 maxuV: 
>> 1150000, not supported by regulator
>>   panfrost ff9a0000.gpu: _opp_add: OPP not supported by regulators 
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
> 
> With the Pinephone Pro using some sort of special-rk3399, how much of
> "the soc variant cannot use the highest gpu opp" is in there, and just 
> the
> original implementation is wrong?

Good question, I already asked it myself.  I'm unaware of any kind of
GPU-OPP-related restrictions when it comes to the PinePhone-Pro-specific
RK3399S.  Furthermore, "the word on the street" is that the RK3399S can
work perfectly fine even at the couple of "full-fat" RK3399 CPU OPPs
that are not defined for the RK3399S, and the only result would be the
expected higher power consumption and a bit more heat generated.

This just reaffirms that no known GPU OPP restrictions exist.  Even
if they existed, enforcing them _primarily_ through the constraints of
the associated voltage regulator would be the wrong approach.  Instead,
the restrictions should be defined primarily through the per-SoC-variant
GPU OPPs, which are, to my best knowledge, not known to be existing for
the RK3399S SoC variant.

> Did you run this on actual hardware?

I rushed a bit to submit the patch before being able to test in on the
actual hardware, but there's already one person willing to test the 
patch
on their PinePhone Pro and provide their Tested-By.  I see no reasons 
why
it shouldn't work as expected, as explained above, which is why I 
decided
it's safe to submit the patch before detailed testing.

I'm very careful when it comes to changes like this one, but I'm quite
confident there should be no issues, just a nice performance boost. :)
I also checked and compared the schematics of the PinePhone Pro and
a couple of other Pine64 RK3399-based boards and devices, to make sure
there are no differences in the GPU regulators that would make the
PinePhone Pro an exception.  I saw no such differences.

>> Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for 
>> Pine64 PinePhone Pro")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> index 1a44582a49fb..956d64f5b271 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> @@ -410,8 +410,8 @@ vdd_gpu: regulator@41 {
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&vsel2_pin>;
>>  		regulator-name = "vdd_gpu";
>> -		regulator-min-microvolt = <875000>;
>> -		regulator-max-microvolt = <975000>;
>> +		regulator-min-microvolt = <712500>;
>> +		regulator-max-microvolt = <1500000>;
>>  		regulator-ramp-delay = <1000>;
>>  		regulator-always-on;
>>  		regulator-boot-on;

