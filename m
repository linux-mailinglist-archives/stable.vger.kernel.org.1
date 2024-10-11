Return-Path: <stable+bounces-83426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F622999FAD
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B931C23901
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19D420C469;
	Fri, 11 Oct 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="slSlc4ZM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB320C463
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637371; cv=none; b=LMIhsq4c9A4KQIoATRtS8CfP7PQ1uRJRJYhn9hlso7/XP4YxKb9loUdSHMLuTTYyETN0ufYM0aX4RAAaqfFwbTmkPJEqnpZjYmlt0e8+G3waH11n+Sv6RzjxlRBNa/fZkUKTMs37sIS8/p704aWwJI5oM3xIcoQC9MJEHP8ABtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637371; c=relaxed/simple;
	bh=19z3d0aqkHvJwN+Hk7S9ZrvGY/Nf3msL/Lxq7i9eJyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mD9o95HGhwea54KgtJOEFDcPCevKo/W8JrAfGIgBAHwCr7uyKeSw3nAILgTBcTGFj4tLM/Q/n5qBVNQE6wos03rPqeFpM4vMlBTU0wHQo+l08rX9CucWZvZ3TMzX1TAtxklKGZ7lcuNtHK7PmsfedBGOE6jw8eCWI86dsohQc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=slSlc4ZM; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1728637367;
 bh=PR7Qyd/O87/6PBrhIOrZqQvu9qgOrZhgZxSmRsZHQyM=;
 b=slSlc4ZMiqYtv6xtlf/LBI9QAFKlTKcLt4DfUrLKmERh+r+8WanJ04EN8W440RwtgXeN3++di
 aI9Id8C0Cl4tuOfR9MdTRs9naNavtHHmfURqpOtIS6JdmqLln6HcjFsKSQmJ2pEcgZavXSPQg4+
 +C75E8jZDHlecGNu4Up9EjuNl1UBr/ffcoJABJtCxUXO3c7Ig3h0YgdRKDPgONfaeXwqjOvUoY/
 /DDh2Cn/QfBjq7oqfsK5hmlztSQrnMQ6zCa9JTqoI79uyWIduqPyftsD7rn/btHiqGmU0KFWxcg
 RsplSa+h833d046ZVcNmq7OZTy245qifAT5i8W+Bagfg==
Message-ID: <86ff39fe-cc88-4cf4-a1ad-6398a74ceb11@kwiboo.se>
Date: Fri, 11 Oct 2024 10:52:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Prevent thermal runaways in RK3308
 SoC dtsi
To: Dragan Simic <dsimic@manjaro.org>, heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, stable@vger.kernel.org
References: <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6708e747ea3bbe7728966137

Hi Dragan,

On 2024-10-10 12:19, Dragan Simic wrote:
> Until the TSADC, thermal zones, thermal trips and cooling maps are defined
> in the RK3308 SoC dtsi, none of the CPU OPPs except the slowest one may be
> enabled under any circumstances.  Allowing the DVFS to scale the CPU cores
> up without even just the critical CPU thermal trip in place can rather easily
> result in thermal runaways and damaged SoCs, which is bad.
> 
> Thus, leave only the lowest available CPU OPP enabled for now.

This feel like a very aggressive limitation, to only allow the
opp-suspend rate, that is not even used under normal load.

I let my Rock Pi S board with a RK3308B variant run "stress -c 8" for
around 10 hours and the reported temp only reach around 50-55 deg c,
ambient temp around 20 deg c and board laying flat on a table without
any enclosure or heat sink.

This was running with performance as scaling_governor and cpu running
the 1008000 opp.

Most RK3308 variants datasheets list 1.3 GHz as max rate for CPU,
the K-variant lists 1.2 GHz, and the -S-variants seem to have both
reduced voltage and max rate.

The OPPs for this SoC already limits max rate to 1 GHz and is more than
likely good enough to not reach the max temperature of 115-125 deg c as
rated in datasheets and vendor DTs.

Adding the tsadc and trips (same/similar as px30) will probably allow us
to add/use the "missing" 1.2 and 1.3 GHz OPPs.

Regards,
Jonas

> 
> Fixes: 6913c45239fd ("arm64: dts: rockchip: Add core dts for RK3308 SOC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index 31c25de2d689..a7698e1f6b9e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -120,16 +120,19 @@ opp-600000000 {
>  			opp-hz = /bits/ 64 <600000000>;
>  			opp-microvolt = <950000 950000 1340000>;
>  			clock-latency-ns = <40000>;
> +			status = "disabled";
>  		};
>  		opp-816000000 {
>  			opp-hz = /bits/ 64 <816000000>;
>  			opp-microvolt = <1025000 1025000 1340000>;
>  			clock-latency-ns = <40000>;
> +			status = "disabled";
>  		};
>  		opp-1008000000 {
>  			opp-hz = /bits/ 64 <1008000000>;
>  			opp-microvolt = <1125000 1125000 1340000>;
>  			clock-latency-ns = <40000>;
> +			status = "disabled";
>  		};
>  	};
>  
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


