Return-Path: <stable+bounces-39253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348B8A25E4
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 07:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5CC1F2254F
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 05:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ECA1B977;
	Fri, 12 Apr 2024 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="ZNfC2NkD";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="TdHUFmc2"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1511CA6F
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900875; cv=none; b=g1QjWQkCMu2mQGOfGoNYBCXwnM/E9pGJjJo0dEjaypMTCe2AqAwB/zsrBds937dreMLopnTbbse5ees9Qt96c+f8VYIIpWqOtlS69/x/MzfSy9WyPgwbNBR0bz4pEeBaFhhs43kJGoPeo8Et3aAnN5v1BDX4CMwQwxlF3jlk8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900875; c=relaxed/simple;
	bh=TRkCNAJeA7Xwz6wRdvkcodcNW7Z9Ksrcfohs5CwBQCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWUJTsGanbjl0D5M+p2BwjNh7ON5MxFzpHUKNFm1oNyXCAOKeK6dH0S7pwjJ/NkujvEFDZVeaFdvWBBb65pggAN+FcahaAVL3pmIUZCeu7LRni73bLx1HDcnytYVPJQxh54i48ABb1BUPQ75D9IonesPXJOPP/+2qI+LdfLUIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=ZNfC2NkD; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=TdHUFmc2; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1712900872;
	bh=TRkCNAJeA7Xwz6wRdvkcodcNW7Z9Ksrcfohs5CwBQCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNfC2NkDWlF+ITJfRHAVngiRcog/jTbs6mVBnFtjst9v2Uj6z1q3II3Z9Ee+q0yD9
	 SYGvjIdk3ymyugRmf7M9PqpRdGEqIod8LUkHsnxBIrpdSL6CThh4jXR0il3scyrf1K
	 gJTHk3CBpTZRbGiFGRySiWeSbIuLDf4pydWvTCSIwhuVYnyNVB8M6Z2uLcvfKmUMB/
	 4Dkt34UcUHp8gPJDaCeLMPQrXlnyZnBeuEqzFzvdznrKNAXm/fyp/IdqI5OLerGC3/
	 Wiloz3a1O2vyM3QxLLmckLkAt5tIjBCXTpNrrFZcPoFlknqd2YQwZ9GoonroaVXaL0
	 ueJDY1LJ7ojLw==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id C1CACB88
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 14:47:52 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=TdHUFmc2;
	dkim-atps=neutral
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id DB67FB88
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 14:47:51 +0900 (JST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ee128aa957so578049b3a.2
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 22:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1712900871; x=1713505671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qa4GhuMmS/e/EuIanfWsVbsD05aZHbmDSNOBEC2t0w=;
        b=TdHUFmc2ClF5CTUqow13htiHvphuLvtEALNgZoQrCNpZBJqkxj0B25rCViScCkdyeN
         Sff2VGkxzXHi6+w6JZKBFjkbUCezyGEAZfETeTrhgIaj6nuCBlFOZGbHvQsofNWD8ew2
         UgP5zOtvop1NvWk0rElGOKoz90oCNnUJ7DaBjvgsWOaPvQAeimN19n+DD+Du2mZUJy/L
         7rH07qL5aeRBhdhtBlc/AVE9yjLXhKmMwGEGcIUfFxpC+Tsm3b6m5UIHdtFc+ZRe63gL
         urN/LJJmCzBMX01rj5WB7n34E+Ifn5pY31X6eLWDYfc8nvHVDU0uXcQF+BedMBpXnojp
         IjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712900871; x=1713505671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qa4GhuMmS/e/EuIanfWsVbsD05aZHbmDSNOBEC2t0w=;
        b=o+o4Xh2bENcRvFZTFkXX1cEQHBL6GnoC/X21rQKSq2vPszf8QO5WCI/HeW//pOvvVS
         9vdxhh8IC5Akp9C8Hjz6FalglqzoiNmNESCCgu5d3tC0k4RM11Dg393J4ZdQc0akptMQ
         4yVk8mg+1Xvv0/4ZOcR8bFuEQiZHiTkPa39/7IjCrEkVB/vlS6u9Om0wwMf+JwDpiIfi
         sLEPDZmJO6A2nmECPFHH+JNd3FWpmJIIBJmoJrHPNSkdWGFQ378HJ7Zi4L/CNotBKOBR
         3nLvSA7F6j7mPai1F9Gh89GMBE6XyzVWXSNabCtIdTiYIbxuD/DEw07C8Xg5hazAFWEa
         LqPQ==
X-Gm-Message-State: AOJu0YwRY65ckxK9EFmwyKLP3gNZgfy5436gkB9soMLgD1j37sbxCXaj
	ZZqoNHxdA8QOpcF+J/DX1M9LWoZKXJ2WK6RADj1Zp6ilqlCq1ctfxfW0R0QMr9aHhs4Lp2gd4G6
	69vcL/O+a7WRwaLtEgWRRV1MjBchUYoR/lbs/s2/vMRqyDvX0LT4Ih76w8ucObNs1NQ==
X-Received: by 2002:a05:6a20:1e88:b0:1a8:672a:3fb2 with SMTP id dl8-20020a056a201e8800b001a8672a3fb2mr1387165pzb.43.1712900870840;
        Thu, 11 Apr 2024 22:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF+5f9ga8Kc7xy9UFPBVwFdAtbw6j58rLTqQSBKNnE3WYehnxoE0kkmEzwA42z8EEdRlP4kQ==
X-Received: by 2002:a05:6a20:1e88:b0:1a8:672a:3fb2 with SMTP id dl8-20020a056a201e8800b001a8672a3fb2mr1387152pzb.43.1712900870370;
        Thu, 11 Apr 2024 22:47:50 -0700 (PDT)
Received: from pc-0182.atmarktech (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b001e2a7fb9441sm2125769plg.51.2024.04.11.22.47.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 22:47:49 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rv9lM-00ArzO-29;
	Fri, 12 Apr 2024 14:47:48 +0900
Date: Fri, 12 Apr 2024 14:47:38 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Daisuke Mizobuchi <mizo@atmark-techno.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 5.10.y 1/1] mailbox: imx: fix suspend failue
Message-ID: <ZhjK-nJQKVr5RcgZ@atmark-techno.com>
References: <20240412052133.1805029-1-mizo@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240412052133.1805029-1-mizo@atmark-techno.com>

Added in Cc everyone concerned by the patch as per the broken backport:
https://lore.kernel.org/stable/20220405070315.416940927@linuxfoundation.org/

Daisuke Mizobuchi wrote on Fri, Apr 12, 2024 at 02:21:33PM +0900:
>Subject: Re: [PATCH 5.10.y 1/1] mailbox: imx: fix suspend failue

failue -> failure

>
> When an interrupt occurs, it always wakes up.

(nitpick: this isn't really clear: "imx_mu_isr() always calls
pm_system_wakeup() even when it should not, making the system unable to
enter sleep" ?)

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
> Upstream is correct, so it seems to be a mistake in cheery-pick.

cheery-pick -> cherry-pick

(This is a trivial lookup away but might as well name upstream's commit
e.g. "Upstream commit 892cb524ae8a is correct, so this seems to be a
mistake during cherry-pick")

> Cc: <stable@vger.kernel.org>
> Fixes: a16f5ae8ade1 ("mailbox: imx: fix wakeup failure from freeze mode")
> Signed-off-by: Daisuke Mizobuchi <mizo@atmark-techno.com>

These typos aside I've confirmed the resulting code matches' upstream's:
Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

The backport in 5.15 also seems correct and does not need this, and
there does not seem to be any older backport either that need fixing, so
5.10 is the only branch that requires fixing.

Thanks!


I've left the diff below for new Ccs.

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
-- 
Dominique Martinet



