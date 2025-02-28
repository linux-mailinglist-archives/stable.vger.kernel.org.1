Return-Path: <stable+bounces-119938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C66A4998A
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7AF188966A
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DBB26E165;
	Fri, 28 Feb 2025 12:38:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38D26D5C9
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746309; cv=none; b=DV/C7UFWaNq+fbOadC7eaDbuy2DDw9xk4MS6diH1tHTv6sXbwTLJC90+XJjcVbHZD+Q9D0iUTwAhVR6gSChZxC8c7f1RSGgXSIOjnTLJlEsX7kgzN3b7/TA0Ch8oDqORzEVCa0h3IoTXBvjLy8P+7IJ6XR1btRHBHghNYfp6suQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746309; c=relaxed/simple;
	bh=mka7v9dOIXrR8ujDVY8H8EAYsXt6YV5/tGysz30JByQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dzAGIEOxHHAKqap9NnIUIeQul/vYETMXc3uVI7RVffKdHd1pIiG/LR+ozfs7cnNahDLtEsZZ1+fCAlVPBLIVWTXROCsdWXEE3zdQIMD/UUReDoOq7RLc90mekRfCfWTBebjJvgfizjw9K6Lzouo6lCU0jCATJ4cQr9/Aq3pvhIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnzd7-0000HS-GM; Fri, 28 Feb 2025 13:38:13 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnzd7-003IP3-0u;
	Fri, 28 Feb 2025 13:38:13 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnzd7-0007DC-0c;
	Fri, 28 Feb 2025 13:38:13 +0100
Message-ID: <77fc8298ec2c214cef39c956bbf484b6229888f3.camel@pengutronix.de>
Subject: Re: [PATCH v1 2/2] phy: freescale: imx8m-pcie: assert phy reset and
 perst in power off
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Stefan Eichenberger <eichest@gmail.com>, vkoul@kernel.org, 
	kishon@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, tharvey@gateworks.com, 
	hongxing.zhu@nxp.com, francesco.dolcini@toradex.com
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan
	Eichenberger <stefan.eichenberger@toradex.com>, stable@vger.kernel.org
Date: Fri, 28 Feb 2025 13:38:13 +0100
In-Reply-To: <20250228103959.47419-3-eichest@gmail.com>
References: <20250228103959.47419-1-eichest@gmail.com>
	 <20250228103959.47419-3-eichest@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Fr, 2025-02-28 at 11:38 +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>=20
> Ensure the PHY reset and perst is asserted during power-off to
> guarantee it is in a reset state upon repeated power-on calls. This
> resolves an issue where the PHY may not properly initialize during
> subsequent power-on cycles. Power-on will deassert the reset at the
> appropriate time after tuning the PHY parameters.
>=20
> During suspend/resume cycles, we observed that the PHY PLL failed to
> lock during resume when the CPU temperature increased from 65C to 75C.
> The observed errors were:
>   phy phy-32f00000.pcie-phy.3: phy poweron failed --> -110
>   imx6q-pcie 33800000.pcie: waiting for PHY ready timeout!
>   imx6q-pcie 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq+0x=
0/0x80 returns -110
>   imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110
>=20
> This resulted in a complete CPU freeze, which is resolved by ensuring
> the PHY is in reset during power-on, thus preventing PHY PLL failures.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie stan=
dalone phy driver")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/fre=
escale/phy-fsl-imx8m-pcie.c
> index 00f957a42d9dc..36bef416618de 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -158,6 +158,17 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
>  	return ret;
>  }
> =20
> +static int imx8_pcie_phy_power_off(struct phy *phy)
> +{
> +	struct imx8_pcie_phy *imx8_phy =3D phy_get_drvdata(phy);
> +
> +	reset_control_assert(imx8_phy->reset);
> +	if (imx8_phy->perst)

This check is not necessary, reset_control_assert(NULL) is a no-op:

> +		reset_control_assert(imx8_phy->perst);
> +
> +	return 0;
> +}

regards
Philipp

