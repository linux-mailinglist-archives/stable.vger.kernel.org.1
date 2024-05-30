Return-Path: <stable+bounces-47750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A68D55C1
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 00:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4C228772B
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 22:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD6176AA7;
	Thu, 30 May 2024 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="P3OkpweB"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9F17545;
	Thu, 30 May 2024 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109337; cv=none; b=PUoLKhHvt6RL+EHSFmkRz6TatRYaaIlHRpSN43O6ADdalouYENDFnrUlxJu8qTgOQI+JsR40s3/H3GqaIpbyPnjGy5yxXJuv//gKwnweMK7Z6lvDROQMZKpB+GivoB8d3V0niAkspRFC0UQpN+esdERhI9V3kWtLttkoVj7R7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109337; c=relaxed/simple;
	bh=HiHXy0I7U8DlwKjgXTlVmHkKsdDBwRXVxNpeHcKqPMk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fpELeU/CTkbFaCQYT37SZbKHfF5cQOTwLElwAzoU1M1r715DkXlrpwJI2PrysoDg/XAsLMuftOI4gBTdqDTPb3s9bGFjOp1MReDDKvQwdv51Jnj7pW75NF9X6R1BrW3zXZOCrdqSdhkoz6bCi2lsoc0pUVCJnnGoTYQPdxe1Bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=P3OkpweB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717109326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4sL/egTIeR1PknoeeFf007Kuv86Tkpmgtv7gnFj3Hg=;
	b=P3OkpweBrC8m/LrCu9VrgJnpgFUdSVz/hgR9onAHwrwdUCVR3aR9WX2eqd7dLp9NkDS4DG
	zfmRA9yNPGTdiAZe+2IWEU32W5O5bl94y5pEX+Ed1h/8QcPjSVHsESGEGZAnwCqFOeMpTu
	V31t2e2IzYZhn/Yi1VP9TZzaxhtoRPqdeVclnYA0AEUU515VCIhMvUKED9AT8ksq/vatEi
	XSU5Q5fORj5ZSn3xPrTkIdXYNJGMA+1SBPG7b0cHdCICoVqPmChdvollvYF4miJrCvaqdh
	stFEgm8PrUUm0mtOSKB1vrJZvY2Z4fbrVOpe73xx/lzgBV6PRNyKbb6xDmx3lw==
Date: Fri, 31 May 2024 00:48:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: wens@kernel.org
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Diederik de Haas
 <didi.debian@cknow.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage
 on Quartz64 Model B
In-Reply-To: <CAGb2v66DPvvRcq+98vF2mCF8URW_qys1+B_FM9kcm6ppuPvyeg@mail.gmail.com>
References: <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
 <CAGb2v66DPvvRcq+98vF2mCF8URW_qys1+B_FM9kcm6ppuPvyeg@mail.gmail.com>
Message-ID: <20cf041dcd6f752174bf29d2a53c61b3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chen-Yu,

On 2024-05-29 18:27, Chen-Yu Tsai wrote:
> On Tue, May 21, 2024 at 1:20 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> 
>> Correct the specified regulator-min-microvolt value for the buck 
>> DCDC_REG2
>> regulator, which is part of the Rockchip RK809 PMIC, in the Pine64 
>> Quartz64
>> Model B board dts.  According to the RK809 datasheet, version 1.01, 
>> this
>> regulator is capable of producing voltages as low as 0.5 V on its 
>> output,
>> instead of going down to 0.9 V only, which is additionally confirmed 
>> by the
>> regulator-min-microvolt values found in the board dts files for the 
>> other
>> supported boards that use the same RK809 PMIC.
>> 
>> This allows the DVFS to clock the GPU on the Quartz64 Model B below 
>> 700 MHz,
>> all the way down to 200 MHz, which saves some power and reduces the 
>> amount of
>> generated heat a bit, improving the thermal headroom and possibly 
>> improving
>> the bursty CPU and GPU performance on this board.
>> 
>> This also eliminates the following warnings in the kernel log:
>> 
>>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, 
>> not supported by regulator
>>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators 
>> (200000000)
>>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, 
>> not supported by regulator
>>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators 
>> (300000000)
>>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, 
>> not supported by regulator
>>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators 
>> (400000000)
>>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, 
>> not supported by regulator
>>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators 
>> (600000000)
>> 
>> Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B 
>> device tree")
>> Cc: stable@vger.kernel.org
>> Reported-By: Diederik de Haas <didi.debian@cknow.org>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>> index 26322a358d91..b908ce006c26 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>> @@ -289,7 +289,7 @@ vdd_gpu: DCDC_REG2 {
>>                                 regulator-name = "vdd_gpu";
>>                                 regulator-always-on;
>>                                 regulator-boot-on;
>> -                               regulator-min-microvolt = <900000>;
>> +                               regulator-min-microvolt = <500000>;
> 
> The constraints here are supposed to be the constraints of the 
> consumer,
> not the provider. The latter is already known by the implementation.
> 
> So if the GPU can go down to 0.825V or 0.81V even (based on the 
> datasheet),
> this should say the corresponding value. Surely the GPU can't go down 
> to
> 0.5V?
> 
> Can you send another fix for it?

I can confirm that the voltage of the power supply of GPU found inside
the RK3566 can be as low as 0.81 V, according to the datasheet, or as
low as 0.825 V, according to the GPU OPPs found in rk356x.dtsi.

If we want the regulator-min-microvolt parameter to reflect the 
contraint
of the GPU as the consumer, which I agree with, we should do that for 
other
RK3566-based boards as well, and almost surely for the boards based on 
the
RK3568, too.

This would ensure consistency, but I'd like to know are all those 
resulting
patches going to be accepted before starting to prepare them?  There 
will
be a whole bunch of small patches.

>>                                 regulator-max-microvolt = <1350000>;
>>                                 regulator-ramp-delay = <6001>;

