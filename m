Return-Path: <stable+bounces-37853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5BD89D530
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55819B22BC1
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 09:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A697EF06;
	Tue,  9 Apr 2024 09:13:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6137E777
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654012; cv=none; b=C75cZQ+AQX4mHuFGajOxsncLQ4F3Doab/30hzNA0cvk3iJkEqZj3+17TR/SPfalhS9+SjZn1fr+KBvN2gioQQLQkqEhPmNf8ShV9E5nj4yPW+0WZUILAhry3TF4GJGUuj73uH6K+4EaEjIIXx0UokogsKtl0R9n9p9Qg1j8wqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654012; c=relaxed/simple;
	bh=DDDP1MRm7J507ibgfXCuV7RGp0XeST5hGJXpspFd8rM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lcp+BzzQxXvWfiVnTfDAQIojE9cQE9HW6szOyjkWkwxIIxojHmOA+ZPDRpP2PlCR8sMmzza7j6/Vd0Zu6RfZmIknfEHF2V6sj8YjX9Z+uC1X2or/wdGzdiL7R3ppKEQ18Y9ofMLPAX6uNOfD92pb4nE5irWUB9aloie17zNoavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1ru7XW-0004PQ-Cr; Tue, 09 Apr 2024 11:13:14 +0200
Message-ID: <9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.camel@pengutronix.de>
Subject: Re: [PATCH v1] arm64: dts: imx8mm: fix missing pgc_vpu_* power
 domain parent
From: Lucas Stach <l.stach@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 09 Apr 2024 11:13:13 +0200
In-Reply-To: <20240409085802.290439-1-ivitro@gmail.com>
References: <20240409085802.290439-1-ivitro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi Vitor,

Am Dienstag, dem 09.04.2024 um 09:58 +0100 schrieb Vitor Soares:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> The pgc_vpu_* nodes miss the reference to the power domain parent,
> leading the system to hang during the resume.
>=20
This change is not correct. The vpumix domain is controlled through the
imx8mm-vpu-blk-ctrl and must not be directly triggered by the child
domains in order to guarantee proper power sequencing.

If the sequencing is incorrect for resume, it needs to be fixed in the
blk-ctrl driver. I'll happily assist if you have any questions about
this intricate mix between GPC and blk-ctrl hardware/drivers.

Regards,
Lucas

> As these PU domains are nested inside the vpumix domain, let's reference
> it accordingly. After this change, the suspend/resume is working.
>=20
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: <stable@vger.kernel.org>
> Closes: https://lore.kernel.org/all/fccbb040330a706a4f7b34875db1d896a0bf8=
1c8.camel@gmail.com/
> Fixes: d39d4bb15310 ("arm64: dts: imx8mm: add GPC node")
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mm.dtsi
> index 8a1b42b94dce..97d0c6d23ad8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -739,16 +739,19 @@ pgc_vpumix: power-domain@6 {
>  					pgc_vpu_g1: power-domain@7 {
>  						#power-domain-cells =3D <0>;
>  						reg =3D <IMX8MM_POWER_DOMAIN_VPUG1>;
> +						power-domains =3D <&pgc_vpumix>;
>  					};
> =20
>  					pgc_vpu_g2: power-domain@8 {
>  						#power-domain-cells =3D <0>;
>  						reg =3D <IMX8MM_POWER_DOMAIN_VPUG2>;
> +						power-domains =3D <&pgc_vpumix>;
>  					};
> =20
>  					pgc_vpu_h1: power-domain@9 {
>  						#power-domain-cells =3D <0>;
>  						reg =3D <IMX8MM_POWER_DOMAIN_VPUH1>;
> +						power-domains =3D <&pgc_vpumix>;
>  					};
> =20
>  					pgc_dispmix: power-domain@10 {


