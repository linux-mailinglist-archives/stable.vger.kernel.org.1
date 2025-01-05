Return-Path: <stable+bounces-106764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D761A0195D
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 13:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E044D7A1584
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7F5146D45;
	Sun,  5 Jan 2025 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lUbWys8N"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564FEAF9;
	Sun,  5 Jan 2025 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736080132; cv=none; b=aov/IqCEfXRhUn8A20U2fcXM9ZhxgicLcYbAgELe9TxbPMC0/Hd6EcjjHj15v1Jeffo4q82XNe66+aPPJ9RuixcUfhwCOvuXhd2rcEmXNQanpmDTL7cHhcIjJPEokyNlyRzy6aNxNvQ5/AxEaMAe84dkHJbjVk6enS2HDqGVz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736080132; c=relaxed/simple;
	bh=tBhh3+Rq66DJLRWzh8mZluBoRdrF4G5qE+DESu7n+0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsmK0spfAgprIRBJacHhi2kJGt8MtYML6bdwHj4Jiq6Uf3PLGC4nSvqRNEXjMpR3ZL/dIQ2RW56Q/EXKjB75+BVCr6wiCqKd+Crsm9phqC2MCqQer4pfx6XmnUFgiecpMMJAGQjr8FLiXcxSnH473sGQmxpuAtaWyh7kkNNOgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lUbWys8N; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cADidBQ/mORQwHOuUzo09UeKlSlPquGLZ4XWeuQQwAg=; b=lUbWys8N7zxIpPiSDGnkrqoFCh
	9XP0gyrwqrdC9NfyL35X5v1+76RKADuFS/wH2yeFrQDW2wHOH2Qpf5schc8/S9KiUb52RkE59Y/hq
	7eFCr9VNPOw+jo3ZUk6+G2VURBiZuFopI7QsjVIC/+jAFMh8tRbk7YbLplYewUD30L6yMP6rAusRm
	MJylgvHsNAudhmRFwLv4bf3XczeMZpe+OqZhc5t4kVcJTOm5UwKCaqEvm/h9CAExtNcIEaz+t82td
	Q+iVZIsozsIhKimn6FIsO/d5Fd7TvXVLD3j049jH3zl/8rTXlf/cAYr8gX+Mia/evTMLNg0TSWl+J
	N13qY0KA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47624)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tUPkI-0004lF-1F;
	Sun, 05 Jan 2025 12:28:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tUPkG-0003Hq-2l;
	Sun, 05 Jan 2025 12:28:40 +0000
Date: Sun, 5 Jan 2025 12:28:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ma Ke <make24@iscas.ac.cn>
Cc: sumit.garg@linaro.org, gregkh@linuxfoundation.org, elder@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] [ARM] fix reference leak in locomo_init_one_child()
Message-ID: <Z3p6-LeZZ2ZGupEc@shell.armlinux.org.uk>
References: <20250105111156.277058-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105111156.277058-1-make24@iscas.ac.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jan 05, 2025 at 07:11:56PM +0800, Ma Ke wrote:
> Once device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
> 
> device_register() includes device_add(). As comment of device_add()
> says, 'if device_add() succeeds, you should call device_del() when you
> want to get rid of it. If device_add() has not succeeded, use only
> put_device() to drop the reference count'.

The commit message is not quite correct:

"After calling device_register(), the correct way to dispose of the
device is to call put_device() as per the device_register()
documentation rather than kfree()."

This reveals that your patch is not completely correct.

> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> index cb6ef449b987..7274010218ec 100644
> --- a/arch/arm/common/locomo.c
> +++ b/arch/arm/common/locomo.c
> @@ -255,6 +255,7 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
>  
>  	ret = device_register(&dev->dev);
>  	if (ret) {
> +		put_device(&dev->dev);
>   out:
>  		kfree(dev);

... and that leads to the second problem here - this kfree() will lead
to a double-free of the device. Once by the reference count dropping to
zero, resulting in locomo_dev_release() being called, and then this
kfree().

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

