Return-Path: <stable+bounces-179354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B98C7B54E87
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 14:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84865583465
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61EF3093CB;
	Fri, 12 Sep 2025 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p29CIcnU"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C530F529
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681603; cv=none; b=ghCwDYjv0qXJ9YrDpNroWv2J1vQyHV5icGpu4b+cjB8mgM/Wp3dDjH6n8JK3OfE0vssrTtcAuOuPXAWImd8XD//gOzlyiVel11o1h+g4GfDtG8EwsS0YXjkefYcrQtbrv3jPNmxZQ7DP956kTZOuTSVppREOd4yPHivs1I1vT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681603; c=relaxed/simple;
	bh=5HpXZaEUOJ+8dkBCgMsUTF5lN67gIppE+6goHOwMv6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kGpcOSEG2tjrt+oTwQIWfiWuUZH3P9VrpbMnIkeF+nPtjxklF1oppNZAOSGPf5NYCKorZg1M3sOqwrmtZ3TavNPjjxqNgD8pom9QjEztBuesQmgK/SCVRfadv5QL952mkE7sYkTp1r0eWk1i8lC0vF2x30AZEntHlUAlqHh2Qz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p29CIcnU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6E573C8EC49;
	Fri, 12 Sep 2025 12:53:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6825A60638;
	Fri, 12 Sep 2025 12:53:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F26E102F28D5;
	Fri, 12 Sep 2025 14:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757681598; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KSiuCe8hqpM4azza8GgBa0O2HK79U9r5itgP3WoTyzc=;
	b=p29CIcnUXSxrA721IxRLRg8czzKSoTpaBUUhs69MpgvId/e3N19cYYS1Tg0LkRtWuguUWE
	71K7MJyLKHdEXUlBsB8AzcvygiMBWLHztSwb61usctXULqksEZQWhZCw9NCxtnZb7/0ICZ
	+nKDV0cojtyKohHBnyEOONprH4wL1m0KifKq73vOxPJuMiCCx+dF3+eo9C0KNuVdbkTx6m
	3lz9YDE2q3li/2Mysyqk+O+kIzv+JvRSQOm6SRvQNyQu5tcUP+y9OpwWuvekOKoQH+wIG6
	oY3PBsrvW16Wu4i6THctduVQ7trnN6X/LZJPhdwzyXOYEmJFwD4ulMYcTCdfJQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Wunderlich <frank-w@public-files.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Josua Mayer
 <josua@solid-run.com>
Subject: Re: [PATCH] arm64: dts: marvell: cn913x-solidrun: fix sata ports
 status
In-Reply-To: <20250911-cn913x-sr-fix-sata-v1-1-9e72238d0988@solid-run.com>
References: <20250911-cn913x-sr-fix-sata-v1-1-9e72238d0988@solid-run.com>
Date: Fri, 12 Sep 2025 14:53:03 +0200
Message-ID: <87tt17oms0.fsf@BLaptop.bootlin.com>
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
> Cc: stable@vger.kernel.org
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
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250911-cn913x-sr-fix-sata-5c737ebdb97f
>
> Best regards,
> --=20
> Josua Mayer <josua@solid-run.com>
>
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

