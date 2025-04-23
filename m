Return-Path: <stable+bounces-135258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF467A98747
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779A47A3B88
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614A26A0AE;
	Wed, 23 Apr 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="jjgZ+LnT"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14122561A2;
	Wed, 23 Apr 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404017; cv=none; b=dxgHU0m6ppcFYI8fvxdFCOeskH5CW+j4e7R6Xm85ZDwd8RK+T1Exc0DaqWVHL2VH/1e+0QFBzA84sZaEckx7qJfyjCtg2e5X8K/sFTkITse8qCpCW2lteWrGdUbyLF8uXZzzxPTUUzqyqBFWpnF9EOb/+/aDAffrC3yGKEHzGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404017; c=relaxed/simple;
	bh=+SxBSMk7orLxVFxL8Gww7YOLecKij/zxaEXdo8QiJaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGeWeQQxOWAht7IrLculbxYiqrJHXX1kR6tGzknA28gGUiiDiBfhHbWuSX9JHEXGIIQZmXqozrGcDKvyNSZgmXiyEIlGJ4DXZqpvWS9aWoLYSq1rQ5kwMbP7uROTokmqAP6PIj/RoKdwpijU2HOaPkPr2X5bVbgQ8E73b6HU/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=jjgZ+LnT; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6EFAF1F96C;
	Wed, 23 Apr 2025 12:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1745404014;
	bh=YfVwzaklYqB2yPGJrUhReU1MAXFmWBiktB9H9OnlWHA=; h=From:To:Subject;
	b=jjgZ+LnTi8D+QhEDcCoLzSUblRuMauYhItZqnADRVM14O2rzj11ls30N4onzc9Akp
	 lOTOQ1i/3h8HqOsk2LiCiFju1aGmHdnVJl8VDP5bVbHyjU0mhFk9LNKszMNexjjJZZ
	 rdz0mPsCmMFURLeaVXI9ptj5SaKX/fSXdkmQc/PE31R4OLs9D2CVAWC+eVZgstYWyH
	 iLAP37E2POs5SACE1q8eCs67zEzY6MC66t+QYA4RDFMSS+3AGYMXvHLQCeLoedgXGL
	 CkYeXMmE9YAjF07qOwhaABWRXgMhbG7GohCYNTo8qr8I4Y2aSdMF1GyOJ+Ud3ZdivO
	 6h033Efpnke3A==
Date: Wed, 23 Apr 2025 12:26:51 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Message-ID: <20250423102651.GC4811@francesco-nb>
References: <20250422124619.713235-1-Wojciech.Dubowik@mt.com>
 <522decdf-faa0-433b-8b92-760f8fd04388@kontron.de>
 <20250423070807.GB4811@francesco-nb>
 <17ec22a0-b68b-4ac5-b2bc-986837639a37@kontron.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ec22a0-b68b-4ac5-b2bc-986837639a37@kontron.de>

On Wed, Apr 23, 2025 at 10:00:22AM +0200, Frieder Schrempf wrote:
> Am 23.04.25 um 09:08 schrieb Francesco Dolcini:
> > On Wed, Apr 23, 2025 at 08:50:54AM +0200, Frieder Schrempf wrote:
> >> Am 22.04.25 um 14:46 schrieb Wojciech Dubowik:
> >>>
> >>> Define vqmmc regulator-gpio for usdhc2 with vin-supply
> >>> coming from LDO5.
> >>>
> >>> Without this definition LDO5 will be powered down, disabling
> >>> SD card after bootup. This has been introduced in commit
> >>> f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").
> >>>
> >>> Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

...

> > With this solution (that I proposed), the sdcard driver just use the
> > GPIO to select the right voltage and that's it, simple, no un-needed i2c
> > communication with the PMIC, and the DT clearly describe the way the HW
> > is designed.
> 
> Yes, but your solution relies on the fact that the LDO5 registers
> actually have the correct values for 1v8 and 3v3 setup. The bootloader
> might have changed these values. I would prefer it if we could have a
> solution that puts the LDO5 in a defined state, that is independent from
> any external conditions.

I do not think this is a real concern, the PMIC is programmed during
manufacturing, if the PMIC programming is not correct we have way more
issues ...

Francesco



