Return-Path: <stable+bounces-35876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F956897A5E
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 23:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E0D1F2262D
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 21:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C9414C5B3;
	Wed,  3 Apr 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQ+Dks18"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676715099C
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178356; cv=none; b=e+AvufqK6lfHya9MeDsCrNJIDo1V3amo+6r6dJZsamWvPGphdP/c07H664tD3mNEqJf8My+qhmOApIqCxfn+ycO60/1ICHraBQ+mD6G4+A9Llnd/uLh2GNGZ4hqyCzKxo2DBT1EkU0tyl9y4Ted+KsL4lhAKaXadaZ+xaXIeLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178356; c=relaxed/simple;
	bh=WtGDdYc4HBCjOIrR5MMOAuCY7GEHvc1niaqFin6Qr2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts7+jVGcZjDFsw+Pb4PbErPAUgzw9NMNa+NDE/SDnlazeF4mGzwHWyADQe8sphZ4CUU9C6I6z5mCI4oCP432iHVrxmn4Kt1TuyGJU7ZZNBTxYBBQ627qOs9J/GhCm9z9WjYNQ1zyu6ZL0J17LM5AJCaccM0I72d4XwKRkMakRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tQ+Dks18; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so395568276.0
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712178353; x=1712783153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ2zC/UxSlUsZb+6YpO0+93Cw1cuUVB1VETkH9rRh5s=;
        b=tQ+Dks18accv24w25//sRe2YNyz96fnO08aayAdd/UIWQNmtXoMMBpjrwa5qbHQS0X
         2JZNt1JJ+t1MvRZK4r4VxnMtmesqaetsb4sC4zXD2pn5pkvmRUXHEwOXWrRO0P2E59hS
         +d/1VbZ+HT83n8MQVCqi2tVxlSWvaPEz1ZHxcD8mkKf9I+W9LvErtuZqJ+T3ynssG23j
         1M5Dso/eFWYayK4rc20GDGkQSuwlhomPiOiXzUL/Dsy5sDWy/UejRcC5isM2M4LoM9yN
         bHHBdVF/nMzFsWhlKcwtSQV4TvviIR0OeM5v4hZ1eUMZzctDBOx/iLi7HzzpCLuinB4C
         DNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712178353; x=1712783153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZ2zC/UxSlUsZb+6YpO0+93Cw1cuUVB1VETkH9rRh5s=;
        b=dRoG7pnmBVyMWtkgXX7prYkmN4GBq/0BK75yIOJ9ND0xBndxKAxAACFIJb69z2OwKm
         LaKCnnJXC1ehV9ul85/980NyuOX7hAYus6J4ESPovlvWx/klikJNS0yxkpwTXmhTKcP2
         t6v9YZJ/TRjHHWZt5TMXpov9WCbiUrFx/MhBD8njdTsHLLHpOpS+B1Gtkg97QpuJsiD/
         2+ZvtURwXoqzjIvCfVrPonMNtXdITsWSlSoKcEqwcaR5GOLOWJhyZVeYcztHaEcWQuNw
         CrVBt77ReN2xAMDLW/I+FU0+rkaNCqYjIkgC4ab12e6jo7kz69f/EnxLvlfal1v78cLc
         md5A==
X-Gm-Message-State: AOJu0Yzc4I24YEXBEGfivT8IBVcq3yFsWVAwG03XbypCt+SulIbzYhRf
	hnbZPRwBLWLmLZc1QnH3yvZrBuu1qOgJD5wRc1HvAsQWdAshaGxcSf5nT0nP9JZYg3n/zXVZFg4
	idJDzneaOsvd8CnmBlvW4uG2rk5pZyySUPubzZHpFhQqGSN483zI=
X-Google-Smtp-Source: AGHT+IFK9GNVITVRZuMylfRh87WeLv0p0NJO84Xzd2htMsv+SRB7Zi4jZzeCUnlB2tgB/2+Y7RFOPAcd2KiDVGHjHmA=
X-Received: by 2002:a25:874c:0:b0:dce:9c23:eafc with SMTP id
 e12-20020a25874c000000b00dce9c23eafcmr775722ybn.1.1712178353472; Wed, 03 Apr
 2024 14:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403160213.267317-1-sashal@kernel.org>
In-Reply-To: <20240403160213.267317-1-sashal@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 3 Apr 2024 23:05:42 +0200
Message-ID: <CACMJSesiDWonw83FfnneRLXu=ED27HHeqdsjUS0Xooba2fRZZA@mail.gmail.com>
Subject: Re: Patch "gpio: protect the list of GPIO devices with SRCU" has been
 added to the 6.8-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 18:02, Sasha Levin <sashal@kernel.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     gpio: protect the list of GPIO devices with SRCU
>
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      gpio-protect-the-list-of-gpio-devices-with-srcu.patch
> and it can be found in the queue-6.8 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 077106f97c7d113ebacb00725d83b817d0e89288
> Author: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Date:   Fri Jan 19 16:43:13 2024 +0100
>
>     gpio: protect the list of GPIO devices with SRCU
>
>     [ Upstream commit e348544f7994d252427ed3ae637c7081cbb90f66 ]
>
>     We're working towards removing the "multi-function" GPIO spinlock that's
>     implemented terribly wrong. We tried using an RW-semaphore to protect
>     the list of GPIO devices but it turned out that we still have old code
>     using legacy GPIO calls that need to translate the global GPIO number to
>     the address of the associated descriptor and - to that end - traverse
>     the list while holding the lock. If we change the spinlock to a sleeping
>     lock then we'll end up with "scheduling while atomic" bugs.
>
>     Let's allow lockless traversal of the list using SRCU and only use the
>     mutex when modyfing the list.
>
>     While at it: let's protect the period between when we start the lookup
>     and when we finally request the descriptor (increasing the reference
>     count of the GPIO device) with the SRCU read lock.
>
>     Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>     Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     Stable-dep-of: 5c887b65bbd1 ("gpiolib: Fix debug messaging in gpiod_find_and_request()")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>

I'm not sure what the reason for picking this up into stable was but I
believe it's not a good idea. This is just the first patch in a big
series[1] of 24 commits total on top of which we had several bug fixes
during the stabilization phase in next. Without the rest of the
rework, it doesn't really improve the situation a lot.

I suggest dropping this and not trying to backport any of the GPIOLIB
locking rework to stable branches.

Best Regards,
Bartosz

[1] https://lore.kernel.org/lkml/20240208095920.8035-22-brgl@bgdev.pl/T/

