Return-Path: <stable+bounces-136653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56055A9BE32
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 07:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC383BCEA9
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4A22ACDA;
	Fri, 25 Apr 2025 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="yuheSb8h"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7E22A4F3;
	Fri, 25 Apr 2025 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560385; cv=none; b=VlAjthhqzQi9joWmXJBk9vUZdE98uzCWO6fr5/xKWXwQROLagm9Oy/KOcGadV6SeJqnj0WHelkL0M+mXcvEjEMPZmES9pY8z62MSuouqJs2SYuaRWtJCWJLRR7/6pliZHABOMbxvyt1cbqEKH4VXJb68IcKRhSFfFVN3JFa0pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560385; c=relaxed/simple;
	bh=7ZvFXhNY8gnq82v3dNyEoFqX8xDYnTNWAxehS3YFPz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNpss5LTO8y8Rffo8MX0WjoLpK2IZSU8B5ZF+JGuWY1roW5PMt3xIwSNlIL2E78brpa2XAILUk2btXK0pNuk2ccfonkKtZ1TPGz8cTJEP/f04Qnmzej4xQ30W2srv+qsDD7vwGCL3RmrigrW7DWWndzCfIOyG8AzQtOkzEvar64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=yuheSb8h; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 083881F944;
	Fri, 25 Apr 2025 07:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1745560373;
	bh=UyQprxTrTzeJEuddDXNiYr4ctzPhYLZ6Cp5WEsAgS9s=;
	h=Received:From:To:Subject;
	b=yuheSb8htIWbOcxaC4uxXuHyj0CX6UJYao3KmcRicGjt3irM9wHqvMVjc4T3ol8NN
	 rK8IkJo+Hm6qk+L8FoHUQyue8CZ6yn/iWFiuJpYoulREypk49UYHf+O89rHlwEq5yg
	 XRM1O0COTqgzcgB2kIwV76mGvhoZzqLZgcb8sZ5G7LnHokIOPXrIiyng+16M8qZlDr
	 kiFJENmxo9Y2jfp9BZB9mbgU9j0XWjyNvpSENR+D9OfPCrw1tHKGAEcE89y/IPahTh
	 Mgigt1E8PCarR6soLXSVo4hGNQh+DKfeUwv6Kszss1GDw6xhYpIOtsqVI4/CzGhpHG
	 mxWZJ9MBSeyVw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 9BD827F94C; Fri, 25 Apr 2025 07:52:52 +0200 (CEST)
Date: Fri, 25 Apr 2025 07:52:52 +0200
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
	Manuel Traut <manuel.traut@mt.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Message-ID: <aAsjNP_2jo-zDeEk@gaggiata.pivistrello.it>
References: <20250424095916.1389731-1-Wojciech.Dubowik@mt.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424095916.1389731-1-Wojciech.Dubowik@mt.com>

On Thu, Apr 24, 2025 at 11:59:14AM +0200, Wojciech Dubowik wrote:
> Define vqmmc regulator-gpio for usdhc2 with vin-supply
> coming from LDO5.
> 
> Without this definition LDO5 will be powered down, disabling
> SD card after bootup. This has been introduced in commit
> f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").
> 
> Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
> Tested-by: Manuel Traut <manuel.traut@mt.com>
> Reviewed-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")

FYI, you can have multiple fixes tag, and to be safe to not introduce regression
on some stable backport because the 2 patches are not back-ported at the same
time, better to have both the Fixes tags here.

No need to send a v5, the tag should be picked up from this email.

Francesco



