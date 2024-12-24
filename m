Return-Path: <stable+bounces-106085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97D39FC1AC
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 20:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291DD7A18F3
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 19:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069E617C208;
	Tue, 24 Dec 2024 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JE04x0G/"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5F149E00
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735068662; cv=none; b=Uj76Zo5n3/Qsr2BlLClib31wbwxiornqiZ8Q6KoWXfOfaQ6k7iSSU7TwE4Rkkb/1fW1yPKTSxQwkX3L83HptXlQDxOIb3QpWpee6/NiW+b2rWqAQCRqcB7Us5nfXGWhf1z0+53inr/anPauaC5KdGVOtOIU+PBy9Ajc5L4jqCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735068662; c=relaxed/simple;
	bh=5hw+91IHCyOuYrsL7vYIDSH2pCz997Lbwau3AspsuAE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cGo9ap2YqDqC2UdvGTgpw5pWX0t58cYlsuZm02c5cFIX64Hh/WBw3rMROX0HGmKl5aYa2v0UN6YDvgq/pHlYN5jSUXq0nAw9gPeg2w60nmleRFgOql1vsoB0Z5GaESbFbqY0oPUUMLNgyqEkEWLo8VwN87ndetDY6kNKvG/C0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JE04x0G/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735068650;
	bh=5hw+91IHCyOuYrsL7vYIDSH2pCz997Lbwau3AspsuAE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JE04x0G/XUk0o6OErhezxHJ2g4Y/RqsudoYT2ZlNW8Dj08mYG6qyghlYl9qBTSS4z
	 UXWJXrxNRuEHOqTAlp4+Kmx3+tiVFckhfYrPerWFIRaU5A61dTDQCwBlGm6wofWpgM
	 qIXv380rlX92zlFysfLQRkWNnWPc2V+CwfQrgnw4=
Date: Tue, 24 Dec 2024 20:30:49 +0100 (GMT+01:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: "Dustin L. Howett" <dustin@howett.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Alexandru M Stan <ams@frame.work>, linux@frame.work,
	stable@vger.kernel.org, chrome-platform@lists.linux.dev
Message-ID: <d8fc0e50-f71b-4508-a097-ab59d4b17210@weissschuh.net>
In-Reply-To: <20241224-platform-chrome-cros_ec_lpc-fix-product-identity-for-early-framework-laptops-v1-1-0d31d6e1d22c@howett.net>
References: <20241224-platform-chrome-cros_ec_lpc-fix-product-identity-for-early-framework-laptops-v1-1-0d31d6e1d22c@howett.net>
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: fix product identity for
 early Framework Laptops
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d8fc0e50-f71b-4508-a097-ab59d4b17210@weissschuh.net>

Dec 24, 2024 19:56:06 Dustin L. Howett <dustin@howett.net>:

> The product names for the Framework Laptop (12th and 13th Generation
> Intel Core) are incorrect as of 62be134abf42.
>
> Fixes: 62be134abf42 ("platform/chrome: cros_ec_lpc: switch primary DMI da=
ta for Framework Laptop")
> Cc: stable@vger.kernel.org # 6.12.x
> ---

This --- is spurious.

> Signed-off-by: Dustin L. Howett <dustin@howett.net>

Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

> ---
> drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chr=
ome/cros_ec_lpc.c
> index 588be75aeca16b6150c12d2811e4c9dfc31b904e..69801ace0496dd9ed31bc3d40=
8c43b96ccb71186 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -707,7 +707,7 @@ static const struct dmi_system_id cros_ec_lpc_dmi_tab=
le[] __initconst =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Framework Laptop (12th Gen =
Intel Core) */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .matches =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_MA=
TCH(DMI_SYS_VENDOR, "Framework"),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_EXACT_M=
ATCH(DMI_PRODUCT_NAME, "12th Gen Intel Core"),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_EXACT_M=
ATCH(DMI_PRODUCT_NAME, "Laptop (12th Gen Intel Core)"),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data =3D (void *)&fram=
ework_laptop_mec_lpc_driver_data,
> =C2=A0=C2=A0=C2=A0 },
> @@ -715,7 +715,7 @@ static const struct dmi_system_id cros_ec_lpc_dmi_tab=
le[] __initconst =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Framework Laptop (13th Gen =
Intel Core) */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .matches =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_MA=
TCH(DMI_SYS_VENDOR, "Framework"),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_EXACT_M=
ATCH(DMI_PRODUCT_NAME, "13th Gen Intel Core"),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_EXACT_M=
ATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data =3D (void *)&fram=
ework_laptop_mec_lpc_driver_data,
> =C2=A0=C2=A0=C2=A0 },
>
> ---
> base-commit: a15ab7a5cc2a17b6a803f624fcf215f4e68d56b6
> change-id: 20241224-platform-chrome-cros_ec_lpc-fix-product-identity-for-=
early-framework-laptops-757474281ace
>
> Best regards,
> --
> Dustin L. Howett <dustin@howett.net>


