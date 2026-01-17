Return-Path: <stable+bounces-210135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1ECD38D1E
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 08:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25CA4300B362
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 07:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9327587D;
	Sat, 17 Jan 2026 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Jt91tXv2"
X-Original-To: stable@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AD13D891;
	Sat, 17 Jan 2026 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768635372; cv=none; b=I3ZxkkS/f1+BsXUvf6QZ7wT3rjGMOKD140odElk9cm8LEit1B1pfPDx9JjifPQ2lH6wDXqW40lYC3BPE+0Xu2JEKLRBj3V4vaI74YDH3Eu6B1Nu4D1BvNQTvmY4BQKnPCMeQ34slDJJ8W8injW2wrqzYzhDac6A75hVwH+KaZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768635372; c=relaxed/simple;
	bh=snB6yIqC2VsL8mlXs+PWZRuD1PSmo5qB0yNGzzD6izA=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=nWTsWPXNvYMH17N8IDTa0a4RChv0VcOaAYUW/W3EQeNDiX8YsQq/4ZU2Chi3pyTf33UupxWU6CEJ1erQo9E58WCGW6u6lWdE/Er3rnVoRt5Dd98s5zIvwAHBt3jPejd0Tc46CLSHLSAwMd4gZiUeJzViRq+TC74MUpMN0nRrVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Jt91tXv2; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 5CC3841A7E;
	Sat, 17 Jan 2026 08:36:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1768635363; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cUWEhhb8frjqfBNQo4kP9PuoM+qzbcoNLHgDVyTdTW4=;
	b=Jt91tXv26Ir2A6E3/Q4BzdCryRTEdCDmYO/sBExFNBM06bJObgxTtxwaIIjNlAdKVieEze
	XlGhk++onPlu2XD6xxMs1hogFehZz94PIr1hFIW8eq6fcmv50t45X67ABkX/3shlHaTFkg
	SYoRogcHotG5uue6ZCItND9fQU3RTc+IOCt1NSk5+HdBIEK+q34z5aLEppLh1Y0n3OetUL
	PgdmqfcevRUumK07Za8K/BNlpzbixdSaVBb/DDsFsuM7yhzOCqndA8Osf+ig3RxhezlTb/
	2MID6M5+qRxDLx1HOvV8v39U0Fdmhi3GcPabtl1gOX5uSAHmHOaQMdgE411Kkg==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <20260116151253.9223-1-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <20260116151253.9223-1-jerrysteve1101@gmail.com>
Date: Sat, 17 Jan 2026 08:36:00 +0100
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, heiko@sntech.de, pbrobinson@gmail.com, didi.debian@cknow.org, conor+dt@kernel.org, stable@vger.kernel.org
To: "Jun Yan" <jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <eb29fc56-d77f-7000-52e7-a6aefea5b883@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v2] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= Do not enable =?utf-8?q?hdmi=5Fsound?= node on 
 Pinebook Pro
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Jun,

On Friday, January 16, 2026 16:12 CET, Jun Yan <jerrysteve1101@gmail.co=
m> wrote:
> Remove the redundant enabling of the hdmi=5Fsound node in the Pineboo=
k Pro
> board dts file, because the HDMI output is unused on this device. [1]=
[2]
>=20
> This change also eliminates the following kernel log warning, which i=
s
> caused by the unenabled dependent node of hdmi=5Fsound that ultimatel=
y
> results in the node's probe failure:
>=20
>   platform hdmi-sound: deferred probe pending: asoc-simple-card: pars=
e error
>=20
> [1] https://files.pine64.org/doc/PinebookPro/pinebookpro=5Fv2.1=5Fmai=
nboard=5Fschematic.pdf
> [2] https://files.pine64.org/doc/PinebookPro/pinebookpro=5Fschematic=5F=
v21a=5F20220419.pdf
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5a65505a69884 ("arm64: dts: rockchip: Add initial support for =
Pinebook Pro")
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
>=20
> ---
>=20
> Changes in v2:
> - Rewrite the description of change
> - Link to v1: https://lore.kernel.org/linux-rockchip/20260112141300.3=
32996-1-jerrysteve1101@gmail.com/
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/a=
rch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> index 810ab6ff4e67..753d51344954 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> @@ -421,10 +421,6 @@ &gpu {
>  	status =3D "okay";
>  };
> =20
> -&hdmi=5Fsound {
> -	status =3D "okay";
> -};
> -
>  &i2c0 {
>  	clock-frequency =3D <400000>;
>  	i2c-scl-falling-time-ns =3D <4>;

Thanks for the v2!  It is looking good to me, so please free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>


