Return-Path: <stable+bounces-125828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4856A6CEA5
	for <lists+stable@lfdr.de>; Sun, 23 Mar 2025 11:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5296188EB62
	for <lists+stable@lfdr.de>; Sun, 23 Mar 2025 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667A1F8671;
	Sun, 23 Mar 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ZnEEewob"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238315E90;
	Sun, 23 Mar 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725209; cv=none; b=uDIEKshYU+AQ3ywV1DVEERBqcaPPv7u/LnWJkhEOOTrCiLM9VqLlH5xaLM4Jb1+/TLLphWgb1gTFBwCnKBxcA+MYBVv5s1Jl/gBXGlCTaGVV762jEFvTh5LqRTeHfFpsG1r1luS2nS+KNhf5NDa9N/Hv/JPZWtSl4/HqyqAREtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725209; c=relaxed/simple;
	bh=Qn3UWCySJthfP1r8oY7/3TqCuKi/gSeRu7h50ye3fws=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DYYPo7XfhXfsSZIRdzIa6kroXhjxz/mh2VM2fitk7VD7vsRxCso2S9cY1Zknifp4tqi0NHI2V2r94MIWy8cyVKnriBMiGH14SS9ExTeXyEZPdIHXYfo869DvoNVHq+9oRgCUnP2oqRiVm1dbD2g5d3neiYPlO622Y4T7lNNrvGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ZnEEewob; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1742725198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ9Z4yuasD0XhUC5V1EI5H6DAsn8b15J7B+WTK6PDjY=;
	b=ZnEEewobcvlcLS5mnnk3N2I+xAVDbl4lYDRNHApDrtd/1+UadG44uWmvJULjxEcas9nc5x
	uDemjDGqYTaDLI0fLHp9TX5deecvBcD2bZWk3vgLE6GffN2VtF5iTAfOSjpDa7MBje/xcp
	bB3IP1WEOVBQbgEnDysEls0oLSXegj9xq0iG5YZxD5UQKUFPRGBZCjN2+Sbl7EToTJjzLd
	9ZRvoveXvlgI+68O4DN+UarVE8LCu+nUAnmhAll9RFhDv+90p7t7n86TFh3gqH05kzOP9p
	9GII2IFMrG7V6Bhcc1Z6+omB27RrrOV5X9yMqgSguckbBo/EUgLSlTrNYaz3vQ==
Date: Sun, 23 Mar 2025 11:19:56 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org, Alexey Charkov
 <alchark@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Remove overdrive-mode OPPs from
 RK3588J SoC dtsi
In-Reply-To: <71b7c81b-6a4e-442b-a661-04d63639962a@cherry.de>
References: <f929da061de35925ea591c969f985430e23c4a7e.1742526811.git.dsimic@manjaro.org>
 <71b7c81b-6a4e-442b-a661-04d63639962a@cherry.de>
Message-ID: <960c038ad9f7b83fe14d0ded388b42f7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Quentin,

Thanks for your comments!  Please see some responses below.

On 2025-03-21 10:53, Quentin Schulz wrote:
> On 3/21/25 4:28 AM, Dragan Simic wrote:
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
> 
> RK3588 is rated for 0-80°C, RK3588J for -40-85°C, c.f. Recommended
> Operating Conditions, Table 3-2, Ambient Operating Temperature.

Indeed, which is why I specifically wrote "specifying the same upper
limit", because having a lower negative temperature limit could hardly
put the RK3588J in danger of overheating or running hotter. :)

>> specified much lower for the RK3588J variant. [1][2]
>> 
>> To be on the safe side and to ensure maximum longevity of the RK3588J 
>> SoCs,
>> only the CPU and GPU OPPs that are declared by the vendor to be always 
>> safe
>> for this SoC variant may be provided.  As explained by the vendor [3] 
>> and
>> according to its datasheet, [2] the RK3588J variant can actually run 
>> safely
>> at higher CPU and GPU OPPs as well, but only when not enjoying the 
>> assumed
>> extended temperature range that the RK3588J, as an SoC variant 
>> targeted
> 
> "only when not enjoying the assumed extended temperature range" is
> extrapolated by me/us and not confirmed by Rockchip themselves. I've
> asked for a statement on what "industrial environment" they specify in
> the Normal Mode explanation means since it's the only time they use
> the term. I've yet to receive an answer. The only thing Rockchip in
> their datasheet is that the overdrive mode will shorten lifetime when
> used for a long time, especially in high temperature conditions. It's
> not clear whether we can use the overdrive mode even within the RK3588
> typical range of operation.

