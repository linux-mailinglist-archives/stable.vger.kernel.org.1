Return-Path: <stable+bounces-96099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8803C9E0ACA
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F47B81492
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D14F209F51;
	Mon,  2 Dec 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URPKnzxz"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CE209F26
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153056; cv=none; b=PA4SbHJmLedBW5hz18bP5qxXh5zhM5yEVR6Cbs+Q+dQwlXinOtwkHwmk1dhUwqCD92AF0789TMVMJlNXLt6B2wBv6EIdjFxY6VourW4LQNSrZDau+544/YuxX2b1noDAe3vAonExsNvDRU6NmshJaNdx7RyD9QpV4L8ZS33jVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153056; c=relaxed/simple;
	bh=GT/7Ze1ICZzO91X+fJzIIryCuvOoEcn09j4ZdKtLo6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laU6clr6Kb88UzEnuhUCY+LUcBneGZsL5aehywW5QrX71P8ouscsqVE3GgSXy9IUta+J8IUuZQgAKrLprOCDCJpV8fJpWVTkzNFM+vLs0vp0FemPT38qMzF8AhGw1EuuEWLHkrFheqzwQ5TnzC9KdEaYNSO4xRbifxYa/++AD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URPKnzxz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e399f8bb391so1471010276.2
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 07:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153053; x=1733757853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m76+jzfpV1Gl7IDVGFQkptedm6l1QHBc35AI5nAO280=;
        b=URPKnzxzvYoI9ybhzsWZwVzc3sQib1Kf/2TWh+EvBAJ2eCmxCfi+VGggKbP7QX0Pnl
         gBRZHTUe2agFetZFdYg1ZGMd5Hb16QFGmRygKH6h8wwKu0UYplSpnJe8J3tv5I1jZRY5
         PngGCeFtm2Geo3mzxVDjBX6RfXd5/hUG3bM/xasjIx1luQTEFVnQPEzlHMtCVCluNAN8
         OSngWCxmilD0WR1V5Pu5kh9n4GoGV8hUCfPOU6cnnw5kCC0ysOyRUHiWp9VcM/p0IDEA
         cJFgIr13ouQd6/afFwCBWzkjp51FlplKybl9TKJnG2xF+X5l77+2EaOS3FmS2XT5k/Dx
         PCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153053; x=1733757853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m76+jzfpV1Gl7IDVGFQkptedm6l1QHBc35AI5nAO280=;
        b=G9sB+QZhAaHRR33dT5TSNqUaYRQquWPfPdMop1E9lJsauolMfyii0ht+EZMb39QbZw
         kq0y+ATeiUNa210nff5W3TtFXzlSl+xS5dL5WoyKDpjcs8UxGnATa7pIOxzl79XlXlXk
         yha4W5u3Q9Ysw1TJkBowyZkocRxv1zOHgwZCNOPdC4So5AdMf/fi4Nk22EcXqCaNiaJS
         xHK03mcG1iXex0d7VmzTfxD2KxcjPKCNGufc83sBC0HBlcnafidgdeu9YxLmjDSODMq5
         8HMeIctoF1DW2KKIqwbc4Yh9yoOqEXmhDOp90uXx1lZJ1Ta/mctK21UMb7vwUs7BZxil
         UgBw==
X-Forwarded-Encrypted: i=1; AJvYcCVe/+T5yEbdhwUzzYbctBzOp1l+qaxvJdleEEejZvl9B+3aCokdhW7+SUZ0DilNFGkuVePSeag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEC2lEybG0c8zaNBPwjGBtspcYMJbPMSE20xZQcc+EvVHfiUur
	F41DWJCvrbkA8+dYfYaX0cBFwHe9cnE2HFn7kMfvQJ64Yqy8z/hjPxiX7XRy0NHB89YuMkgwO1V
	9yNV6DK4f5hlfUy9aCRYnXJ/1Qk4CsHClny9UJg==
X-Gm-Gg: ASbGncv4xmmhqdH02zPYUqP+3yy+6eI9aOCXq3ShxrrZuwRwLjDl+Fwlhj5TbeN78Jd
	sVayoa0QQ/QdlBT6jte94UAMN2kUXY52P
X-Google-Smtp-Source: AGHT+IHH7hIx+e8n6avEfQWiti54KkaNN3HlOI/MmlmrT0lxi9lBcIhv+cnoSDvpFTNHzd+CyUH6RHneSifHab2NRNc=
X-Received: by 2002:a05:6902:1895:b0:e33:20c2:223f with SMTP id
 3f1490d57ef6-e395b869e50mr21994700276.10.1733153052749; Mon, 02 Dec 2024
 07:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125122446.18684-1-ulf.hansson@linaro.org>
In-Reply-To: <20241125122446.18684-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:36 +0100
Message-ID: <CAPDyKFqQaPs1oQ9zgvOSBGLnP=tNe0UdX4B=EPELdY2jFjGRuQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Further prevent card detect during shutdown
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Anthony Pighin <anthony.pighin@nokia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 13:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Disabling card detect from the host's ->shutdown_pre() callback turned out
> to not be the complete solution. More precisely, beyond the point when the
> mmc_bus->shutdown() has been called, to gracefully power off the card, we
> need to prevent card detect. Otherwise the mmc_rescan work may poll for the
> card with a CMD13, to see if it's still alive, which then will fail and
> hang as the card has already been powered off.
>
> To fix this problem, let's disable mmc_rescan prior to power off the card
> during shutdown.
>
> Reported-by: Anthony Pighin <anthony.pighin@nokia.com>
> Fixes: 66c915d09b94 ("mmc: core: Disable card detect during shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied for fixes and by adding a Closes tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c  | 2 ++
>  drivers/mmc/core/core.c | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 9283b28bc69f..1cf64e0952fb 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -149,6 +149,8 @@ static void mmc_bus_shutdown(struct device *dev)
>         if (dev->driver && drv->shutdown)
>                 drv->shutdown(card);
>
> +       __mmc_stop_host(host);
> +
>         if (host->bus_ops->shutdown) {
>                 ret = host->bus_ops->shutdown(host);
>                 if (ret)
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a499f3c59de5..d996d39c0d6f 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2335,6 +2335,9 @@ void mmc_start_host(struct mmc_host *host)
>
>  void __mmc_stop_host(struct mmc_host *host)
>  {
> +       if (host->rescan_disable)
> +               return;
> +
>         if (host->slot.cd_irq >= 0) {
>                 mmc_gpio_set_cd_wake(host, false);
>                 disable_irq(host->slot.cd_irq);
> --
> 2.43.0
>

