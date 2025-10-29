Return-Path: <stable+bounces-191631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5EEC1B51C
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9371F5C1CC9
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 14:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962551F7575;
	Wed, 29 Oct 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QcyZ4nx4"
X-Original-To: stable@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3742AA6;
	Wed, 29 Oct 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747258; cv=none; b=c3pRdT7UW16s3nO4I25NpnOm5MMQbNOwCM0dFTl6GXkLhqVz1h5lKIbrLFvEV9SVsvf1fpjLR5c2P7a7e9yQb4KQ67J3FXTlje4/S9Rc5bOIKTMZv0n633sWD+5Xs2K4aghEk3nzB3kk/KIPA0Z2YkU4xlLz9+wrbmLRpaurHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747258; c=relaxed/simple;
	bh=ooJGMuUWaGN8KnGlNB6N5d0ufiuUZYKb/ug80ZWMPDk=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=JU5ZuCUsek4lEbTmqiwml/BEBGysXlWlb7GsTMlnRQodQUMUNeNHV3tPxYr33qQDyJVHnGT6xgcrdBiPFPPYahA5s0cpmZVtuapG5zSMJXETKLmvaz9lJgENLJhka96lUDgEoMlFsyGjmpM+G8zuwSA8LuMQxvDteXxHymXzMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QcyZ4nx4; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 0E72940D1B;
	Wed, 29 Oct 2025 15:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1761747252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eb/tlKO9/Zxp9vLJznUadT+d0q6ZWEudok8Oi1J/AHc=;
	b=QcyZ4nx4bzFvgRTgGGjXFoCKjtw0QC0NoAjioyQ/+bdgjcXHZ4AGxqJrpfZGxowXwRSAll
	5/B9SxX9ve4hpr9DHSvyCdy50RvSKIJn/bYEHXB79NRVg2JU9tJP6cBPHDLx5k1JYawqr8
	pYrQ49hp8vnF/cdHklssIQPxH/Ei2bYLuPAq20ZTw3xTQB3Ce1HrkMYCkTGebaC+fVpWIr
	AXfkV3g20E3C75Yi7Jr2jjNQPDm7RgovKrVo04CHiiQGe0jDLDB4Za5eHGDLawjeUWTrcp
	a4IwMIu4AvtkhOstRyoAZoQBFZdF7BmizJ640LBEkcT2KwIT3v4pfS9VDIf8BA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <20251029-rk3399-op1-include-v1-1-2472ee60e7f8@cherry.de>
Content-Type: text/plain; charset="utf-8"
References: <20251029-rk3399-op1-include-v1-1-2472ee60e7f8@cherry.de>
Date: Wed, 29 Oct 2025 15:14:09 +0100
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, "Quentin Schulz" <quentin.schulz@cherry.de>, stable@vger.kernel.org
To: "Quentin Schulz" <foss+kernel@0leil.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <f4149b94-30e5-ff0f-44b2-0806b2747890@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= include rk3399-base instead of rk3399 in 
 rk3399-op1
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Quentin,

On Wednesday, October 29, 2025 14:50 CET, Quentin Schulz <foss+kernel@0=
leil.net> wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> In commit 296602b8e5f7 ("arm64: dts: rockchip: Move RK3399 OPPs to dt=
si
> files for SoC variants"), everything shared between variants of RK339=
9
> was put into rk3399-base.dtsi and the rest in variant-specific DTSI,
> such as rk3399-t, rk3399-op1, rk3399, etc.
> Therefore, the variant-specific DTSI should include rk3399-base.dtsi =
and
> not another variant's DTSI.
>=20
> rk3399-op1 wrongly includes rk3399 (a variant) DTSI instead of
> rk3399-base DTSI, let's fix this oversight by including the intended
> DTSI.
>=20
> Fortunately, this had no impact on the resulting DTB since all nodes
> were named the same and all node properties were overridden in
> rk3399-op1.dtsi. This was checked by doing a checksum of rk3399-op1 D=
TBs
> before and after this commit.
>=20
> No intended change in behavior.

Thank you for spotting this issue and for fixing it!  That was
an honest oversight on my part, but it actually resulted in no
ill effects, which is the main reason why and how it managed to
slip by originally.

Your description of the issue is pretty much perfect, so I've
got nothing else to add but

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> Fixes: 296602b8e5f7 ("arm64: dts: rockchip: Move RK3399 OPPs to dtsi =
files for SoC variants")
> Cc: stable@vger.kernel.org
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi b/arch/arm6=
4/boot/dts/rockchip/rk3399-op1.dtsi
> index c4f4f1ff6117b..9da6fd82e46b2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
>   */
> =20
> -#include "rk3399.dtsi"
> +#include "rk3399-base.dtsi"
> =20
>  / {
>  	cluster0=5Fopp: opp-table-0 {


