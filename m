Return-Path: <stable+bounces-136786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E22A9E364
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 15:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B443D189F60E
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 13:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DE415A858;
	Sun, 27 Apr 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gFF+/ZQY"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6DC14D428;
	Sun, 27 Apr 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745761990; cv=none; b=rM/nuy0E0wAHljanmbTJSfcuwgzrHymb4xV0clhPIqDtYJCSb5Tcoq1qOGzYr7F0l22fL6xNEMRZj+uPLFZJTKY/pZDNIiqtUjDir4rRnvrMYqCilFS2YQqcRvhINv70XLcHq29rt/oLUqJMXZMxPp5wiqDar1tL/l+tZYe7zSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745761990; c=relaxed/simple;
	bh=UoIHPJ4depb+g8pAi0LtyZ8iSz2y4kJvvn2d28X511c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqRxJeTTHpIHr4KFOHEpwF8ByBhxaMaVcVh04NDaw7kc0BifD/5nDlZPP+1KJOJVJngEdiSE/lWYkaGitLFphDKGU6Y0lOS8NT5fa45aZnHAzQIkkj7/XRmAWj28TnY/KQYbbD4uZr2yGZ9QesDeQ9SIN7PpAG3xC9lQ8+0Bugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gFF+/ZQY; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=i4Fnrl096oXKF65tzuRQZ6eRc4onRrFK13fpUbFl9Pk=;
	b=gFF+/ZQYa5fCAE5KYgEvYnr15hbTuWaIQYDpVPvL4hRk4V75FQLpe+wAQEgPJs
	YjpTRhGSpOLJ5Z9JvtLRSAEEfwa46u3/q+ui6qPzsEK6LgcWMoyhNHYpdNQrLA9x
	HYLSj8IGOSJx6x5e/WjQ3RhzPf6vGoqR5qlspjLDq2Ly8=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3p0tlNg5o4Vb3Aw--.41011S3;
	Sun, 27 Apr 2025 21:51:35 +0800 (CST)
Date: Sun, 27 Apr 2025 21:51:33 +0800
From: Shawn Guo <shawnguo2@yeah.net>
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
Message-ID: <aA42ZS8xeyDi9xNO@dragon>
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
X-CM-TRANSID:M88vCgD3p0tlNg5o4Vb3Aw--.41011S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4UXFy3Jr47JF4xWr1Dtrb_yoW3uwcE9r
	1Fkws5Xr45Wr45Cw45tFnxZF48G3W5Kry3try29rZ5Ar95AayDJFn8KrZ5Zr43WanIvF9x
	Z3429rs5trW7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8GXdUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwA8ZWgODbOJNwAAs0

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

Applied, thanks!


