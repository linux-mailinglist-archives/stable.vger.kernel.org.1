Return-Path: <stable+bounces-179362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF6B54EAE
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 14:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0422D58377F
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4D308F3E;
	Fri, 12 Sep 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HxtNRvlX"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D678305E0D;
	Fri, 12 Sep 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681857; cv=none; b=EVUigbBu4/ir1/851qRFM+5HQQu7gvdWRi8xxtxYIVDs3RnIqVIHinDTOgVT7TXN3Ys98fylyMMXiPZD62ZwHO/REYii9GW690BLAPNUZaexrk6OlbShL0grVrkg7IBXrDfd5Ex0MiJoOj5hCGRReiRgzX7J/GvfGj2U4Xmz6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681857; c=relaxed/simple;
	bh=doZrhra+WoKnWL3GeWYIh7XwtgJmI0AYgvJj95PavT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pdUtl+qnEnGbmNqRP9lP46VlQ9+2XHznGBYE/N6Vx2rYvVfy0+nw6sRilrkhwsbIfbCRZNTadb2Nd0qDajd6nUFvarItOpySy22jwUp7b0lHrbM0wjv9J4Xohes7kZziSLwnbBJIYeUCD7+jBmgFgJ08oLPDsKb/S3Ps8/lfbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HxtNRvlX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3AC6B1A09F3;
	Fri, 12 Sep 2025 12:57:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0127260638;
	Fri, 12 Sep 2025 12:57:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 422FC102F2A70;
	Fri, 12 Sep 2025 14:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757681852; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AKTqAHrzTqK2etFjJsAwB8b24D1cRMcQiVtfJ6wvNcQ=;
	b=HxtNRvlXl7AgpEYwX4jV3sGSiMtCIrbcAJTzAaXRgI3+WvwtmJsxO65WY788GJnNyEYEsw
	uez+I/TI+as1jTGZhed28C/VnvTrMr63d5RWvmwRcQwbs5MLhNSFmab/LAyM4bfJ7gDD4j
	MPCdipnIWXWqhitAMHSjYDsaVuIxOZ/UMEjD63X2yUuxoO9yRqUGon+86cJ+2lqRIPZL4b
	9C1E5nf7cg0pO/qQzEr+NYNYCpg8EthAZ/eqYuiJh+gzvPIiiKVndlTyf4bUnWsDa1xTZB
	mjGf+MVTvdZharqWHgGztfa7cRPlMNzPjd4QFTia43/1HKImzdjhPF5oehP+cg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Wunderlich <frank-w@public-files.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: marvell: cn9132-clearfog: disable
 eMMC high-speed modes
In-Reply-To: <20250911-cn913x-sr-fix-sata-v2-2-0d79319105f8@solid-run.com>
References: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
 <20250911-cn913x-sr-fix-sata-v2-2-0d79319105f8@solid-run.com>
Date: Fri, 12 Sep 2025 14:57:28 +0200
Message-ID: <87ldmjomkn.fsf@BLaptop.bootlin.com>
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

> Similar to MacchiatoBIN the high-speed modes are unstable on the CN9132
> CEX-7 module, leading to failed transactions under normal use.
>
> Disable all high-speed modes including UHS.
>
> Additionally add no-sdio and non-removable properties as appropriate for
> eMMC.
>
> Fixes: e9ff907f4076 ("arm64: dts: add description for solidrun cn9132 cex=
7 module and clearfog board")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi b/arch/arm64=
/boot/dts/marvell/cn9132-sr-cex7.dtsi
> index afc041c1c448c3e49e1c35d817e91e75db6cfad6..bb2bb47fd77c12f1461b5b9f6=
ef5567a32cc0153 100644
> --- a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
> +++ b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
> @@ -137,6 +137,14 @@ &ap_sdhci0 {
>  	pinctrl-0 =3D <&ap_mmc0_pins>;
>  	pinctrl-names =3D "default";
>  	vqmmc-supply =3D <&v_1_8>;
> +	/*
> +	 * Not stable in HS modes - phy needs "more calibration", so disable
> +	 * UHS (by preventing voltage switch), SDR104, SDR50 and DDR50 modes.
> +	 */
> +	no-1-8-v;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
>  	status =3D "okay";
>  };
>=20=20
>
> --=20
> 2.51.0
>
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

