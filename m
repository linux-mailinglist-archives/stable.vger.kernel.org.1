Return-Path: <stable+bounces-106795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC50A02221
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA8161A81
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6DA1D63E8;
	Mon,  6 Jan 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u8ATxVr2"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AECB1E505;
	Mon,  6 Jan 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736156883; cv=none; b=WJMRwcGFiXPHOgcptSZ8P2GHT5O8dEKCqyvzt6lNSCEhwedFLfI136DsY2bnGDK3ghwT649ywtm2oVU7cBHx/yw87DYVwZLKj6sYZ/KAdq24Km5S4T2dqxKhuu2ccHSy0Q6ej88iqEJ+L/RgQ3vM0W6I6agf7jyAMBejzaaFAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736156883; c=relaxed/simple;
	bh=dLaxgmYswkSXZkUjlNDNc1tA8moJz1GSU3CEBXpHlmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPxoHAos1reTP2fX/d47M5MBqq7EHYSiYuyg7zBDfYkvB+PIi6bBBteOWjkfjeJqrULQoYnyx9ENNErcm3i3rTbiB8ASDgNT3Rq+CbXKXJn2hHdsofx9HR6WMOg9jEJq+lYOsjYyNLzcQ6Oiw+ho+/UHeRqOxWeSwOVj6Gw2jLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=u8ATxVr2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UB3S6kcd+Omc6ye56NC6ow7U03F1ihd9mp0kuIOyzfY=; b=u8ATxVr2+q/It4195z3R2JW17Z
	n4BxjFVG9gkVWLrh+y8ahgYOsghmOyC185Cuk1U6JQic3S+wpsSwzBvL+Zs2ffOdF85PPuO4E4/K7
	Hc9SUbiuqnbYc3LksInEkcZIXA/MiaVK+C8GGrjiqTNepW2nC9cefkXyPRH5SzMVgn/tsa4y+I1iz
	FYzPy28nKJHKOxdlLs5CEycDC0czUMHCLosz/2v30z0h/1icHpZtDFjwAms7vv/d8KLzZ14YKQnyP
	oc585AlVHEEenpQ2PnVbF1de9w0VXnr0v2asZSFBjB4GG3mvwdFjMhk6FxIyHYxQgI/BjfM424GS9
	KeOZ62Bg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39272)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tUjiH-0005bA-2h;
	Mon, 06 Jan 2025 09:47:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tUjiG-0004B1-2W;
	Mon, 06 Jan 2025 09:47:56 +0000
Date: Mon, 6 Jan 2025 09:47:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ma Ke <make24@iscas.ac.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] [ARM] fix reference leak in locomo_init_one_child()
Message-ID: <Z3umzMg6SbHh75vI@shell.armlinux.org.uk>
References: <20250106074743.313384-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106074743.313384-1-make24@iscas.ac.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 06, 2025 at 03:47:43PM +0800, Ma Ke wrote:
> Once device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
> 
> device_register() includes device_add(). As comment of device_add()
> says, 'if device_add() succeeds, you should call device_del() when you
> want to get rid of it. If device_add() has not succeeded, use only
> put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the patch as suggestions.
> ---
>  arch/arm/common/locomo.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> index 309b74783468..9e48cbb2568e 100644
> --- a/arch/arm/common/locomo.c
> +++ b/arch/arm/common/locomo.c
> @@ -253,6 +253,8 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
>  
>  	ret = device_register(&dev->dev);
>  	if (ret) {
> +		put_device(&dev->dev);
> +		return ret;
>   out:
>  		kfree(dev);
>  	}

This makes the code layout quite horrible.

Instead, I suggest:

	dev = kzalloc(sizeof(...)...
-	if (!dev) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dev)
+		return -ENOMEM;

...

	ret = device_register(&dev->dev);
-	if (ret) {
- out:
-		kfree(dev);
-	}
+	if (ret)
+		put_device(&dev->dev);

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

