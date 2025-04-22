Return-Path: <stable+bounces-135121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F409A96BBC
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2255E189D950
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF31281352;
	Tue, 22 Apr 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="C4zXWLtl"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B087B27F4E7;
	Tue, 22 Apr 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326897; cv=none; b=bK2fstjg2Aoti3SD9PiRNRD2Z+FqN7ONo6gvKz8Jd1KKbW6viKbgU7XZlJgydZsCq9UjZivVwb1bC/3AxzTmRq84/KnYh+MM9T+zeI+4a3zUZbSwIEhOW/yjO3dbqR8RDOmrk5DrlwGpVOArhyn5FSWZtRntevB2afljy+4PeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326897; c=relaxed/simple;
	bh=5LMGE4ZovaTauFyhzyyvbLqIw01XMG3sYlgkOB3VihQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLUe3Dv17eE9FHMK2dJb8Vn/sZJG+2GglqVTTAwb+EmVso0YE0SyUtN8I9mbgQD6wKDcl4h0AH5JyZo/jgx21FgYvmh+TSDzInMSwZKhT/a+BSP5kP8PMJXl7xn82PkDsSxJgqC59mEXpxIjtKoOMJ9lYewwo+eiYVsY4BycoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=C4zXWLtl; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 072081F99E;
	Tue, 22 Apr 2025 15:01:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1745326891;
	bh=vjca4SS0LDQaoBRT4ZcgCIXZFJwOWWihMEoq+jbhB/o=; h=From:To:Subject;
	b=C4zXWLtlL3y67SU1zoapsx4icmhYWhMeUCN1+Dr/K5iofMbMRwqEtYbmtBr/diRVo
	 WBE7GTpJmG2QiK0IiWCQR+sBO95Wu/XMZqT6cVREWWdTfiKoaOMx18iYPMhkBEHHJh
	 j4EgkGVlI2GS962j1yky/mfJsEYSkOjKlwNp6MyiEGtnt5ZhHoJ2zRBSjvcWpbb9JG
	 OYeoQ+x1QMIDpEt8MJb2319XF5JN675YzWIgbL19PiUSvUrMpLYcZo6bZPPhLBakhf
	 NHWnuz9c5a50LpziXXGaZCwd8NrQzZRH8U6dodWuS92/Rqfvem54ZP788P3RdrB76K
	 vbkzG8mEnNLhg==
Date: Tue, 22 Apr 2025 15:01:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Message-ID: <20250422130127.GA238494@francesco-nb>
References: <20250422124619.713235-1-Wojciech.Dubowik@mt.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422124619.713235-1-Wojciech.Dubowik@mt.com>

Hello Wojciech,

On Tue, Apr 22, 2025 at 02:46:15PM +0200, Wojciech Dubowik wrote:
> Define vqmmc regulator-gpio for usdhc2 with vin-supply
> coming from LDO5.
> 
> Without this definition LDO5 will be powered down, disabling
> SD card after bootup. This has been introduced in commit
> f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").
> 
> Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
> v1 -> v2: https://lore.kernel.org/all/20250417112012.785420-1-Wojciech.Dubowik@mt.com/
>  - define gpio regulator for LDO5 vin controlled by vselect signal
> ---
>  .../boot/dts/freescale/imx8mm-verdin.dtsi     | 23 +++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index 7251ad3a0017..9b56a36c5f77 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -1206,13 +1220,17 @@ pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
>  			<MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5		0x6>;	/* SODIMM 76 */
>  	};
>  
> +	pinctrl_usdhc2_vsel: usdhc2vselgrp {
> +		fsl,pins =
> +			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x10>; /* PMIC_USDHC_VSELECT */

This needs to be muxed as GPIO, MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4

Francesco


