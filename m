Return-Path: <stable+bounces-4927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A18808AE8
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92611282E3D
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154B3D0BC;
	Thu,  7 Dec 2023 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5ABAqzB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEF12D7A4;
	Thu,  7 Dec 2023 14:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C1C433C8;
	Thu,  7 Dec 2023 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701960222;
	bh=T2pHHPrWdgufzNO/CKTT1kJEuRLZWujqjBSnGMiCqLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i5ABAqzBGRStFVAPvsTx7m7C1mUruXHLHhJpOjskz8pKaCcBoM6jWwKotQyjhEYiT
	 BPRbNUJr+hNG17Ga/Bv1ZfZ98xVyonIB6s74lZKbFLnW54xKC6X54r5JVb6YT5p23r
	 NPFUgJajT248hblpnwoC3tWCtY/rpz2m6t+osEWGjpIw3lxjEBOnYU2MB1GQ5lUY1c
	 DxP0nUHM0bb7scYXkcY7eFsLBNhizcU4gMXR4ZVghI0qas6DoU6zqrsfVy093RaHXd
	 s8gryfL70faLnBRbE9zBQrdapKc6ndIRbiFxTLyg9ZOgfMDtoBLV5/UNy50800565u
	 JdmC7VXAjwK3g==
Date: Thu, 7 Dec 2023 15:43:36 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: kernel@collabora.com, stable@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, Gregory Clement
 <gregory.clement@bootlin.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: armada-3720-turris-mox: set irq type
 for RTC
Message-ID: <20231207154336.5bf6272e@dellmb>
In-Reply-To: <20231128213536.3764212-4-sjoerd@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
	<20231128213536.3764212-4-sjoerd@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Nov 2023 22:35:06 +0100
Sjoerd Simons <sjoerd@collabora.com> wrote:

> The rtc on the mox shares its interrupt line with the moxtet bus. Set
> the interrupt type to be consistent between both devices. This ensures
> correct setup of the interrupt line regardless of probing order.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Cc: stable@vger.kernel.org # v6.2+
> Fixes: 21aad8ba615e ("arm64: dts: armada-3720-turris-mox: Add missing int=
errupt for RTC")
>=20
> ---
>=20
> (no changes since v1)
>=20
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 9eab2bb22134..805ef2d79b40 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -130,7 +130,7 @@ rtc@6f {
>  		compatible =3D "microchip,mcp7940x";
>  		reg =3D <0x6f>;
>  		interrupt-parent =3D <&gpiosb>;
> -		interrupts =3D <5 0>; /* GPIO2_5 */
> +		interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>; /* GPIO2_5 */
>  	};
>  };
> =20

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