True.  I'll see to rephrase the patch description a bit in the v2,
to avoid this kind of speculation.  I mean, perhaps the speculation
is right, but it hasn't been confirmed officially by Rockchip.

>> specifically at industrial applications, is made (or binned) for.
>> 
>> Thus, only the CPU and GPU OPPs that are specified by the vendor to be 
>> safe
>> throughout the entire RK3588J's extended temperature range may be 
>> provided,
>> while anyone who actually can ensure that their RK3588J-based board is
>> never going to run within the extended temperature range, may probably
>> safely apply a DT overlay that adds the higher CPU and GPU OPPs.  As 
>> we
> 
> Wouldn't say "safely" here, Rockchip still says that running overdrive
> mode for a long time may shorten lifetime... that followed by
> "especially in high temperature condition" doesn't mean that operating
> the RK3588J within the RK3588 typical range is safe to do.

Also true, and I'll also try to address that in the v2.

>> obviously can't know what will be the runtime temperature conditions 
>> for
>> a particular board, we may provide only the always-safe OPPs.
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
>> normal mode, the lifetime is reasonably guaranteed", while "overdrive 
>> mode
>> brings higher frequency, and the voltage will increase accordingly;  
>> under
>> the overdrive mode for a long time, the chipset may shorten the 
>> lifetime,
>> especially in high temperature condition".
>> 
>> To sum up the RK3588J datasheet [2] and the vendor-provided DTs, 
>> [4][5]
>> the maximum allowed CPU core and GPU frequencies are as follows:
>> 
>>     IP core    | Normal mode | Overdrive mode
>>    ------------+-------------+----------------
>>     Cortex-A55 |   1,296 MHz |      1,704 MHz
>>     Cortex-A76 |   1,608 MHz |      2,016 MHz
>>     GPU        |     700 MHz |        850 MHz
>> 
> 
> The NPU too is impacted by this, so maybe list it anyway here? Even if
> we don't support it right now and don't have OPPs for it.

Agreed, will add in the v2.  Having all that information in a single
place can only be helpful.

>> Unfortunately, when it comes to the actual voltages for the RK3588J 
>> CPU and
>> GPU OPPs, there's a discrepancy between the RK3588J datasheet [2] and 
>> the
>> downstream kernel code. [4][5]  The RK3588J datasheet states that "the 
>> max.
>> working voltage of CPU/GPU/NPU is 0.75 V under the normal mode", while 
>> the
>> downstream kernel code actually allows voltage ranges that go up to 
>> 0.95 V,
>> which is still within the voltage range allowed by the datasheet.  
>> However,
>> the RK3588J datasheet also tells us to "strictly refer to the software
>> configuration of SDK and the hardware reference design", so let's 
>> embrace
>> the voltage ranges provided by the downstream kernel code, which also
>> prevents the undesirable theoretical outcome of ending up with no 
>> usable
>> OPPs on a particular board, as a result of the board's voltage 
>> regulator(s)
>> being unable to deliver the exact voltages, for whatever reason.
>> 
>> The above-described voltage ranges for the RK3588J CPU OPPs remain 
>> taken
>> from the downstream kernel code [4][5] by picking the highest, 
>> worst-bin
>> values, which ensure that all RK3588J bins will work reliably.  Yes, 
>> with
>> some power inevitably wasted as unnecessarily generated heat, but the
>> reliability is paramount, together with the longevity.  This 
>> deficiency
>> may be revisited separately at some point in the future.
>> 
>> The provided RK3588J CPU OPPs follow the slightly debatable "provide 
>> only
>> the highest-frequency OPP from the same-voltage group" approach that's 
>> been
> 
> Interesting that we went for a different strategy for the GPU OPPs :)

Good point, and I'm fully aware of that. :)  Actually, I'm rather
sure that omitting the additional CPU OPPs does no good to us, but
I didn't want to argue about that when they were dropped originally,
before I can have some hard numbers to prove it in a repeatable way.

