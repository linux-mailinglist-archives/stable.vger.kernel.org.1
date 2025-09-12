Return-Path: <stable+bounces-179363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF9B54EB0
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064A61C20D63
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93093090E8;
	Fri, 12 Sep 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eBVMVMl3"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B8305E0D;
	Fri, 12 Sep 2025 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681914; cv=none; b=TO+QGmazrwDChZ3ENc8Vtt5KVjiUPeVSlupzuAbOnbL9fJbOTrezFyTUuIrJMmgWMXLsMbMD90UGncPsizBD7pOF8/eljyW2t+HLt0cdseksGS+IInRb52bSEQLzZN7gc6lfPFJylrjL50M3xjtcKOMD/CDsH5QTamlUWVTQ7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681914; c=relaxed/simple;
	bh=Fxo6h2hIYFDxxN+TWuPg1+6lQ5e9DJwrub3Zjgow4aI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FfOPvClR2LYKUX5e8V8RgmZRotkvghaHdPfz7cffEg8K6tSddwSPLU7M8AMjRrEs2RQm7ZT8KJRK8PEL31wx1NYlh4BoKfmunrlmsL3E63gct6xF30Dc34/xdpIeo1BU2pTjhXyATFk0QF0dXOF/2ecmzV0egRcYE/ryPkQ/FPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eBVMVMl3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6647F1A0DD2;
	Fri, 12 Sep 2025 12:58:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3CA4760638;
	Fri, 12 Sep 2025 12:58:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FBB5102F29CD;
	Fri, 12 Sep 2025 14:58:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757681910; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6fGibqKE+FAjIZ49uwUJtvQhXhXO0YneIbfrt6lUIe0=;
	b=eBVMVMl3UH5oHD9LuDgoIy2GiDvmkt/hXSeYR5TRsDwcSzzQIqeZ7fa8W/16Tk0D3A9pZB
	bkcbZuJfu3QuDFrz8h8PMjzVj67dLPXkyThpVFKVEcX+l1uJWHTelo65UGi9wMrGSf99Cs
	+0MSUngd9EtG5VlsD3o3aX9pQfPyjWut46To8mYVBoBh/QULATE2gUhufdteISsIb3kFjS
	XsHIz5UINFa1OrS44PmCUEpA5wzK5vNn8uV+9wCu7heCTqBCLfWBlok6raJIQ06HHfKcrN
	0kdgReYhf9PjTBQgEbaM5t3N2ZlJbBvVJ5YWt+5VoxPydJIAOTVV59AwUsF5iQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Wunderlich <frank-w@public-files.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: marvell: cn9132-clearfog: fix
 multi-lane pci x2 and x4 ports
In-Reply-To: <20250911-cn913x-sr-fix-sata-v2-3-0d79319105f8@solid-run.com>
References: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
 <20250911-cn913x-sr-fix-sata-v2-3-0d79319105f8@solid-run.com>
Date: Fri, 12 Sep 2025 14:58:29 +0200
Message-ID: <87ikhnomiy.fsf@BLaptop.bootlin.com>
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

> The mvebu-comphy driver does not currently know how to pass correct
> lane-count to ATF while configuring the serdes lanes.
>
> This causes the system to hard reset during reconfiguration, if a pci
> card is present and has established a link during bootloader.
>
> Remove the comphy handles from the respective pci nodes to avoid runtime
> reconfiguration, relying solely on bootloader configuration - while
> avoiding the hard reset.
>
> When bootloader has configured the lanes correctly, the pci ports are
> functional under Linux.
>
> This issue may be addressed in the comphy driver at a future point.
>
> Fixes: e9ff907f4076 ("arm64: dts: add description for solidrun cn9132 cex=
7 module and clearfog board")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/cn9132-clearfog.dts | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64=
/boot/dts/marvell/cn9132-clearfog.dts
> index 115c55d73786e2b9265e1caa4c62ee26f498fb41..6f237d3542b9102695f8a4845=
7f43340da994a2c 100644
> --- a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
> +++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
> @@ -413,7 +413,13 @@ fixed-link {
>  /* SRDS #0,#1,#2,#3 - PCIe */
>  &cp0_pcie0 {
>  	num-lanes =3D <4>;
> -	phys =3D <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_co=
mphy3 0>;
> +	/*
> +	 * The mvebu-comphy driver does not currently know how to pass correct
> +	 * lane-count to ATF while configuring the serdes lanes.
> +	 * Rely on bootloader configuration only.
> +	 *
> +	 * phys =3D <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0=
_comphy3 0>;
> +	 */
>  	status =3D "okay";
>  };
>=20=20
> @@ -475,7 +481,13 @@ &cp1_eth0 {
>  /* SRDS #0,#1 - PCIe */
>  &cp1_pcie0 {
>  	num-lanes =3D <2>;
> -	phys =3D <&cp1_comphy0 0>, <&cp1_comphy1 0>;
> +	/*
> +	 * The mvebu-comphy driver does not currently know how to pass correct
> +	 * lane-count to ATF while configuring the serdes lanes.
> +	 * Rely on bootloader configuration only.
> +	 *
> +	 * phys =3D <&cp1_comphy0 0>, <&cp1_comphy1 0>;
> +	 */
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

