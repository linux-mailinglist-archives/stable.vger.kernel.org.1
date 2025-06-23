Return-Path: <stable+bounces-155301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36165AE35F7
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DCC1705BF
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0831E261F;
	Mon, 23 Jun 2025 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OaU2DLIa"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8731E8324
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660908; cv=none; b=MN+pM0wjEeCYf40/oWe8dcXWOW5iffVVpaS58HdMKoseDPFVPoD3k8dWR3o4cOphFIugsCLhxn2ENjQJh3bqwUs17f7Mbd/nQacvSPXPvDL5HwuGsmorniC2FnxqxJvi0w7Sc4WqYEfIsQQhsS6vcbfY8X9qG95A/2AVC/YXE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660908; c=relaxed/simple;
	bh=LB4oyVTpLCaiEWCy+fk6tCbYw2++tKJbaBq/0UJGbXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XS7tQ4ii+7GR2Dw5HI1nXTjsAvVA9Ty27opzw2j87io8GTyA0QdNhnujslfQkvr0iG5k/KXerjskABwkEpzD2xT8PowV4mYZfloO4EVJX86c9w6pXwipTFg5ITSzBGtGVc/ruRYKs/s7ymjBPnck6wSu3OhrOzCEXAN04UdVy/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OaU2DLIa; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id B42521FA9E;
	Mon, 23 Jun 2025 08:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1750660897;
	bh=P4VY0Ku8UYAmClA1iVtBk9nLVcQ0Z5Yu7AkLFRkF3fQ=; h=From:To:Subject;
	b=OaU2DLIavBehEXG2Fczs94N5gsZGKYRXMp+jBgRkSPQCybVLg+PDt+9Be71MdBSf6
	 WWO4Imrz10O9tdK6p8HovDurFhyF3Z3H/0OzaBSPo7hk5TP27He+GDIMUWya+CFGKN
	 Cy4eA5bvZy9vnSN0D/KhQCczB5Sro6iM6AwWzH60m4uNhwa8+Xp2bTYOYEItnwY3jU
	 KpYqMROZYXon5g9oKXGegBgS0cZUiJz/0Usv1n5R80ud6h5/ySnRTjx0CKgfd0sAmD
	 ojAvR4yavoVdXbqxpxkyv/HY0+9RfV5tmOlz13p3Y5RVX4hD7qUlfnJWHyTljdmWVO
	 ku1i17K1N983Q==
Date: Mon, 23 Jun 2025 08:41:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
	patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 6.1.y v2] arm64: dts: imx8mm: Drop sd-vsel-gpios from
 i.MX8M Mini Verdin SoM
Message-ID: <20250623064132.GA7788@francesco-nb>
References: <20250604212401.8486-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604212401.8486-1-francesco@dolcini.it>

Hello Greg,

On Wed, Jun 04, 2025 at 11:24:01PM +0200, Francesco Dolcini wrote:
> From: Marek Vasut <marex@denx.de>
> 
> [ Upstream commit 8bad8c923f217d238ba4f1a6d19d761e53bfbd26 ]
> 
> The VSELECT pin is configured as MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT
> and not as a GPIO, drop the bogus sd-vsel-gpios property as the eSDHC
> block handles the VSELECT pin on its own.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Just a short ping on this, to be sure it gets queued for the next 6.1
stable kernel

Thanks
Francesco


