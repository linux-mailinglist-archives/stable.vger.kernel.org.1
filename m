Return-Path: <stable+bounces-52341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B7490A2C3
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 05:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3B2B225EC
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 03:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172E17BB0E;
	Mon, 17 Jun 2024 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="itNHF3WN"
X-Original-To: stable@vger.kernel.org
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C30E17836E;
	Mon, 17 Jun 2024 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593664; cv=none; b=fHYs9Yk97aBLHmf1MJ2WRY05PGyip54PbAAa4gjvdfQnokH5hRZVDhbjOItIUJVd61WTKmpwMofGP+LYpj3l+R8RgKNimxnDfbpcBDedRqrHvtZH12EGIucXYL0RB85UMYjKB/FF9khwZ4oZ9hKBb0K116AWDhft8gBZaNFs8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593664; c=relaxed/simple;
	bh=ydoTgJNMMX84E4KjLxRaVOdRrOiJsrr+xE//CuFsDIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2USE0BGOwp3YhEXlU2kka3nzJr8jM8Z9MV/oZT0HnHRT97Rf1/eVHDScFIBg5BqrMN+gWcG2DPVWjk625r5BObGmB/k2VChpvotZDfBZFFvWg+rXwDpYCY7gjJ1o+pJ5HmJqsZP4thFC9uLxJXqBopYYtPix/ufAIy7kmSY1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=itNHF3WN; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=tHzM5zaP6Mt9u5Dne4qRg1Vlkhass0prrTVHtlQrb2k=;
	b=itNHF3WNnyeW9GHLCcZSWv00DC3VjXpRXpZDN59YI3unuI6Guf4IG/UbwEpLyW
	Qnkz0LVyLaUxTNkDly7xlSUdFhpsGLWWqxwNEmiCBFuPHFAyb++5SVOI3XFeuYLi
	7j6CROEDGH6+vBPb1MxfsTvoaDCNRBbMt+4OY7gh6CjQM=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrADnTfplqG9mcs4MCA--.42055S3;
	Mon, 17 Jun 2024 11:07:19 +0800 (CST)
Date: Mon, 17 Jun 2024 11:07:17 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 8/9] arm64: dts: imx8qm-mek: fix gpio number for
 reg_usdhc2_vmmc
Message-ID: <Zm+oZbNwKzAzul05@dragon>
References: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
 <20240614-imx8qm-dts-usb-v3-8-8ecc30678e1c@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614-imx8qm-dts-usb-v3-8-8ecc30678e1c@nxp.com>
X-CM-TRANSID:ClUQrADnTfplqG9mcs4MCA--.42055S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3jg4DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBQgBZVsVCpzaawAAsA

On Fri, Jun 14, 2024 at 11:06:32AM -0400, Frank Li wrote:
> The gpio in "reg_usdhc2_vmmc" should be 7 instead of 19.
> 
> Cc: stable@vger.kernel.org
> Fixes: 307fd14d4b14 ("arm64: dts: imx: add imx8qm mek support")
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


