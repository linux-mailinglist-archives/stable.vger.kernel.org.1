Return-Path: <stable+bounces-92054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A144C9C34C0
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 22:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5974E1F21025
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9870B155C9A;
	Sun, 10 Nov 2024 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="NnUPrlCT"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A5061FE9;
	Sun, 10 Nov 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731273410; cv=none; b=T1a4r3W3cI0U4fpedJ3OHPi3S8lx4XrRSbb3a3CF4qw4Ywv8qytRn3wlQ3ouyWwwxmXNXKVM1MK2kqa0aY6jgu2lZaKEnohoIOJKN4MzPSgzRhJiiopGHWxsmVc2tljaAfVjJjtcX2qgg/ZxvSQCbA0qPm5FiL69EtIYfq0yKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731273410; c=relaxed/simple;
	bh=SOb6+PCqPezk//gqKgeQow+owfg+gFpAZFc8g+4YUd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4oJ+Z2Zo5kvIT270fuK0x37MpFXVNmqS3a6kcntQganAdmPXt2UTYKB8JQQVtv/qKQCktKnXL4dqEWW4Au0hCfLHz9lvAvFnM7wr5sEkmKuHqc4Ft9qvxGK2+U6n7Pd1qpxMt08mBdF5Na10FcAvg6K+pQK1EKl48pmYOTonds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NnUPrlCT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+rZ6R6+emkG1vIh+xndKO9B1+qYVh3QHCutdQutXlKE=; b=NnUPrlCTnmzmH/8JFVsLNY/gVt
	Q+NZJrc6k+eaANoAusGXscEaxYD0IvNNWFYn46mTOkdwv9jPAoIVs9Db1NYV2k4KhUcrSpT5w4Mv7
	/QwB+FzrhW7awQ8yFqx0SaNH4QOZNjNqMeuDvqjhL/9lp0NbNLrIqn+HfFruoQOvq0Yxm4F4e7+8F
	sKRnQWeE50imeZcub+IfMd2f0sS9o1bJIWAaAWjlXRMVpsWwB+D6Io8pcS07uq9+0mmbJ6o8srZrr
	BqGnPE7YXZ/GywRajtSpzxgMUr3vfgjWe0WRI5laYIagGllkyELSBO1/WgLIZQTMCXmjoFEyRop20
	Db2Xlsig==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tAFIY-0006tu-Sn; Sun, 10 Nov 2024 22:16:42 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Fix vdd_gpu voltage constraints on
 PinePhone Pro
Date: Sun, 10 Nov 2024 22:16:42 +0100
Message-ID: <865640012.0ifERbkFSE@diego>
In-Reply-To: <fb3700f2d67c7f062c66cb8eb0f59b17@manjaro.org>
References:
 <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
 <4386271.ejJDZkT8p0@diego> <fb3700f2d67c7f062c66cb8eb0f59b17@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Sonntag, 10. November 2024, 21:47:15 CET schrieb Dragan Simic:
> Hello Heiko,
>=20
> On 2024-11-10 21:08, Heiko St=FCbner wrote:
> > Am Sonntag, 10. November 2024, 19:44:31 CET schrieb Dragan Simic:
> >> The regulator-{min,max}-microvolt values for the vdd_gpu regulator in=
=20
> >> the
> >> PinePhone Pro device dts file are too restrictive, which prevents the=
=20
> >> highest
> >> GPU OPP from being used, slowing the GPU down unnecessarily.  Let's=20
> >> fix that
> >> by making the regulator-{min,max}-microvolt values less strict, using=
=20
> >> the
> >> voltage range that the Silergy SYR838 chip used for the vdd_gpu=20
> >> regulator is
> >> actually capable of producing. [1][2]
> >>=20
> >> This also eliminates the following error messages from the kernel log:
> >>=20
> >>   core: _opp_supported_by_regulators: OPP minuV: 1100000 maxuV:=20
> >> 1150000, not supported by regulator
> >>   panfrost ff9a0000.gpu: _opp_add: OPP not supported by regulators=20
> >> (800000000)
> >>=20
> >> These changes to the regulator-{min,max}-microvolt values make the=20
> >> PinePhone
> >> Pro device dts consistent with the dts files for other Rockchip=20
> >> RK3399-based
> >> boards and devices.  It's possible to be more strict here, by=20
> >> specifying the
> >> regulator-{min,max}-microvolt values that don't go outside of what the=
=20
> >> GPU
> >> actually may use, as the consumer of the vdd_gpu regulator, but those=
=20
> >> changes
> >> are left for a later directory-wide regulator cleanup.
> >=20
> > With the Pinephone Pro using some sort of special-rk3399, how much of
> > "the soc variant cannot use the highest gpu opp" is in there, and just=
=20
> > the
> > original implementation is wrong?
>=20
> Good question, I already asked it myself.  I'm unaware of any kind of
> GPU-OPP-related restrictions when it comes to the PinePhone-Pro-specific
> RK3399S.  Furthermore, "the word on the street" is that the RK3399S can
> work perfectly fine even at the couple of "full-fat" RK3399 CPU OPPs
> that are not defined for the RK3399S, and the only result would be the
> expected higher power consumption and a bit more heat generated.

In the past we already had people submit higher cpu OPPs with the
reasoning "the cpu runs fine with it", but which where outside of the
officially specified frequencies and were essentially overclocking the
CPU cores and thus possibly reducing its lifetime.

So "it runs fine" is a bit of thin argument ;-) . I guess for the gpu it
might not matter too much, compared to the cpu cores, but I still like
the safe sides - especially for the mainline sources.

I guess we'll wait for people to test the change and go from there ;-) .


> This just reaffirms that no known GPU OPP restrictions exist.  Even
> if they existed, enforcing them _primarily_ through the constraints of
> the associated voltage regulator would be the wrong approach.  Instead,
> the restrictions should be defined primarily through the per-SoC-variant
> GPU OPPs, which are, to my best knowledge, not known to be existing for
> the RK3399S SoC variant.

Yes, that is what I was getting at, if that is a limiting implementation
it is of course not done correctly, but I'd like to make sure.

Of course Pine's development model doesn't help at all in that regard.
There isn't even a "vendor" kernel source it seems. [0]


Heiko


[0] https://wiki.pine64.org/wiki/PinePhone_Pro_Development#Kernel
states "There's no canonical location for Pinephone Pro Linux kernel develo=
pment,"




