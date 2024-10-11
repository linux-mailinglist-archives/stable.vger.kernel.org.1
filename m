Return-Path: <stable+bounces-83433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D999A0D8
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 12:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B951285033
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94938210182;
	Fri, 11 Oct 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="S7pgaULO"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C721018F;
	Fri, 11 Oct 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641388; cv=none; b=obwVzfbBSFJC/YNuK0YOHcIvj4/jyUN8X0ga7G9YXf5+JimDao+jtiHf6RCOMInVFlx0q5RpZ/exx8m+uLK6zzkuwUjmgdh8sIMtUAW8ZT1gQKOLrXDiuz4LPtkgViVR/nuSnH8/CooUnloh3gETtU5eVnrZ/fju56dIg08SJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641388; c=relaxed/simple;
	bh=GgdE/KRxmxGku8Db7OjN9ZtzylbPhfQW3JleUzMzBc4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TmZpIvuZSSAne0bGg3jdZpUbs2rymKBOLZMalo3oulnQaf5y/6J6YpS1ivU4vRqk6PT6DC4qN6ICVS091u+6wBPEPxj8osr4h0sh6lRFTAiyjplCIL2Uc6QDxm4lk4JZVKwtKBgAu6R0I50Po8hHAWPWRnevRMO8IGb4pH3va/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=S7pgaULO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728641382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWU2UpgBCfCJMwy9JjQ8I9dxjTB9H0Tqnkcy1NXZygY=;
	b=S7pgaULOwew5O7Z1ueadeyzswZQWrLWWkRRDEkhEwTIQHeMprTJlKAGBFoCfkfcX6u9lIj
	C3zTQhoMe8J3FdXUD0JNHUR26HT6sz4NFsaugTLY5tgvmL8q54BFN2eAwbicfs5foExbum
	m++VmXszaid2ZWBeFnWjJGrC0Ugw1a75gOLfgtUTLSKOr8cSX8O4f7gpdlJxqB8CWS6p7o
	2qePQKKYAMgRydSr/MUODMBDM8FTdPIh0RsZIFZwbPZKLAK7AFXyD6rLEfgzSPmykFBZft
	+/tXVT+5zHfesAnF84LdLiBhr+5k9DoE1AD/0eWgoWoX6R4oyzQUX3/S58oNYQ==
Date: Fri, 11 Oct 2024 12:09:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Prevent thermal runaways in RK3308
 SoC dtsi
In-Reply-To: <1831993.TLkxdtWsSY@diego>
References: <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
 <86ff39fe-cc88-4cf4-a1ad-6398a74ceb11@kwiboo.se>
 <01e42e08965e58a337b9b531c10446fd@manjaro.org> <1831993.TLkxdtWsSY@diego>
Message-ID: <7a189327fc87e594f4c7b8e5d745ebeb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-10-11 11:56, Heiko Stübner wrote:
> Am Freitag, 11. Oktober 2024, 11:04:38 CEST schrieb Dragan Simic:
>> On 2024-10-11 10:52, Jonas Karlman wrote:
>> > On 2024-10-10 12:19, Dragan Simic wrote:
>> >> Until the TSADC, thermal zones, thermal trips and cooling maps are
>> >> defined
>> >> in the RK3308 SoC dtsi, none of the CPU OPPs except the slowest one
>> >> may be
>> >> enabled under any circumstances.  Allowing the DVFS to scale the CPU
>> >> cores
>> >> up without even just the critical CPU thermal trip in place can rather
>> >> easily
>> >> result in thermal runaways and damaged SoCs, which is bad.
>> >>
>> >> Thus, leave only the lowest available CPU OPP enabled for now.
>> >
>> > This feel like a very aggressive limitation, to only allow the
>> > opp-suspend rate, that is not even used under normal load.
>> >
>> > I let my Rock Pi S board with a RK3308B variant run "stress -c 8" for
>> > around 10 hours and the reported temp only reach around 50-55 deg c,
>> > ambient temp around 20 deg c and board laying flat on a table without
>> > any enclosure or heat sink.
>> >
>> > This was running with performance as scaling_governor and cpu running
>> > the 1008000 opp.
>> 
>> Thanks for testing all that!  That's very low CPU temperature under
>> stress testing indeed.  Maybe the cooling gets worse and the CPU
>> temperature goes higher if the board is installed into some small
>> enclosure with no natural or forced airflow?
>> 
>> > Most RK3308 variants datasheets list 1.3 GHz as max rate for CPU,
>> > the K-variant lists 1.2 GHz, and the -S-variants seem to have both
>> > reduced voltage and max rate.
>> >
>> > The OPPs for this SoC already limits max rate to 1 GHz and is more than
>> > likely good enough to not reach the max temperature of 115-125 deg c as
>> > rated in datasheets and vendor DTs.
>> >
>> > Adding the tsadc and trips (same/similar as px30) will probably allow
>> > us
>> > to add/use the "missing" 1.2 and 1.3 GHz OPPs.
>> 
>> With these insights, I agree that the patch might have been a bit
>> too extreme, but it also promotes good practices when it comes to
>> upstreaming.  The general rule is not to add CPU or GPU OPPs with
>> no proper thermal configuration already in place.
>> 
>> The patch has already been merged, and as I already noted, [1] I'll
>> try to implement, test and submit the proper thermal configuration
>> ASAP.  It's up Heiko to decide whether to drop this patch or not.
> 
> Hmm, interesting question ;-) .
> 
> Dropping the patch is of course still possible and so far we haven't
> actually seen anyone with real-world problems.
> 
> And with Jonas' stress test, it does look like nobody will in the
> (hopefully short) time till we have thermal management.
> 
> @Dragan, if you're in favor of that I'll drop the patch.

I hope I'll have the proper RK3308 thermal configuration available
for the 6.14 merge window, also with higher OPPs in place.  Knowing
that we've seemingly had no RK3308 SoCs releasing the magic smoke
(yet? :), I think we can keep the status quo for a couple of months
or so, so let's drop this patch.

Thanks again to Jonas for all the stress testing!

>> [1]
>> https://lore.kernel.org/linux-rockchip/df92710498f66bcb4580cb2cd1573fb2@manjaro.org/
>> 
>> >> Fixes: 6913c45239fd ("arm64: dts: rockchip: Add core dts for RK3308
>> >> SOC")
>> >> Cc: stable@vger.kernel.org
>> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> >> ---
>> >>  arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> >> b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> >> index 31c25de2d689..a7698e1f6b9e 100644
>> >> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> >> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> >> @@ -120,16 +120,19 @@ opp-600000000 {
>> >>  			opp-hz = /bits/ 64 <600000000>;
>> >>  			opp-microvolt = <950000 950000 1340000>;
>> >>  			clock-latency-ns = <40000>;
>> >> +			status = "disabled";
>> >>  		};
>> >>  		opp-816000000 {
>> >>  			opp-hz = /bits/ 64 <816000000>;
>> >>  			opp-microvolt = <1025000 1025000 1340000>;
>> >>  			clock-latency-ns = <40000>;
>> >> +			status = "disabled";
>> >>  		};
>> >>  		opp-1008000000 {
>> >>  			opp-hz = /bits/ 64 <1008000000>;
>> >>  			opp-microvolt = <1125000 1125000 1340000>;
>> >>  			clock-latency-ns = <40000>;
>> >> +			status = "disabled";
>> >>  		};
>> >>  	};
>> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

