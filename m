Return-Path: <stable+bounces-108425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FDA0B75D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C28E7A00D6
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80718493;
	Mon, 13 Jan 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Fae87ay4"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCF22CF27;
	Mon, 13 Jan 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772350; cv=none; b=MyznRuyEUsIfzfe33AOPmKS3gfQ99MRZfjc/n5jqMNTCDTbRu7r5iVqpfQFlrvYEFpVhAF9lFL8CTNQtLgBWyvVwhLDhJ/QbdArFCiNTJDWsGv8m+0VscCpNV7GQRcdC8X+RglwNFV80s/impb9rKvGYBXR8lntGn52KKDV+rz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772350; c=relaxed/simple;
	bh=neE9KG0ah7T5rkRBEGqX9zmuJK1XZ99b/Sq/QbjhyjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VazpgVG3kcacFP13B6L914Zft8v/oSk1T1SRoMCmluB/5WTTCkWYWWlYah5LMGl8cOl0llAu8Vfzm/WrkaSw05tSlOPgtBWK3vf3wUHYp2Iivu6mO3o3evluvCBvqiNSk7D31HPsDdvwo6iO5gGVr6HTYYYkUhA1VyEwhFx/Ids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Fae87ay4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8uYjioPZNuJ6YChCFOyKD8QRQiGxZ9HzZH2bKWJtRrI=; b=Fae87ay4QR+GdKJIedcJz0wjs/
	JToWgOq4sJJF2L5iGuef0qYPgR80j6hXyz7/BzqV1uUpAw3Wbs8VThMOOmsXhgkN4+Ewae9TQUX2b
	8/qnj/aQlyQp6TC/vT6yhxqTbGwxWfAD7cHPMCP1mi5iNg8b+dU4uP9BHapG4QZHEQM7Do3MP0dUs
	qTUz5RTaV4RiCmNlCmfgBYCScYwG8dYruq5rxIx0ETN3DDX7CvXoRB2QOK1Kw7cSlzdCpAOLwDL2Y
	6jAMtcreKo8R7DUFfk2xpNT/OBWgeH1XI/ruzTlogHqbpZoGPHorkLNpSrk5pr/eRMvsOfsWYqIkM
	OwUN+7RQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44950)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tXJp4-0006cH-2R;
	Mon, 13 Jan 2025 12:45:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tXJp1-00045B-28;
	Mon, 13 Jan 2025 12:45:35 +0000
Date: Mon, 13 Jan 2025 12:45:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ma Ke <make24@iscas.ac.cn>
Cc: sumit.garg@linaro.org, gregkh@linuxfoundation.org, elder@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] [ARM] fix reference leak in locomo_init_one_child()
Message-ID: <Z4UK7__tlAZrucRd@shell.armlinux.org.uk>
References: <20250108033049.1206055-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108033049.1206055-1-make24@iscas.ac.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 08, 2025 at 11:30:49AM +0800, Ma Ke wrote:
> Once device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
> 
> device_register() includes device_add(). As comment of device_add()
> says, 'if device_add() succeeds, you should call device_del() when you
> want to get rid of it. If device_add() has not succeeded, use only
> put_device() to drop the reference count'.

I reviewed a previous version of this patch, and commented about the
commit message:

 The commit message is not quite correct:

 "After calling device_register(), the correct way to dispose of the
 device is to call put_device() as per the device_register()
 documentation rather than kfree()."

Alex Elder also commented about this. Please fix the commit message.
What device_add() doesn't matter, this code isn't calling device_add(),
it's calling device_register(), and the comments against
device_register() should be appearing in the commit message, not
the comments against device_add().

Thanks.

> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v4:
> - deleted the redundant initialization;
> Changes in v3:
> - modified the patch as suggestions;
> Changes in v2:
> - modified the patch as suggestions.
> ---
>  arch/arm/common/locomo.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> index cb6ef449b987..45106066a17f 100644
> --- a/arch/arm/common/locomo.c
> +++ b/arch/arm/common/locomo.c
> @@ -223,10 +223,8 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
>  	int ret;
>  
>  	dev = kzalloc(sizeof(struct locomo_dev), GFP_KERNEL);
> -	if (!dev) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!dev)
> +		return -ENOMEM;
>  
>  	/*
>  	 * If the parent device has a DMA mask associated with it,
> @@ -254,10 +252,9 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
>  			NO_IRQ : lchip->irq_base + info->irq[0];
>  
>  	ret = device_register(&dev->dev);
> -	if (ret) {
> - out:
> -		kfree(dev);
> -	}
> +	if (ret)
> +		put_device(&dev->dev);
> +
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

