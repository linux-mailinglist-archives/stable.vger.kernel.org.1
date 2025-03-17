Return-Path: <stable+bounces-124627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D74A64AE7
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 11:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB53188AE25
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 10:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3623233727;
	Mon, 17 Mar 2025 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPEyLlYW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7ED23496F
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208707; cv=none; b=iw4aBkFV/42BdPLvtdGNjOrnbD7CF4dCvVzfM7U51p7zFfiPIeO6rQMh8RLih6rnU7G/oJSmP4U75PMq8OSTDUleGIDYF7KVPeGPCT7FcrWhopuUuX0APHiyzBBRTxnYDFD8prb7lw9cElnICf+eh7VhYlwvh2OJodc2x0nzF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208707; c=relaxed/simple;
	bh=QHY+1BPCLViU0H9rv3Feced7ANo0/UdyUNjmCf5LslI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eL065tgK1AlFowHyS++SrkPSVUWN6RFFBx5BOtfYm5NJXBHhF6I+YGPAzWfKI0iLsLtF9S/EzC/i9acnUNsW6G+AgHMrhmN69sismud+rs75dh/u0mT5fWANJiMNu2B9WfpPTF8+gynpuxR/4HyyQXmQlayWT/9udk6bbaaopog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TPEyLlYW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ff2adbba3fso32657067b3.2
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 03:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208704; x=1742813504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5vZp0HtUwVLeKpGm04Jx0bwIqFPyxQHAFaLRo/7tVI=;
        b=TPEyLlYWpPlDPn/RcUUHhw1/s5hgHoa+7VswwB5YO9ki9acKG/0WfTtMKMwgdWoSa7
         0cKNxeHaeS3OfrkyHmCniitHvyfjtXeu0WaQw8yIHBKXGP3x7MkRGD0AibW5Wi9ujp7M
         dZpXjLxkEIkRhxi7+vfiJPIHyEXjYjXascs1VfC+4bIt4I/aRMJojAzg+CEOQCPbK/lj
         M1jiXjYdVW0hkQ8EZWcj28m5FbGMTXW8rY0t3lEUC71tOgWXt/K+2+xCOqZtnseCQf0D
         OoyXSBH29fglL/OLxrwD2aWzCldYUuY0Ba6JspetFoWgm5IoS+2iqlbv7X1HD0TXGugc
         YtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208704; x=1742813504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5vZp0HtUwVLeKpGm04Jx0bwIqFPyxQHAFaLRo/7tVI=;
        b=sKn5jHmnpJ8RCuFEgN1pn4/SITsRqdvgDH0HJkwEWw1DqD7/c6RKWq8xGEJ/suyGJT
         rRd32WIpIiMwtb0wyq1KL13yWyVWTu3YUwtZH/5l4ZBjXC+/wytXKZENzgp419URx6st
         OG49AzBWjS4SoEoNws1/HEtbtm9LKLl4KMGZSpocNYrMxId36nf3KfPbZFr7t9sSeBit
         q0pMIuY58lxoYDZR45KoOuC/LFb08EDDkqyEaaDZyQxLGMaw4VHOETzQ8GYdfIQZsR5S
         iH+TLdDpoejpjDy+ZPp8j1V8f4woK1nrIA5lO+MOPR7jl7s0XsoPidofAWr+XLJ3irrN
         ucFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWro1uuJClCuAZoPgNpW9Ws+ceKj8OPPXMGx3LwDi3WLhl6fbS8MJSw7CgVDgz60L3DpB2V3vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXsygctPm463SfXGaBSd3ytUjly0i5zyvOTIS+FkiKphp6WZGH
	tRpkbU61M5ZpetwaSEWbutbo7lwuXFP9UCE/ZAX9EEkK2hYxl8Q80T4crGSvPe2Aru6JfYwD6tf
	VfGwOD1en0jvGd/h6hz0NZh9C2QR64aiUdWvPVg==
