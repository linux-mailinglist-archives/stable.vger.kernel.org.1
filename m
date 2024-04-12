Return-Path: <stable+bounces-39255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3578A2642
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 08:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D8E1F245E3
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 06:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF371B974;
	Fri, 12 Apr 2024 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Xs2k1wco";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="TuAt7E3e"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC37200D4
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902354; cv=none; b=JEWUIh2kNY0tUs8podM5g0lEbaOF70e6XEp6hbFrMolLbyEqAe9E3a2QHJocZLezU52eQn6ijsrp3HCV9sMLpAn3cGU2sSeBMsV8/RYQTBOz+9FaLOziuw4n0kNVNmFnXq54yMxXivvPfgI0WtMDtpKiqStOqv3oQzR7XmrUoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902354; c=relaxed/simple;
	bh=fvE4u1m1ZQXiQgSn8D2AL9cnBpSUlnBDpxj6QthLJ2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1Tl6aHAzh7b9EejJUDkNo+VG94LXpWH0/9uvlxh99lgtC5+e1EtrTCWViLHztVhPAOda0Gy/xo8Ci2geP5LArHikSR0XPaz4C4do/SIpSXPsu8LLG649Rp97sGq3luiHDzUJIoldIXNx5T0OvWxuDnxmqHrGA1Dz4sa9xvl3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Xs2k1wco; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=TuAt7E3e; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1712902352;
	bh=fvE4u1m1ZQXiQgSn8D2AL9cnBpSUlnBDpxj6QthLJ2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xs2k1wco6lLTbbBeRkNCSeYonDcxf3bBDuyhkMJ1UUrtmRiAuZP4Y/ZCj1adlyyc+
	 ryfYYwvMQ6mxpPpj5jj6N8vfavmfnGGZ0J633FiwUXc53BRaianb3/SNVnQvp80XKd
	 yuoZhhb09bGUNDYs7Ch24h7ZkI3rqcaWUWhYSyu72GsJvIPx2sTk8IrjS7SDnqMluQ
	 faXH+XXszteMjaXE71FCb/p6x+qQ0vhZ8p85eVu5htZ1jRhhle6q0uYJuFXvMZhrQq
	 7RpgL2iSyID+cWpCTXJaAyenHPTDO5QU0A6UC7/iYUXsXaewYac07cdU/JSI2ZU+sI
	 50N5u5yvbhf3w==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 0522AB88
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 15:12:32 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=TuAt7E3e;
	dkim-atps=neutral
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id C6483283
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 15:12:31 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e2a1619cfcso5363885ad.0
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1712902351; x=1713507151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0dwL3ANJJbLSIcAepjbcvSwS9GyHYt6FIhhayzIePo=;
        b=TuAt7E3e+Ug4b7VkpcttDNSzvmG62I+V3zAr4T12oFK7eI8AfnQqyBDZK0fmnB5KHl
         gMb+el8b/uJ1+CaSVml3BNSqqXLfje/7/KcFKgfBH3dqCTrQqA6d2u2cr4Z9BDeosM42
         MiG84a5R8o/sRBNAorXrC7i4f0uRmFeD0HpseyyMtPEScVJGQMWmJPsSSojH9aHiV2be
         45hRjlnfTC/TQKf8m1e9N/w79ofZQv5UjyEYORAtVYnGu+8qoZr0hsXO0BIHaVRCIXd4
         RustVVYDXEw1V81gMRMQ5XS0a8zrcXa4xLx+NUuBXozMc4hEjBzbYVMkWSHAb+36J7fF
         1jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712902351; x=1713507151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0dwL3ANJJbLSIcAepjbcvSwS9GyHYt6FIhhayzIePo=;
        b=VFKO1Ep3Z+u4K+FMP0CDrEiMsc4arJPjbHa5hbPfFk/x77SLmjDW71mxt7xTFcK8Fp
         g2hr2nEyr6Hv6wpxxyf8OLVWaxodBd76xzYax4gTYTEsYc4Z6NfeaHFqij3mt1J3uQ8r
         xb6yb7pemIKDD5w7V+lBjLp5qcp+4d4MAzTqeQ1cyfmFKgmr3kVsm59EPbLMVFERM8Wa
         nDQ8le9aHHMxNMjnzB4L46qdlDWYilSyrpRvP+txUQVaaek/XJCna62jxu1Qo9bcZA5f
         e0m1nNUPVqOD9w29xqODbEObH+wBNEvlG6TT8Wd0KxXsCQGz2+kJekebmr0I5qI9bRlY
         vyFw==
