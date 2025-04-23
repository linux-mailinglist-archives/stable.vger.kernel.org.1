Return-Path: <stable+bounces-135254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CE6A98682
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 11:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ABB442B3A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C762266F19;
	Wed, 23 Apr 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="RdqjBWFr"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD224418F;
	Wed, 23 Apr 2025 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402004; cv=none; b=YtMqpllobOX7I10mMMl997EB0yoMf9MDWpooRnpiGhoq0dE4PJvjFrTyPJuF6ByhoFkiTXGnIOYLZBtcbJxgrhyjFXrw0V4HinilR9QeyccfGXDYlp3Dc/eRUFxN/99bs00HE09seRCyjqIk46AZ1xUEWmM0r1VYqj28WgXUelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402004; c=relaxed/simple;
	bh=jgL8SjluoXcb7rpR17d/Vj7uvT2ixl1tLefLrdmLscI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEKS+MxIOchJ0ycxQraRjDQZffHz7wAfi+yHZ4fHkPG6M0CytrbLLbxlz/yGzoxMu8OPr8A1czjQaA0pUt5YxHFKv8zmbJNsPgnI4dpJkIxFrjEP++VxVgNYr1fzu2TZGbAgL10ooymhRtwxIpEhbMuj0ypbum9OfQE8g0Qselg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=RdqjBWFr; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0D00A1FBB2;
	Wed, 23 Apr 2025 11:53:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1745401994;
	bh=xvcoD3y8NoexvOIek6+LRfEIrItF4nd0tICSSnTeRa8=; h=From:To:Subject;
	b=RdqjBWFrjmAuSZbTg6HbYJ+YfXO46LD0pH6r1s+tXcT4RCH0E5DT/Udc3GeUOyXy8
	 c6hGcrzbdkDQRf9OUz9vrot+FrXvm7HWbbwASJXJAWvbfVZ20kqytS8tSUhRh8DtZi
	 VdnypqPWvz7kRT/cbaiuGQzWsbafWnBnp68KlGU6Yo6KNvjonYHCTHk5LhMGZYLjJL
	 g0vDcCMXfn4f//5jOXo1iG+DW8DSRmFn7HbufrogjdMPh8NnI82pCY5nbmKPqmWeSy
	 MlscygbG3PyIXk0rgkX5HamwQX22CmeaaKsE2iwdY0w14Z5Rj1RLvy3lHOtVfuznX7
	 /K8EcHSOJyq5w==
Date: Wed, 23 Apr 2025 11:53:09 +0200
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
Subject: Re: [PATCH v3] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Message-ID: <20250423095309.GA93156@francesco-nb>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>

On Tue, Apr 22, 2025 at 04:01:57PM +0200, Wojciech Dubowik wrote:
> Define vqmmc regulator-gpio for usdhc2 with vin-supply
> coming from LDO5.
> 
> Without this definition LDO5 will be powered down, disabling
> SD card after bootup. This has been introduced in commit
> f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").
> 
> Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")
> 
no empty lines in between commit message tags, not sure if Shawn can fix
this up or you need to send a v4.

> Cc: stable@vger.kernel.org
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

I would backport this to also older kernel, so to me

Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")

Francesco


