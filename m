Return-Path: <stable+bounces-259909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kyKdA6tHH2o4jgAAu9opvQ
	(envelope-from <stable+bounces-259909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 23:14:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5797863209F
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 23:14:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=ODppvQTZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259909-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-259909-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B76A53010BA8
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 21:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8939C637;
	Tue,  2 Jun 2026 21:08:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A43126C2;
	Tue,  2 Jun 2026 21:08:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434508; cv=none; b=gcoukjYLzAA339oaUTu17IWLnhB5H9ty1OLhs4l7KPqUaIeb5O/iDsfeIvW7iZ8u7wV0/Okw03oxmLda8GIhorQtNQqtUjkuRmf+5bOsSa6JcJCqK5NAJ+0Lwl7E80oKZDdbI2qbehTAB0HzZmRMS7vPPwm8Is9zRW9SF2atSQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434508; c=relaxed/simple;
	bh=u1uq3CFcKqR2Ws/rUTB63QvUhy2p+eqwSVC20BvZ3js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCCk1SNoARhoAUcqyr+5EeakEQUqrx4WEWrPICVwrtcZkpUER/ilRF9gIm8IAvQtvC/MwWjeTFTHIybkSZgOWHzNuTKW8OzjbJ+dUXnWgSoS/Fo1l93aTbD/Sfiad7bW035HDSj0SvYgm23TU8UbQiJJQrGOV2UsAeyoZ/GeCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ODppvQTZ; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=CW9LOlJAtSZATcZIaY6uLfTJOIqnCg+SkeFpTOqsGbw=; b=ODppvQTZUOOtiSOWcFlUNW1uKK
	b9+m5bbK3ZQ4qMKyM4bsPZKmHRn7jvGmQvKT4GBYvXRMMzlbS7UcLMj+9j1Mrvtywx4BFNJhW/G4U
	1u9lxb7YMbrFCWAspW7Ewhi/cKm1iYtVZKNJMFX9QRfCMnz/WttwGdLDburXwPgxl+AS2Zqaof/jm
	AmGQ7xEXfcbCTr73Lt8ETxgVBEtQfdKK1q2sLTo3LzZKE4wvF2s042Z9wf1OONn1wl58A2mBs5nH/
	yWEDtdelYw5kgz7GXRBdL5FLeF4AOEKq+c8Q76bpTuT0q5DJ3XaP4tf2+mUOkovcjaI31NJtP/pmn
	uEE9Ikog==;
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
 Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: stable@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: fix emmc reset polarity on px30-cobra
Date: Tue, 02 Jun 2026 23:08:20 +0200
Message-ID: <3631825.d7IHhHJzqS@phil>
In-Reply-To: <20260512092225.34835-1-jakob.unterwurzacher@cherry.de>
References: <20260512092225.34835-1-jakob.unterwurzacher@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:quentin.schulz@cherry.de,m:jakob.unterwurzacher@cherry.de,m:jakobunt@gmail.com,m:stable@vger.kernel.org,m:heiko.stuebner@cherry.de,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[kernel.org,cherry.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259909-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sntech.de:from_mime,sntech.de:dkim,cherry.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5797863209F

Am Dienstag, 12. Mai 2026, 11:22:09 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Jakob Unterwurzacher:
> Technically, the reset signal is active low - it's called RST_n after all.
>=20
> But it is ignored completely unless RST_n_FUNCTION=3D1 (byte 162 in extcs=
d)
> is set in the emmc. It is 0 per default.
>=20
> For emmcs that have RST_n_FUNCTION=3D1 we failed like this:
>=20
> 	[    3.074480] mmc1: Failed to initialize a non-removable card
>=20
> With this change they work normally.
>=20
> Cc: stable@vger.kernel.org
> Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and =
board variants")
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

as Quentin remarked, author (@gmail) and signed-off-by do not match.
While I'm generally open to fixing things, when it touches the DCO this
isn't the case.

So please resend this with the correct author.

In general "git send-email" will do the correct thing (that From: line),
when patch author and email-id do not match.


Thanks
Heiko

> ---
>  arch/arm64/boot/dts/rockchip/px30-cobra.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi b/arch/arm64/bo=
ot/dts/rockchip/px30-cobra.dtsi
> index b7e669d8ba4d..90751b04f95c 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
> @@ -35,7 +35,7 @@ emmc_pwrseq: emmc-pwrseq {
>  		compatible =3D "mmc-pwrseq-emmc";
>  		pinctrl-0 =3D <&emmc_reset>;
>  		pinctrl-names =3D "default";
> -		reset-gpios =3D <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
> +		reset-gpios =3D <&gpio1 RK_PB3 GPIO_ACTIVE_LOW>;
>  	};
> =20
>  	gpio-leds {
>=20





