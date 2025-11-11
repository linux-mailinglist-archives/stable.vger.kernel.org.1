Return-Path: <stable+bounces-194455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB56C4CCA3
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF5E42202C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9D2F39A5;
	Tue, 11 Nov 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ckeyb71l"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85A2EB872;
	Tue, 11 Nov 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854464; cv=none; b=i9/5Qa37yNClkjM8cZC/YsR9wXfDkiggRKVqEhxldsFinAciJp9+NZIaEO38VtqS/5mnhGWxWxxFIFJVnDxN0+wwddkGcnOOMiMXYzD0tKZD1SLmGng8C5g2NhpHLa+MTfwvlb0kiQujexlGVOq02ib3eOAUXQc15NgVE++BNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854464; c=relaxed/simple;
	bh=ohd9pdrMVmles/05qOjVwCvl5qGyPbg0cYR2z6zquEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvx+I3tB5NEWv7+EZY91P+ayT7wtOlhziDUP52MULS11U8EbsJQ+11uQ/gWMzqvGqzX8kC/hdoV5F9i+uL/X2YtOw/gBiHUJOYgrt0LsSWTnElQ0Mebs0n+S6E6WA/2BV8Ly23Y258sPrTs1R7TY7yUYDG0pBpgfLpYGCiizLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ckeyb71l; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=XXkLRI0g65UAMkaqYzjM8MbTk3dgR2IEiJk+nolN7Bg=;
	b=ckeyb71lGo1/OFEuPgVLJStCZXixLHM+k/OiY2qCmam22s5Ibto5T8vJmY9+uA
	mqwDfDtUWt4jPNk9QznDPQI1kFNRPYu2aqFQ7cywpCMeqKgm77825GZhDvxu8xFl
	ExtOiDMCJ7yt0zS/XHOrHDl7cC7lqoop7Y0uGiHIe4y2Q=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDnLZcKBhNpcL_DAQ--.5228S3;
	Tue, 11 Nov 2025 17:46:52 +0800 (CST)
Date: Tue, 11 Nov 2025 17:46:49 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Maarten Zanders <maarten@zanders.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>,
	stable@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: nxp: imx6ul: correct SAI3 interrupt line
Message-ID: <aRMGCbDMDkasXMlU@dragon>
References: <20251024142106.608225-1-maarten@zanders.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024142106.608225-1-maarten@zanders.be>
X-CM-TRANSID:M88vCgDnLZcKBhNpcL_DAQ--.5228S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYJPEUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNgyjCWkTBgwY6gAA3S

On Fri, Oct 24, 2025 at 04:21:06PM +0200, Maarten Zanders wrote:
> The i.MX6UL reference manual lists two possible interrupt lines for
> SAI3 (56 and 57, offset +32). The current device tree entry uses
> the first one (24), which prevents IRQs from being handled properly.
> 
> Use the second interrupt line (25), which does allow interrupts
> to work as expected.
> 
> Fixes: 36e2edf6ac07 ("ARM: dts: imx6ul: add sai support")
> Signed-off-by: Maarten Zanders <maarten@zanders.be>
> Cc: stable@vger.kernel.org

Applied, thanks!


