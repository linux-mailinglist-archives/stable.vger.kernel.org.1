Return-Path: <stable+bounces-72631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B43967D1C
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 02:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9432D1C20DD6
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 00:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7358BEE;
	Mon,  2 Sep 2024 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="IiMxtUUI"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283EB4A29;
	Mon,  2 Sep 2024 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725238641; cv=none; b=oHvd3ife8h67wF3graksmpb72qCz26gVErPKNmbhFxl9Pq404Aj/n75Uu1zY9YakYBSNtjFvCftyPpDxi/K5tsrGrrWEaf60ktoMfhXw0l7i7RmasbYQg3JWhogixp50t5P0WseMdj25svrBn/y9K98l5l2boZYarRPHufi+kAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725238641; c=relaxed/simple;
	bh=MaPmVxulV2klEvBUto/0dUhphxIMQveDnJvQ339rxus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3nL4qQfec6jpIMI9NhjsT+17d9LMe25y1xFqvkpcs2lEHjGDNUVdNOaK+6emK2H8QlFqxQ51T9Cw+IxOlCC32LGa0DnOxFsRz/1b4LBFY4HD9r5iEdrL3ELlov/Pl8OrxbA6A88lt09xSoct/pYqxoP/br4cCR/0Q6YTlkZEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=IiMxtUUI; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=XGVn9bbamNrnXSoS6civZQ68s+RVUPDpsuvPeT4kxqY=;
	b=IiMxtUUI8nB/BA2sbwuzz+X9VTvc8ZV4bGhIRBbphXsAns2dqUx8bbULnKPWBt
	nQGHv+WmFAyAPKcoulVrUjtEZvBC2OTSxyLuyyXGZoqLl6TvoqcZm5CrgvgKUBVs
	WgIVdBFAEz4utKTVxBL1eFLd+A0d3ivpzgMicpkAe1Svc=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3t0MZDdVm0ZxMAA--.30459S3;
	Mon, 02 Sep 2024 08:55:55 +0800 (CST)
Date: Mon, 2 Sep 2024 08:55:53 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul-geam: fix fsl,pins property in
 tscgrp pinctrl
Message-ID: <ZtUNGdH3U4HbN2ok@dragon>
References: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:Ms8vCgD3t0MZDdVm0ZxMAA--.30459S3
X-Coremail-Antispam: 1Uf129KBjvdXoW5Kr45WFy8Jw1fJFy7Wr1fXrb_yoWxXwb_CF
	y8Ja4xXwnrWr92qw1xKFs2vr929a18AryUWrW0vFsIgryak3yUZ3yfJry5Kr90qr45uFyD
	J348WF1DWrZ7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0eyIUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiER5OZWbU5TRObAAAsl

On Sat, Aug 31, 2024 at 12:11:28PM +0200, Krzysztof Kozlowski wrote:
> The property is "fsl,pins", not "fsl,pin".  Wrong property means the pin
> configuration was not applied.  Fixes dtbs_check warnings:
> 
>   imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pins' is a required property
>   imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pin' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Cc: <stable@vger.kernel.org>
> Fixes: a58e4e608bc8 ("ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL initial support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!