>> established earlier, [6] as a result of the "same-voltage, 
>> lower-frequency"
>> OPPs being considered inefficient from the IPA governor's standpoint, 
>> which
>> may also be revisited separately at some point in the future.
>> 
>> [1] 
>> https://wiki.friendlyelec.com/wiki/images/e/ee/Rockchip_RK3588_Datasheet_V1.6-20231016.pdf
>> [2] 
>> https://wmsc.lcsc.com/wmsc/upload/file/pdf/v2/lcsc/2403201054_Rockchip-RK3588J_C22364189.pdf
>> [3] 
>> https://lore.kernel.org/linux-rockchip/e55125ed-64fb-455e-b1e4-cebe2cf006e4@cherry.de/T/#u
>> [4] 
>> https://raw.githubusercontent.com/rockchip-linux/kernel/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> [5] 
>> https://raw.githubusercontent.com/rockchip-linux/kernel/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> [6] 
>> https://lore.kernel.org/all/20240229-rk-dts-additions-v3-5-6afe8473a631@gmail.com/
>> 
>> Fixes: 667885a68658 ("arm64: dts: rockchip: Add OPP data for CPU cores 
>> on RK3588j")
>> Fixes: a7b2070505a2 ("arm64: dts: rockchip: Split GPU OPPs of RK3588 
>> and RK3588j")
>> Cc: stable@vger.kernel.org
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Alexey Charkov <alchark@gmail.com>
>> Helped-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Reported-by/Suggested-by?
> 
> I don't see Helped-by in
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> 
> I see 2496b2aaacf137250f4ca449f465e2cadaabb0e8 got the Helped-by
> replaced by a Suggested-by for example, but I see other patches with
> Helped-by... if that is a standard trailer for kernel patches, then
> maybe we should add it to that doc?

Actually, I already tried to get the Helped-by tag added to the
kernel documentation, by submitting a small patch series. [*]
Unfortunately, it got rejected. :/

However, Heiko accepts Helped-by tags and nobody higher up the
tree seems to complain, so we should be fine. :)  It isn't the
case with all maintainers, though.

[*] 
https://lore.kernel.org/all/cover.1730874296.git.dsimic@manjaro.org/T/#u

>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3588j.dtsi | 53 
>> ++++++++---------------
>>   1 file changed, 17 insertions(+), 36 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> index bce72bac4503..3045cb3bd68c 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> @@ -11,74 +11,59 @@ cluster0_opp_table: opp-table-cluster0 {
>>   		compatible = "operating-points-v2";
>>   		opp-shared;
>>   -		opp-1416000000 {
>> -			opp-hz = /bits/ 64 <1416000000>;
>> +		opp-1200000000 {
>> +			opp-hz = /bits/ 64 <1200000000>;
>>   			opp-microvolt = <750000 750000 950000>;
>>   			clock-latency-ns = <40000>;
>>   			opp-suspend;
>>   		};
>> -		opp-1608000000 {
>> -			opp-hz = /bits/ 64 <1608000000>;
>> -			opp-microvolt = <887500 887500 950000>;
>> -			clock-latency-ns = <40000>;
>> -		};
>> -		opp-1704000000 {
>> -			opp-hz = /bits/ 64 <1704000000>;
>> -			opp-microvolt = <937500 937500 950000>;
>> +		opp-1296000000 {
>> +			opp-hz = /bits/ 64 <1296000000>;
>> +			opp-microvolt = <775000 775000 950000>;
> 
> Got tricked by this one.
> 
> In the Rockchip vendor kernel, the opp-microvolt is 750000 750000
> 950000, so the same as CPU OPP 1.2GHz. However, the opp-microvolt-L1
> and L0 are higher than that. Only a couple of the OPPs in vendor
> kernel actually have opp-microvolt-L* higher than opp-microvolt, that
> is a noteworthy oddity for anyone reviewing this patch :)
> 
> Anyway, that is correct, we take the highest voltage among all defined
> opp-microvolt* properties.

Indeed, and I also almost got tricked by the same OPP. :)

> I only have comments on the commit log, the diff is fine so:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks once again for your detailed review! :)

