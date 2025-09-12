Return-Path: <stable+bounces-179356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6FDB54E93
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 14:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0615218974D6
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F61304984;
	Fri, 12 Sep 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BEvI8wct"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BC3019BD
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681784; cv=none; b=i+O8ctLpP5/9k4QUOgCwg54p7NzV1MVovSTXZsx2mLs6JW+FB/ElicKi8CV++3p78+M9/TR1g/rSOCiaud2W9gFdHF57H/IqCiPiUyx81UwQaJzSlMaijiHK/mqkDd2/Lm/YAZuVeq75j7wZy+mQwoiyH7SBUO7UvGQRLI3AmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681784; c=relaxed/simple;
	bh=QuNW39DS4gbH4ya/CBqjRP+qr3W9HnFI8Iq3ILEJa+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KOLe1ElEakLikGij6pzMXoDC6GDC21+tSnBCmmqNnGmvQtrEcoKm0BYaQsby7pKVIfOIPHk06UHjIldjnSDxQAWKwKa7oqt90QK1aqP6dCQ93PrAI6KwngLlnsweNZ9DqLPIGLLqBEnsoYJEO2zm9PdzVG5ibsBUJCExo+iMXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BEvI8wct; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E59031A0DD2;
	Fri, 12 Sep 2025 12:56:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BABB360638;
	Fri, 12 Sep 2025 12:56:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 560AD102F28D5;
	Fri, 12 Sep 2025 14:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757681778; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AyLlO1Uh8KjPmN5r1stp+pswBHh7RIt2q/x4MHSok28=;
	b=BEvI8wct8ikkdaAbOd7NpQ9LyKL7l/7iEoixB0pcpgvbTxlJynqr8zxzsGptizzOkJBr0f
	3Gpvte4Rj93zGCYh4EteNRVArgp1rNoLBBkIgqESFYnnRzI0/+ZNFIF5+dLOpS1zIIHtkz
	lF2butPbKxx9G0faYkB43TXk9k+6DHsnPX7rjs99Tel5db8l7moDqN1Gixb1dOOWIs3clZ
	2L65kAYFC+P7pLnk7c91uVsvbF6hQ4lzh4joORbFnmKHGaiNc6SZyK+lB+YgThNPQUlq/I
	62ZX/8KVVG8gJyt198YSSxRP2CxqPwi681NGJ7nGBjUYfk16m6S2p6N9TMUkkw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Wunderlich <frank-w@public-files.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: marvell: cn913x-solidrun: fix sata
 ports status
In-Reply-To: <20250911-cn913x-sr-fix-sata-v2-1-0d79319105f8@solid-run.com>
References: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
 <20250911-cn913x-sr-fix-sata-v2-1-0d79319105f8@solid-run.com>
Date: Fri, 12 Sep 2025 14:56:16 +0200
Message-ID: <87o6rfommn.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Josua Mayer <josua@solid-run.com> writes:

> Commit "arm64: dts: marvell: only enable complete sata nodes" changed
> armada-cp11x.dtsi disabling all sata ports status by default.
>
> The author missed some dts which relied on the dtsi enabling all ports,
> and just disabled unused ones instead.
>
> Update dts for SolidRun cn913x based boards to enable the available
> ports, rather than disabling the unvavailable one.
>
> Further according to dt bindings the serdes phys are to be specified in
> the port node, not the controller node.
> Move those phys properties accordingly in clearfog base/pro/solidwan.
>
> Fixes: 30023876aef4 ("arm64: dts: marvell: only enable complete sata node=
s")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Applied on mvebu/fixes

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 7 ++++---
>  arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 6 ++++--
>  arch/arm64/boot/dts/marvell/cn9132-clearfog.dts    | 6 ++----
>  3 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi b/arch/arm64/boot=
/dts/marvell/cn9130-cf.dtsi
> index ad0ab34b66028c53b8a18b3e8ee0c0aec869759f..bd42bfbe408bbe2a4d58dbd40=
204bcfb3c126312 100644
> --- a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
> +++ b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
> @@ -152,11 +152,12 @@ expander0_pins: cp0-expander0-pins {
>=20=20
>  /* SRDS #0 - SATA on M.2 connector */
>  &cp0_sata0 {
> -	phys =3D <&cp0_comphy0 1>;
>  	status =3D "okay";
>=20=20
> -	/* only port 1 is available */
> -	/delete-node/ sata-port@0;
> +	sata-port@1 {
> +		phys =3D <&cp0_comphy0 1>;
> +		status =3D "okay";
> +	};
>  };
>=20=20
>  /* microSD */
> diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/ar=
m64/boot/dts/marvell/cn9131-cf-solidwan.dts
> index 47234d0858dd2195bb1485f25768ad3c757b7ac2..338853d3b179bb5cb742e975b=
b830fdb9d62d4cc 100644
> --- a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
> +++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
> @@ -563,11 +563,13 @@ &cp1_rtc {
>=20=20
>  /* SRDS #1 - SATA on M.2 (J44) */
>  &cp1_sata0 {
> -	phys =3D <&cp1_comphy1 0>;
>  	status =3D "okay";
>=20=20
>  	/* only port 0 is available */
> -	/delete-node/ sata-port@1;
> +	sata-port@0 {
> +		phys =3D <&cp1_comphy1 0>;
> +		status =3D "okay";
> +	};
>  };
>=20=20
>  &cp1_syscon0 {
> diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64=
/boot/dts/marvell/cn9132-clearfog.dts
> index 0f53745a6fa0d8cbd3ab9cdc28a972ed748c275f..115c55d73786e2b9265e1caa4=
c62ee26f498fb41 100644
> --- a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
> +++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
> @@ -512,10 +512,9 @@ &cp1_sata0 {
>  	status =3D "okay";
>=20=20
>  	/* only port 1 is available */
> -	/delete-node/ sata-port@0;
> -
>  	sata-port@1 {
>  		phys =3D <&cp1_comphy3 1>;
> +		status =3D "okay";
>  	};
>  };
>=20=20
> @@ -631,9 +630,8 @@ &cp2_sata0 {
>  	status =3D "okay";
>=20=20
>  	/* only port 1 is available */
> -	/delete-node/ sata-port@0;
> -
>  	sata-port@1 {
> +		status =3D "okay";
>  		phys =3D <&cp2_comphy3 1>;
>  	};
>  };
>
> --=20
> 2.51.0
>
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

