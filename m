Return-Path: <stable+bounces-95524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543239D9728
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 13:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B05B23516
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 12:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116181D1F57;
	Tue, 26 Nov 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xrm0r4Z9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426791CBE8C
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732623508; cv=none; b=VPCRYOHiRpUWELkhC4AyfdpQ+dvEhvCvbJqSd5CBqf02vBZX2VLB6cZ+QChv01vZbzl4nfE1S0XnU1mi8xK0fLNV+rIJpeDkPwWsKSlVdIUUpr5y+v5++sZ8jyL+FgS0mXYLgu8vX5N/+mf00VQmdqlVPQPt51hThfylXiChSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732623508; c=relaxed/simple;
	bh=NsOkQNizfy7L6gUL++EqJf4pjp0B+QFz5IwWcPxP0v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARnQGj6TG/ry5LlxHPy0Kot1prRZ1urv/Ae+6P9oGkFmAbNSa64xlGFsZ2UERtaGT73JCbBUA6dt60FtTa7VlZGpgLKopHqg/J3HdWPl+h2Szh544pw4Gt39Ubux7l0v9j1eJRNIxm8Jb5kYLo4Sbo7ovqUI9iJYnTk7/Nq+47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xrm0r4Z9; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3892396200so4672019276.2
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 04:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732623506; x=1733228306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1t2bdLsphO4qv8lX65ai1ApZKPwIzSeCFPg10eL8iQU=;
        b=Xrm0r4Z9plqyu6EMaQ33HU3gA15VUn/9eXRZVDYz+yMWMUDJd/SsM+cLxql5xOWWL3
         fKNVrQy/iWj2iMb2NlWu2oZRCK9n0EvmOBRVaVciynw9+F8P3AhxnXIEMl2oGtuIK0ge
         zNu4/NFlYiGx/z19tABn4P7IeThn/WnGB0Vxqx9Tt2OAEahOFtwcw6eF9/nm42OnzRl1
         zoneEr0r9Pg2fksLuYLRYg/Cxg4ga3uA5NN993xTIoEnV+4vvzL0RRBCiQkhyhM3r0Uq
         aONtdUf0334ih3xDgu3Vlp2z/5rRICseXyVzMOfA0DMm/t2/5gusABvOAJaBFtgQgp8r
         +nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732623506; x=1733228306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1t2bdLsphO4qv8lX65ai1ApZKPwIzSeCFPg10eL8iQU=;
        b=WTq0IQfolXi3vvZs1wvpXdF0Fmh6rUP1mcYzlb+3oJyfjFjhVVm9gvSz8TbwjO81s8
         tvawbFkUqZ4ppM2Wg5UBc2LuGv3cxWt7Dj7Qy39iKY0Q3ZSPaZgd9xik5zyHgK7Qnm42
         xmkAhrsyOlGF7BhR+HjnNP6JfAAOoFEh0fmd+iSVNZP8Yo9gDGACahZnTuKH+r+iYtjD
         gbbfGudtbpbvM6MZPZ7O56EsytIpiB2JCqYMjlIVIYtck+Xs28TZOm0AUGbwghAnLih0
         f8NQKc8hAh0ofJM/X3YnddtV9lUzUk7DYH0mYxSUlL2wvW0htNCr0esfeWJiIo2A/Jlo
         V2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG6zoSc4NVtRX7rW1vXqWGzjjuNj9RTzYETf5hHU3r1pcDLosPYylSfeYNfq5FH35+KLA+igE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVd/J8qj6Xnu11oblpM820VmQ/EKtWi3RLJ4uT9dVbR6HnRy42
	F6r3qzRSKyy/j9jrvu2EdEtLvl7ZyaA2V9XmvjbTxj9DiicSA0mZ3JxqgBp/9M+eFL9aWvESGg3
	AxK/TOfqsO9IbUP2wCVvmXddalm2Jtvpa3WgWhA==
X-Gm-Gg: ASbGncs5p6fHCabK+sj+yVAs3lbkhtGbamnYaxKSdFSBkGFrXfZVLXIXTuRvzigGpG8
	Fd0JhcJkpqhUX4T+9/ibeUFxpldvx1xIM
X-Google-Smtp-Source: AGHT+IGd5+wBDRxy/P2XFJDCWgoDYm0J6RIEhVEBraMx8w2/LeSUu3keiz9cNbvZe3rDWYJygxSUe3J10dUdOJanJ80=
X-Received: by 2002:a05:6902:310b:b0:e38:8ea6:2abf with SMTP id
 3f1490d57ef6-e38f8c05130mr12064188276.46.1732623506153; Tue, 26 Nov 2024
 04:18:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125122446.18684-1-ulf.hansson@linaro.org> <113cb538-f337-464e-9854-3a6dcb5b95e6@intel.com>
In-Reply-To: <113cb538-f337-464e-9854-3a6dcb5b95e6@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 26 Nov 2024 13:17:50 +0100
Message-ID: <CAPDyKFowPmNKDhn2Mb8QCGkO1cC1jkdHbMk94fxAur2D1fXqZA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Further prevent card detect during shutdown
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Anthony Pighin <anthony.pighin@nokia.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 12:57, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 25/11/24 14:24, Ulf Hansson wrote:
> > Disabling card detect from the host's ->shutdown_pre() callback turned out
> > to not be the complete solution. More precisely, beyond the point when the
> > mmc_bus->shutdown() has been called, to gracefully power off the card, we
> > need to prevent card detect. Otherwise the mmc_rescan work may poll for the
> > card with a CMD13, to see if it's still alive, which then will fail and
> > hang as the card has already been powered off.
> >
> > To fix this problem, let's disable mmc_rescan prior to power off the card
> > during shutdown.
> >
> > Reported-by: Anthony Pighin <anthony.pighin@nokia.com>
>
> Could add a closes tag here

Good point, I will add it when applying!

>
> > Fixes: 66c915d09b94 ("mmc: core: Disable card detect during shutdown")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks!

Kind regards
Uffe

>
> > ---
> >  drivers/mmc/core/bus.c  | 2 ++
> >  drivers/mmc/core/core.c | 3 +++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> > index 9283b28bc69f..1cf64e0952fb 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -149,6 +149,8 @@ static void mmc_bus_shutdown(struct device *dev)
> >       if (dev->driver && drv->shutdown)
> >               drv->shutdown(card);
> >
> > +     __mmc_stop_host(host);
> > +
> >       if (host->bus_ops->shutdown) {
> >               ret = host->bus_ops->shutdown(host);
> >               if (ret)
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index a499f3c59de5..d996d39c0d6f 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2335,6 +2335,9 @@ void mmc_start_host(struct mmc_host *host)
> >
> >  void __mmc_stop_host(struct mmc_host *host)
> >  {
> > +     if (host->rescan_disable)
> > +             return;
> > +
> >       if (host->slot.cd_irq >= 0) {
> >               mmc_gpio_set_cd_wake(host, false);
> >               disable_irq(host->slot.cd_irq);
>

