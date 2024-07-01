Return-Path: <stable+bounces-56246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D391E25E
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D458C1F2676B
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1111662E6;
	Mon,  1 Jul 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="OGuAEcFE"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD53D3BC;
	Mon,  1 Jul 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843975; cv=none; b=L/EzaYf75hE1ub+V1ptg7Ho3WhEHJIQkAMp59jJpMyEsun3NbONoyPAT+6wYDPmJT7T6or48WbMHQvudQoRUj4WLvhMK6Y9XIBvpSPHn6wbTSm/PwDZ2REhuM7IyQavW9tpgjng+ki3Z6w5ADKnMBy6ZDgUWV4yjGqPtDqy0zbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843975; c=relaxed/simple;
	bh=tyXUokv7xNpsIGSP5ELpRgNWICH7u18dUF/zNyymBmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdSNGO7qGuAPZTeqUpADbFLlgjR1KieDZrJitiRKOwDpyOG8ZWF2cILB6jAlECKQHVfvjPeSx6QViL1e2/FiQ5wOXezgWzCwPce7WX42U0JvG6a6xV0+XPFZZU+QWHU2D5krdAylaoxyaKeAu185h4U+5bu4WWt2p+e4yL2IV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=OGuAEcFE; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=dEno6mHhFR5G5j7SXntEr/1pWDtwK/8nwORwa7dpaH0=;
	b=OGuAEcFE6XaT95TB6J5r9c+FrJnA68Ii+Guzble791M+e0Pa2/5cHuhus/rNwb
	BP5kMVNDNdCO7JFJOrgp7QigMfOZrhnfG8IkBKpbAyckwVsImjrJ3bTVzOAtdL8y
	5BOvg5WgTbd3BPf197hD8PmPhaiYBo5G6nHRLWF5cw5MA=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3vwxavIJmPmcCAA--.6190S3;
	Mon, 01 Jul 2024 22:25:32 +0800 (CST)
Date: Mon, 1 Jul 2024 22:25:30 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/9] arm64: dts: imx8qm: add subsystem lvds and mipi
Message-ID: <ZoK8WsnqxfIo6tAp@dragon>
References: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
 <Zn0R2/lcgcSG03CM@dragon>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn0R2/lcgcSG03CM@dragon>
X-CM-TRANSID:M88vCgD3vwxavIJmPmcCAA--.6190S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4DWFykKr4fKF4DuryxGrg_yoW3GFb_uw
	4aqF1kCw1UJw4fG3sYy3ZF9rWUKr92yr98Wry7Ww1qqr17Z3W0yF9Yqr4ruryktFWSvF4D
	JF4Yqw4xJr45GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0zT5JUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRwPZWZv-dtTeAAAs7

On Thu, Jun 27, 2024 at 03:16:43PM +0800, Shawn Guo wrote:
> On Fri, Jun 14, 2024 at 11:06:24AM -0400, Frank Li wrote:
> > Frank Li (9):
> >       arm64: dts: imx8: add basic lvds0 and lvds1 subsystem
> >       arm64: dts: imx8qm: add lvds subsystem
> >       arm64: dts: imx8: add basic mipi subsystem
> >       arm64: dts: imx8qm: add mipi subsystem
> >       arm64: dts: imx8qm-mek: add cm4 remote-proc and related memory region
> >       arm64: dts: imx8qm-mek: add pwm and i2c in lvds subsystem
> >       arm64: dts: imx8qm-mek: add i2c in mipi[0,1] subsystem
> >       arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc
> >       arm64: dts: imx8qm-mek: add usb 3.0 and related type C nodes
> 
> Applied all, thanks!

Dropped the series due to the warnings reported by kernel test robot.

Shawn


