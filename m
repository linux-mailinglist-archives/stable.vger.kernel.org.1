Return-Path: <stable+bounces-144184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C521AB5979
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C246C3A5BE1
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03DF2BE7D6;
	Tue, 13 May 2025 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="CDUZIWTZ"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD961A9B40;
	Tue, 13 May 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152780; cv=none; b=MEjQLxClcmVu2YFs6kVYQZOAbdVTs/ntZ/yT9Ghj2ui5qnS0sb+t/QnjNTksS+sg/ykjeXimpvo2TY+gEg7GvGiYbsTSzEiCTzwQyAxaRa5Sbh/yhWOHlYtwwL3CZXH4tBCGdj/zBqFeea/596FpzKA6jFXC+VrokQcaDa1lyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152780; c=relaxed/simple;
	bh=BEF7Lj89eM93n8UkSe0nnAWQ1qs1inZ4rbgozwL9E9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTpa/7MfM6MD+dSIK6HpaOsQYMN/8/36JSiWC5wn+uh0XT51LXz0bFtDYdpHp3Bri5f9Z/S75WnrEdsiO1WhBV6XkuKXYlCDdlpPWeSJX9SALlv9t7n2mZCzcHbESfNBJ7QUIf6KioyHlmJfnfT4wOP/BwPLp0f6/Rya0AsB56E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=CDUZIWTZ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yDS9tO3ad7hmn2izTyW+Vt2trGV6W8nXY+0cUczUfFk=; b=CDUZIWTZ8iV9z1vn5NZhf+dsJZ
	AbKY0wgyt8Oj4xHVMmjBVaH06DIx9JvBRRbWGiZc9BYwkuYOpawrp799rRkal1rqEJyIwGAyfXzg9
	RmHWCTQtJM31w51y111FTNoYVkd5aCaM6ra7mSIKL06993wDw/OIglQSGfEKoVc7Ou1pRKIvR/l8V
	D6W5vz5mv22m5PH4UVwMNtd8msAg3ioQrsIea8Lonwok8btQ4sjAP3toMWs5xWLLTub1Y8N6awwxu
	npSWtVaCVmwlaxPNqM+xeZmVCdYWMbDO3e/mutonXgdzyCDPPlIAtEjimP8ZdhgUoZssx/XLNqoLi
	qC7Ist8Q==;
Received: from i53875a50.versanet.de ([83.135.90.80] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uEsFM-0001AW-Td; Tue, 13 May 2025 18:12:48 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Matthias Kaehlcke <mka@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, stable@vger.kernel.org
Subject:
 Re: [PATCH v2 1/5] usb: misc: onboard_usb_dev: fix support for Cypress HX3
 hubs
Date: Tue, 13 May 2025 18:12:47 +0200
Message-ID: <2058366.PIDvDuAF1L@diego>
In-Reply-To: <20250425-onboard_usb_dev-v2-1-4a76a474a010@thaumatec.com>
References:
 <20250425-onboard_usb_dev-v2-0-4a76a474a010@thaumatec.com>
 <20250425-onboard_usb_dev-v2-1-4a76a474a010@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 25. April 2025, 17:18:06 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Lukasz Czechowski:
> The Cypress HX3 USB3.0 hubs use different PID values depending
> on the product variant. The comment in compatibles table is
> misleading, as the currently used PIDs (0x6504 and 0x6506 for
> USB 3.0 and USB 2.0, respectively) are defaults for the CYUSB331x,
> while CYUSB330x and CYUSB332x variants use different values.
> Based on the datasheet [1], update the compatible usb devices table
> to handle different types of the hub.
> The change also includes vendor mode PIDs, which are used by the
> hub in I2C Master boot mode, if connected EEPROM contains invalid
> signature or is blank. This allows to correctly boot the hub even
> if the EEPROM will have broken content.
> Number of vcc supplies and timing requirements are the same for all
> HX variants, so the platform driver's match table does not have to
> be extended.
>=20
> [1] https://www.infineon.com/dgdl/Infineon-HX3_USB_3_0_Hub_Consumer_Indus=
trial-DataSheet-v22_00-EN.pdf?fileId=3D8ac78c8c7d0d8da4017d0ecb53f644b8
>     Table 9. PID Values
>=20
> Fixes: b43cd82a1a40 ("usb: misc: onboard-hub: add support for Cypress HX3=
 USB 3.0 family")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

@GregKH: I'd assume you pick patches 1+2 (dt-binding + driver) and I pick t=
he
Rockchip arm64-dts patches afterwards, after the first two look good to you?

Thanks a lot
Heiko

> ---
>  drivers/usb/misc/onboard_usb_dev.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboar=
d_usb_dev.c
> index 75ac3c6aa92d0d925bb9488d1e6295548446bf98..f5372dfa241a9cee09fea95fd=
14b72727a149b2e 100644
> --- a/drivers/usb/misc/onboard_usb_dev.c
> +++ b/drivers/usb/misc/onboard_usb_dev.c
> @@ -569,8 +569,14 @@ static void onboard_dev_usbdev_disconnect(struct usb=
_device *udev)
>  }
> =20
>  static const struct usb_device_id onboard_dev_id_table[] =3D {
> -	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x=
 3.0 HUB */
> -	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x=
 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6500) }, /* CYUSB330x 3.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6502) }, /* CYUSB330x 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6503) }, /* CYUSB33{0,1}x 2.0 HUB, Ve=
ndor Mode */
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB331x 3.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB331x 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6507) }, /* CYUSB332x 2.0 HUB, Vendor=
 Mode */
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6508) }, /* CYUSB332x 3.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x650a) }, /* CYUSB332x 2.0 HUB */
>  	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6570) }, /* CY7C6563x 2.0 HUB */
>  	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB =
2.0 HUB */
>  	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB =
2.0 HUB */
>=20
>=20





