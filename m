Return-Path: <stable+bounces-118643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A805FA40448
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 01:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC8217F95E
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 00:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8F481C4;
	Sat, 22 Feb 2025 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGuNNBiZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33C3597D;
	Sat, 22 Feb 2025 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184725; cv=none; b=VI9ciA3A02P+kwf0H6/fB8ud65dpLjBSK7Eoe7Ii4XV5R695g2fMlIe7JXhhW9TtLYha608oh620u2mhqb3w3xmgnwuwG0+6VhmfZHeXI0hTiE7euoiBIxZjnEqI98uemuqORJFOd7hTGBwEgQlQ9vAsRF9T++ku1i2OJ7NYBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184725; c=relaxed/simple;
	bh=FQ2i0wx4TGUTjsWy2c0bZNoWOkyscg1zzRkTcOHmSi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPAwx8aZSFIH5VOyW1BRRGaX8SrOQPoFAlBMsXHY2EeWqM6swcp2tHQu+JfU8LVqE9OIvsDO8CNULNCcn1Vb5XuocR/MFCfrQVobDoirFoT/oeroTJjCGBlnodwNJv53tLiQYROoRUprcrIAHwnevAJAJX6PPQchhRnU52d5FSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGuNNBiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4731C4CED6;
	Sat, 22 Feb 2025 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740184724;
	bh=FQ2i0wx4TGUTjsWy2c0bZNoWOkyscg1zzRkTcOHmSi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NGuNNBiZcujTvg2vGTQMV1HJz8aJPA3l4fuod5f7gzqx/YPxrdXwR/sqVQZ9dA2MG
	 6uvM0N98xnGFLvBdlfJF1j8NKW9re/MTh/MrRD2Qm53xQqOKrjdWL9w9IPctm1MFag
	 paIJjNuejhsoVoznJJ6ZMIMwKSjJpGZtG97biBu16Xr6wnzjkAZHimqiZsfQDwzTbF
	 LAg2ApM/FtH43YFeTcldqvhgE86lS4FBSTQ/+4qsrT3Uy2wUUWH5fg8guJAYFQ7jLQ
	 pdZtz8PZQhjx0v/IQwQBKcYPuiX02x4m5jZu5u7aIXMj/YdCBkYoH0pXVQC/2iXsSV
	 bowAQUVgDxZ7g==
Date: Fri, 21 Feb 2025 16:38:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai
 <wens@csie.org>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [PATCH RESEND net-next] net: stmmac: dwmac-rk: Provide FIFO
 sizes for DWMAC 1000
Message-ID: <20250221163842.04863ba1@kernel.org>
In-Reply-To: <20250220164031.1886057-1-wens@kernel.org>
References: <20250220164031.1886057-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 00:40:31 +0800 Chen-Yu Tsai wrote:
> The recent commit 8865d22656b4 ("net: stmmac: Specify hardware
> capability value when FIFO size isn't specified") changed this by
> requiring the FIFO sizes to be provided, breaking devices that were
> working just fine.
> 
> Provide the FIFO sizes through the driver's platform data, to not
> only fix the breakage, but also enable MTU changes. The FIFO sizes
> are confirmed to be the same across RK3288, RK3328, RK3399 and PX30,
> based on their respective manuals. It is likely that Rockchip
> synthesized their DWMAC 1000 with the same parameters on all their
> chips that have it.
> 
> Fixes: eaf4fac47807 ("net: stmmac: Do not accept invalid MTU values")
> Fixes: 8865d22656b4 ("net: stmmac: Specify hardware capability value when FIFO size isn't specified")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> (Resending to net-next instead of netdev.)
> 
> The commit that broke things has already been reverted in netdev.
> 
> The reason for stable inclusion is not to fix the device breakage
> (which only broke in v6.14-rc1), but to provide the values so that MTU
> changes can work in older kernels.

Thanks for the resend, the explanation under the --- marker makes sense
but that part gets cut off when we apply the patch. You need to improve
the main body of the commit. Remove the references to the reverted
commit, please, for all practical purposes it no longer matters.
Please remove the Fixes tags and CC stable since it's not a fix
-- 
pw-bot: cr

