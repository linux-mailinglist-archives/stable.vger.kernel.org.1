Return-Path: <stable+bounces-135242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B071A98019
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 09:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DBE189FA14
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FDE264615;
	Wed, 23 Apr 2025 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="taM+nq0T"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D292676FC;
	Wed, 23 Apr 2025 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392095; cv=none; b=AJJInJ/ORKTXVnN3zhh8F9HrERwug2zmrB7Oaps5fwwcgGi3jukDwdGmCRYKVw63BsmlnX54Vl9do8cK+OTNAiTHMHW7SykQBS/liFbl0uDZRT+KFaSB5epFYAuSgQkXQ6dJ6pb7j5OUizquV2Ad6yPcNXWwz1lZjc48VzKNfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392095; c=relaxed/simple;
	bh=7mnMqfZJXmRF7AEubXC5Quz0rD3EwGLxnuaIQrs31aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGUuY5DKZgT2tGD3vQDnyxQgxKOnFraMjbQa5kKedVgn7Ud5Rin32RHc0i0UrKgi7kGhAfMawB+IvrGh1tVNEBE1muJbVCkB3ThOtGfTualdYJHe0oAybR4ynjGX6xy5/tpYHt9t2sp0AI8wudSk1IfTElpT3ToKKN+trf+SMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=taM+nq0T; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DB3B91F984;
	Wed, 23 Apr 2025 09:08:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1745392089;
	bh=/0EQyW6sKhsHbEM0FiXvZEMPWbxrVBqoFMcw038Fo0o=; h=From:To:Subject;
	b=taM+nq0Tp+9ii+S0WaDF9seZryAoqKrz/vlplFL9/ZBKvYNh75kCC715TxDFQa+7j
	 C/sGGFpIK77WVU5hAsa96KvTgz0cbCtwlSeMWTZM1eSsgb80787R1TEDZ13sDDM7GW
	 m9Z7zfRZZMUu6acYf0lAsIKp7oi/a6A+Q9yGEc/kyS63x9sEef5+xz2ESa0JVOJ5d3
	 eOdQVUXumLYh6f12oLeAynDGKptfRtEJhUzCj7jMfFXKsVktMRWbgLkMojclU174EO
	 /wrDlZW4ofcXxj2R+S0I3MGfFJcZRhDvsNVCxViB6AMQjgUiz1cFqeO5rPYDOfd35J
	 /6AKlQjxqp/Kg==
Date: Wed, 23 Apr 2025 09:08:07 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
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
Message-ID: <20250423070807.GB4811@francesco-nb>
References: <20250422124619.713235-1-Wojciech.Dubowik@mt.com>
 <522decdf-faa0-433b-8b92-760f8fd04388@kontron.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <522decdf-faa0-433b-8b92-760f8fd04388@kontron.de>

Hello Frieder,

On Wed, Apr 23, 2025 at 08:50:54AM +0200, Frieder Schrempf wrote:
> Am 22.04.25 um 14:46 schrieb Wojciech Dubowik:
> > [Sie erhalten nicht häufig E-Mails von wojciech.dubowik@mt.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > Define vqmmc regulator-gpio for usdhc2 with vin-supply
> > coming from LDO5.
> > 
> > Without this definition LDO5 will be powered down, disabling
> > SD card after bootup. This has been introduced in commit
> > f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").
> > 
> > Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> > v1 -> v2: https://lore.kernel.org/all/20250417112012.785420-1-Wojciech.Dubowik@mt.com/
> >  - define gpio regulator for LDO5 vin controlled by vselect signal
> > ---
> >  .../boot/dts/freescale/imx8mm-verdin.dtsi     | 23 +++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > index 7251ad3a0017..9b56a36c5f77 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > @@ -144,6 +144,19 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
> >                 startup-delay-us = <20000>;
> >         };
> > 
> > +       reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
> > +               compatible = "regulator-gpio";
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_usdhc2_vsel>;
> > +               gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> > +               regulator-max-microvolt = <3300000>;
> > +               regulator-min-microvolt = <1800000>;
> > +               states = <1800000 0x1>,
> > +                        <3300000 0x0>;
> > +               regulator-name = "PMIC_USDHC_VSELECT";
> > +               vin-supply = <&reg_nvcc_sd>;
> > +       };
> 
> Please do not describe the SD_VSEL of the PMIC as gpio-regulator. There
> already is a regulator node reg_nvcc_sd for the LDO5 of the PMIC.
> 
> > +
> >         reserved-memory {
> >                 #address-cells = <2>;
> >                 #size-cells = <2>;
> > @@ -785,6 +798,7 @@ &usdhc2 {
> >         pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
> >         pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
> >         vmmc-supply = <&reg_usdhc2_vmmc>;
> > +       vqmmc-supply = <&reg_usdhc2_vqmmc>;
> 
> You should reference the reg_nvcc_sd directly here and actually this
> should be the only change you need to fix things, no?

If you just do this change you end-up in the situation I described in
the v1 version of this patch
https://lore.kernel.org/all/20250417130342.GA18817@francesco-nb/

With the IO being driven by the SDHCI core, while the linux driver
changes the voltage over i2c.

I was not aware of this sd-vsel-gpios, that if I understand correctly
should handle the concern I raised initially, having the PMIC driver
aware of this GPIO, however I do not see why that solution should be
better than this one.

BTW, is this solution safe from any kind of race condition? You have
this IO driven by the SDHCI IP, and the I2C communication to the PMIC
driven by the mmc driver, with the PMIC driver just reading this GPIO
once when changing/reading the voltage.

With this solution (that I proposed), the sdcard driver just use the
GPIO to select the right voltage and that's it, simple, no un-needed i2c
communication with the PMIC, and the DT clearly describe the way the HW
is designed.

Francesco


