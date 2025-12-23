Return-Path: <stable+bounces-203282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 086E4CD8756
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 09:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 617A530022EC
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08D2E764B;
	Tue, 23 Dec 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LsYd986y"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ED731E0F2;
	Tue, 23 Dec 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479063; cv=none; b=Bqp9MNyAVDj4yGF9T4q6n5HTmvcmunl8erYN5OPV8yCE1FeVmir2Zo6d7wxvr0yAsGUU+lQ2E1ToXUFD4eT37FEo8dIiSI4ef03yQGsSu5nT9v0j0VfL3OQc4w9W1ZVqUKM2vwzzpH5rRtVCghqj+X/p+uhF9iGtXjghcB2rDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479063; c=relaxed/simple;
	bh=oxyTSW6SlyYi5vFKMdQTkvBu2VeRUTuVVBWtB1TAfGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHGNiFdIBOjV67GgUPsCd1Yuxk/uTcOPZMpwi3wM6Aa2qM3BzTcUm6/hFfM2nlI6+ng8rnbYTIO92UKFuSiZIEm6BpojwYHD+g9Suc//h5c3o/RL7ucdr5VPJXo6aOXWI0vttSXyyNhOg1ar2l4w8Bbaypv1R0tR9u9n6IgFJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LsYd986y; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 75CBB1FA65;
	Tue, 23 Dec 2025 09:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1766479051;
	bh=8wuJHDWjaGLzXiqjbQ5KAqwu4/yLolE49hadsWsYnko=; h=From:To:Subject;
	b=LsYd986y7/LfVxODKxkxdM5aXB2gjX4iwNaf0oAmaFBcA197ohCba+C/DTd+oNO3d
	 RX5hKR5by9NkKfnrqcl+PO9rReCmhnjQjE4m0y33VaeGEnOnq7z9BRs5sSACVuirwr
	 YDT03Mt88p5bq+wC414JpVEPkhTfc4I79FhXWol013I/HDFqn4+9w2e/Edd+Iv6a7l
	 kVOhu6KtDki1QAow1qszh9uwE8ML5JWW0F81RQ0XwyV0HFc9bh9a6L6bHBJYCQkc6s
	 Felrmzyst9VlG97uAQTOzRuDAauh8hWzE/KInMbppa+9EYZPDiHQ4AlbHlQjVR44U2
	 c7TrSQpvl7Rig==
Date: Tue, 23 Dec 2025 09:37:26 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vinod Koul <vkoul@kernel.org>, Franz Schnyder <fra.schnyder@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Franz Schnyder <franz.schnyder@toradex.com>,
	linux-phy@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, stable@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v2] phy: fsl-imx8mq-usb: fix typec orientation switch
 when built as module
Message-ID: <20251223083726.GA24283@francesco-nb>
References: <20251126140136.1202241-1-fra.schnyder@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126140136.1202241-1-fra.schnyder@gmail.com>

Hello Vinod,

On Wed, Nov 26, 2025 at 03:01:33PM +0100, Franz Schnyder wrote:
> From: Franz Schnyder <franz.schnyder@toradex.com>
> 
> Currently, the PHY only registers the typec orientation switch when it
> is built in. If the typec driver is built as a module, the switch
> registration is skipped due to the preprocessor condition, causing
> orientation detection to fail.
> 
> With commit
> 45fe729be9a6 ("usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n")
> the preprocessor condition is not needed anymore and the orientation
> switch is correctly registered for both built-in and module builds.
> 
> Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
> Cc: stable@vger.kernel.org
> Suggested-by: Xu Yang <xu.yang_2@nxp.com>
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>

Just a gentle ping on this.

Thanks,
Francesco


