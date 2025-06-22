Return-Path: <stable+bounces-155251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B908AE300B
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 15:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98C316E41C
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 13:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C141DED5B;
	Sun, 22 Jun 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nq59hv2X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518F1F94A;
	Sun, 22 Jun 2025 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750597821; cv=none; b=KGLsadvSmUSkyFOA7KLY6wOTStklPmz9GbJWpUX13oCjLifmU7mWEMOJEmLDC6SzxzXPIBrFPD/GGRc5/q0xzoKLZK1G7zrMNpPv4Oe5TG1TNQHVHzUo1nYf6tljDCWec1VmVpzuaT9vFFUR2wi/G/iZa1JCzhrjLOA+SHIe4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750597821; c=relaxed/simple;
	bh=JfnT3FIl6Aun7WZNynKmrF9iAWSarWXs78zZvbCJAGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEUe2CwMUhRVTHf5xKq4ROBOS3Sx2yhhPgLE2Sl8ReFjC1RyQ6iuz4yOKhAE0Hv2DReSwbP0UKx6HcSa0i++lvDt7Qbi9pMDPdYqs3qzLKTWt4td3tl5uCFuFeQHmRP72a1NBgso/orSFq3B1iN0DLPqhPPxEqiwc2+seGD698k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nq59hv2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7396C4CEE3;
	Sun, 22 Jun 2025 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750597820;
	bh=JfnT3FIl6Aun7WZNynKmrF9iAWSarWXs78zZvbCJAGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nq59hv2XFXIF6Fh3npN5Sza8gbnyhkwaHEtLzajgv5QA9nws+1Sr5nq5jQ6w8Votk
	 kk7h40AcGofGFfGgv/ykDGl8m6ijKDSNPsPckXrN22utcjbJwIaPveL33xNfEif/3j
	 qKZ8wawQmDegwA1YM5rGAityTQqzVThk+ZRSlnLQ=
Date: Sun, 22 Jun 2025 15:10:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	ziyao@disroot.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH for 6.1/6.6] platform/loongarch: laptop: Fix build error
 due to backport
Message-ID: <2025062206-roundish-thumb-a20e@gregkh>
References: <20250622110148.3108758-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622110148.3108758-1-chenhuacai@loongson.cn>

On Sun, Jun 22, 2025 at 07:01:48PM +0800, Huacai Chen wrote:
> In 6.1/6.6 there is no BACKLIGHT_POWER_ON definition so a build error
> occurs due to recently backport:
> 
>   CC      drivers/platform/loongarch/loongson-laptop.o
> drivers/platform/loongarch/loongson-laptop.c: In function 'laptop_backlight_register':
> drivers/platform/loongarch/loongson-laptop.c:428:23: error: 'BACKLIGHT_POWER_ON' undeclared (first use in this function)
>   428 |         props.power = BACKLIGHT_POWER_ON;
>       |                       ^~~~~~~~~~~~~~~~~~
> 
> Use FB_BLANK_UNBLANK instead which has the same meaning.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/platform/loongarch/loongson-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What commit id is this fixing?

thanks,

greg k-h