X-Gm-Message-State: AOJu0Yzz6ERynZv7S7sOIXlbKXzxWfUyjELG+C0uXUTkBtu22wWEYOlC
	DXl+xngtTlowoAJsBwrROHF8BxhDHHymDQ/M36Xo08DNfkD93dhnLTApN9BTNRmKUZf9QXeeFgK
	LTgn3kJ0jCyG5HOaXszd7cpPELcALRpN7xiyGj2QwKGWVo5/TFKByV3Y=
X-Received: by 2002:a17:903:18a:b0:1e3:da22:607f with SMTP id z10-20020a170903018a00b001e3da22607fmr6402400plg.29.1712902350829;
        Thu, 11 Apr 2024 23:12:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP8NjdCre4Bj6BwL1Hcchmo5yuVRJTUkgZ2AcoS2zLTVAkmYXGNVxaiRcMsPRofmMmTzFELw==
X-Received: by 2002:a17:903:18a:b0:1e3:da22:607f with SMTP id z10-20020a170903018a00b001e3da22607fmr6402376plg.29.1712902350371;
        Thu, 11 Apr 2024 23:12:30 -0700 (PDT)
Received: from pc-0182.atmarktech (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b001e2a0d33fbbsm2169846plg.219.2024.04.11.23.12.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 23:12:29 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rvA9E-00Au4L-0Z;
	Fri, 12 Apr 2024 15:12:28 +0900
Date: Fri, 12 Apr 2024 15:12:18 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Daisuke Mizobuchi <mizo@atmark-techno.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 5.10.y 1/1] mailbox: imx: fix suspend failure
Message-ID: <ZhjQwnFdm8RCkn9b@atmark-techno.com>
References: <20240412055648.1807780-1-mizo@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240412055648.1807780-1-mizo@atmark-techno.com>

(Added Ccs again - Robin Gong and Jassi Brar both bounced last time so
didn't add them back)

Daisuke Mizobuchi wrote on Fri, Apr 12, 2024 at 02:56:48PM +0900:
> imx_mu_isr() always calls pm_system_wakeup() even when it should not,
> making the system unable to enter sleep.
> 
> Suspend fails as follows:
>  armadillo:~# echo mem > /sys/power/state
>  [ 2614.602432] PM: suspend entry (deep)
>  [ 2614.610640] Filesystems sync: 0.004 seconds
>  [ 2614.618016] Freezing user space processes ... (elapsed 0.001 seconds) done.
>  [ 2614.626555] OOM killer disabled.
>  [ 2614.629792] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>  [ 2614.638456] printk: Suspending console(s) (use no_console_suspend to debug)
>  [ 2614.649504] PM: Some devices failed to suspend, or early wake event detected
>  [ 2614.730103] PM: resume devices took 0.080 seconds
>  [ 2614.741924] OOM killer enabled.
>  [ 2614.745073] Restarting tasks ... done.
>  [ 2614.754532] PM: suspend exit
>  ash: write error: Resource busy
>  armadillo:~#
> 
> Upstream commit 892cb524ae8a is correct, so this seems to be a
> mistake during cherry-pick.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: a16f5ae8ade1 ("mailbox: imx: fix wakeup failure from freeze mode")
> Signed-off-by: Daisuke Mizobuchi <mizo@atmark-techno.com>
> Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Ok.

Thanks,
Dominique

> ---
>  drivers/mailbox/imx-mailbox.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index c5663398c6b7..28f5450e4130 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -331,8 +331,6 @@ static int imx_mu_startup(struct mbox_chan *chan)
>  		break;
>  	}
>  
> -	priv->suspend = true;
> -
>  	return 0;
>  }
>  
> @@ -550,8 +548,6 @@ static int imx_mu_probe(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(priv->clk);
>  
> -	priv->suspend = false;
> -
>  	return 0;
>  
>  disable_runtime_pm:
> @@ -614,6 +610,8 @@ static int __maybe_unused imx_mu_suspend_noirq(struct device *dev)
>  	if (!priv->clk)
>  		priv->xcr = imx_mu_read(priv, priv->dcfg->xCR);
>  
> +	priv->suspend = true;
> +
>  	return 0;
>  }
>  
> @@ -632,6 +630,8 @@ static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
>  	if (!imx_mu_read(priv, priv->dcfg->xCR) && !priv->clk)
>  		imx_mu_write(priv, priv->xcr, priv->dcfg->xCR);
>  
> +	priv->suspend = false;
> +
>  	return 0;
>  }
>  



