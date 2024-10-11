Return-Path: <stable+bounces-83431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2860C99A08D
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 11:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBBB1F25AE3
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF792101AA;
	Fri, 11 Oct 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rPrv72bI"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44B20FAAD;
	Fri, 11 Oct 2024 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640623; cv=none; b=AtlDcewtNzSpszyLrzqfv9kxftQl0d+F53VVrptGy8C2b0HfIiPF2eatON+JPwQlB2BChEIWbXAGdUtzrM2THbGzubKj5R9Ih23MWzEtXnzujJtO/dUn5OV6yeObB+rvvKiCnD3DHL0T0sheQ7aJp/G9SHdfmAWdSfW5xt0Hr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640623; c=relaxed/simple;
	bh=Gfcidkov4qGXk4naAdSzx+9W8NgThlSmTzasKaKXPlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7gNS+Ulvk75+zsIBKPxcEiQ6SQSz+A1XQ2/7NX5HeuXxHAlJ3Gafsi9e0/sciIEx3llf6aL/kW/V99OnStifsJtPT/XRdmrg/c+qoJda8WXHhS/ILMgVZ16j3vxy49enHyYyHkmjyRD6yjSh0lRvBhYTBfVVgdtuSTnrkkvVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rPrv72bI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ciLHEDlJFx/yBo6BbEQxX3v7o6dg6CNuVbDrI0ZaLuU=; b=rPrv72bIJD5WKQLxZ+70kkjCxd
	iDF4Uxk8GKYZ2jhuCMXiozqOn0qq689M9/EuMsegjYPiIULTPlJME8de90LGLPmS/PHZLdH5KzT1i
	XFMVNVkfB5/5kk7wOrUS0JmRBds+Nr4aON180g2F3wIYZucn2NkIOvitrICGCpY5p7o6285YGaTyi
	CIMb3NAW19VfqANZK6KCxHR0awuzYIXKcY6IUNTUEzAVN6K6CWYc1uXuvN4Z/KphI9wpKzaPYP/Cp
	brah8g5RCilRkadvT6RVZc8y39XRRYEtKB18QCyQlvQCqWPMsEkoqwpfZlh/xedpb3Obx3hcBNJXy
	Ql8Q+2nA==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1szCO7-0005n5-Om; Fri, 11 Oct 2024 11:56:47 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>, Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Prevent thermal runaways in RK3308 SoC dtsi
Date: Fri, 11 Oct 2024 11:56:46 +0200
Message-ID: <1831993.TLkxdtWsSY@diego>
In-Reply-To: <01e42e08965e58a337b9b531c10446fd@manjaro.org>
References:
 <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
 <86ff39fe-cc88-4cf4-a1ad-6398a74ceb11@kwiboo.se>
 <01e42e08965e58a337b9b531c10446fd@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 11. Oktober 2024, 11:04:38 CEST schrieb Dragan Simic:
> Hello Jonas,
> 
> On 2024-10-11 10:52, Jonas Karlman wrote:
> > On 2024-10-10 12:19, Dragan Simic wrote:
> >> Until the TSADC, thermal zones, thermal trips and cooling maps are 
> >> defined
> >> in the RK3308 SoC dtsi, none of the CPU OPPs except the slowest one 
> >> may be
> >> enabled under any circumstances.  Allowing the DVFS to scale the CPU 
> >> cores
> >> up without even just the critical CPU thermal trip in place can rather 
> >> easily
> >> result in thermal runaways and damaged SoCs, which is bad.
> >> 
> >> Thus, leave only the lowest available CPU OPP enabled for now.
> > 
> > This feel like a very aggressive limitation, to only allow the
> > opp-suspend rate, that is not even used under normal load.
> > 
> > I let my Rock Pi S board with a RK3308B variant run "stress -c 8" for
> > around 10 hours and the reported temp only reach around 50-55 deg c,
> > ambient temp around 20 deg c and board laying flat on a table without
> > any enclosure or heat sink.
> > 
> > This was running with performance as scaling_governor and cpu running
> > the 1008000 opp.
> 
> Thanks for testing all that!  That's very low CPU temperature under
> stress testing indeed.  Maybe the cooling gets worse and the CPU
> temperature goes higher if the board is installed into some small
> enclosure with no natural or forced airflow?
> 
> > Most RK3308 variants datasheets list 1.3 GHz as max rate for CPU,
> > the K-variant lists 1.2 GHz, and the -S-variants seem to have both
> > reduced voltage and max rate.
> > 
> > The OPPs for this SoC already limits max rate to 1 GHz and is more than
> > likely good enough to not reach the max temperature of 115-125 deg c as
> > rated in datasheets and vendor DTs.
> > 
> > Adding the tsadc and trips (same/similar as px30) will probably allow 
> > us
> > to add/use the "missing" 1.2 and 1.3 GHz OPPs.
> 
> With these insights, I agree that the patch might have been a bit
> too extreme, but it also promotes good practices when it comes to
> upstreaming.  The general rule is not to add CPU or GPU OPPs with
> no proper thermal configuration already in place.
> 
> The patch has already been merged, and as I already noted, [1] I'll
> try to implement, test and submit the proper thermal configuration
> ASAP.  It's up Heiko to decide whether to drop this patch or not.

Hmm, interesting question ;-) .

Dropping the patch is of course still possible and so far we haven't
actually seen anyone with real-world problems.

And with Jonas' stress test, it does look like nobody will in the
(hopefully short) time till we have thermal management.

@Dragan, if you're in favor of that I'll drop the patch.


Heiko


> 
> [1] 
> https://lore.kernel.org/linux-rockchip/df92710498f66bcb4580cb2cd1573fb2@manjaro.org/
> 
> >> Fixes: 6913c45239fd ("arm64: dts: rockchip: Add core dts for RK3308 
> >> SOC")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 +++
> >>  1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi 
> >> b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> >> index 31c25de2d689..a7698e1f6b9e 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> >> @@ -120,16 +120,19 @@ opp-600000000 {
> >>  			opp-hz = /bits/ 64 <600000000>;
> >>  			opp-microvolt = <950000 950000 1340000>;
> >>  			clock-latency-ns = <40000>;
> >> +			status = "disabled";
> >>  		};
> >>  		opp-816000000 {
> >>  			opp-hz = /bits/ 64 <816000000>;
> >>  			opp-microvolt = <1025000 1025000 1340000>;
> >>  			clock-latency-ns = <40000>;
> >> +			status = "disabled";
> >>  		};
> >>  		opp-1008000000 {
> >>  			opp-hz = /bits/ 64 <1008000000>;
> >>  			opp-microvolt = <1125000 1125000 1340000>;
> >>  			clock-latency-ns = <40000>;
> >> +			status = "disabled";
> >>  		};
> >>  	};
> 