X-Gm-Gg: ASbGnctATuZYfeMCgi+fjwviI5XHl+gaf5UxX2jB+LC8lMzo7jkLB5DZBN80k8mW9uO
	f7SUeNnKXtMcnJ8fXzlK0GU5qhA0RXfjYEFbSdcoBj7Egp41sVEVTBi5CdBPUI13/kojWHK6g/W
	pfDnBO2ybMqIidq1uoKCvhwAU9LeY=
X-Google-Smtp-Source: AGHT+IGUWzhUNx+FG7HRXqFuPdBF74JuGnRL6w6PE5kq0AM7HDR5wo32rWOJsJVL3Y0F4L1pFoaocbYX/Sdx4vjSCYs=
X-Received: by 2002:a05:690c:600d:b0:6fb:a696:b23b with SMTP id
 00721157ae682-6ff460fa022mr159567617b3.33.1742208704533; Mon, 17 Mar 2025
 03:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312121712.1168007-1-ulf.hansson@linaro.org> <CAOCHtYjGuw9szeChihrDZ39_2+w5xOverbp6mAjjLjR=QkK1zg@mail.gmail.com>
In-Reply-To: <CAOCHtYjGuw9szeChihrDZ39_2+w5xOverbp6mAjjLjR=QkK1zg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:51:08 +0100
X-Gm-Features: AQ5f1JqWe_VGljdWIdz3MIyeNETV_0LFDiQxhaioBF37nyjW7vltrBkTmIinzVI
Message-ID: <CAPDyKFqPdDjoECXeBqx0P+fpbgVN1g_jWM2fQiH8Mw6HGMSPNA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-omap: Disable MMC_CAP_AGGRESSIVE_PM for eMMC/SD
To: Robert Nelson <robertcnelson@gmail.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, David Owens <daowens01@gmail.com>, 
	Romain Naour <romain.naour@smile.fr>, Andrei Aldea <andrei@ti.com>, Judith Mendez <jm@ti.com>, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Mar 2025 at 21:54, Robert Nelson <robertcnelson@gmail.com> wrote=
:
>
> On Wed, Mar 12, 2025 at 7:17=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > We have received reports about cards can become corrupt related to the
> > aggressive PM support. Let's make a partial revert of the change that
> > enabled the feature.
> >
> > Reported-by: David Owens <daowens01@gmail.com>
> > Reported-by: Romain Naour <romain.naour@smile.fr>
> > Reported-by: Robert Nelson <robertcnelson@gmail.com>
> > Tested-by: Robert Nelson <robertcnelson@gmail.com>
> > Fixes: 3edf588e7fe0 ("mmc: sdhci-omap: Allow SDIO card power off and en=
able aggressive PM")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-omap.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-oma=
p.c
> > index 54d795205fb4..26a9a8b5682a 100644
> > --- a/drivers/mmc/host/sdhci-omap.c
> > +++ b/drivers/mmc/host/sdhci-omap.c
> > @@ -1339,8 +1339,8 @@ static int sdhci_omap_probe(struct platform_devic=
e *pdev)
> >         /* R1B responses is required to properly manage HW busy detecti=
on. */
> >         mmc->caps |=3D MMC_CAP_NEED_RSP_BUSY;
> >
> > -       /* Allow card power off and runtime PM for eMMC/SD card devices=
 */
> > -       mmc->caps |=3D MMC_CAP_POWER_OFF_CARD | MMC_CAP_AGGRESSIVE_PM;
> > +       /*  Enable SDIO card power off. */
> > +       mmc->caps |=3D MMC_CAP_POWER_OFF_CARD;
> >
> >         ret =3D sdhci_setup_host(host);
> >         if (ret)
> > --
> > 2.43.0
> >
>
> Thanks Ulf, i also have this exact revert running on the target in our
> ci farm, i think we should be good.  But I'll validate it in 4 weeks!
>
> Regards,
>
> --
> Robert Nelson
> https://rcn-ee.com/

Thanks Robert for helping out!

In the meantime I decided to queue this up for next, to allow it to
get more testing in linux-next.

Kind regards
Uffe

