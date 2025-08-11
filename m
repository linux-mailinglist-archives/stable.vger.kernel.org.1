Return-Path: <stable+bounces-167043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DBEB20BBD
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E103ADBDF
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC172222A6;
	Mon, 11 Aug 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lm6ZOVe1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC37222574
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922010; cv=none; b=fy8lG+y+GhwheZR7xyff9ADeWfM1FZF/Aot6J9XHzs0qPhPcDBIgcCf+99rVPT6kg682RCMN+b0Wl98+b7W5oE6W17iTRJsi7LZ0PLlIFarSeNWoPYxL0awJI1JmfDJ6GJuakyjpBSfB9LI+/W0ulYr9AJkgqtxFadSbXLc4ntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922010; c=relaxed/simple;
	bh=jYD4kWAtWMcGxxAlPQwefaPoLEVyNlKGrUOxVdsqY7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJ0xBX/3IJKm0oBC87vZM30+rKWRP+IYz9UbEFKDCaDarQuQ0nEDUASFooesbWdviFJjewN21ws2aolRe3HJM6YG0SFevzsgS4xegJMMxGkdzsMJfvdVFYzfasv+91yzSZkIkItMKi5NKdmLqR+Mp5Uk58uLFdWWRM4N4DxsnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lm6ZOVe1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af91a6b7a06so745284966b.2
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754922007; x=1755526807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VpD34gYBuiTanpGKm0aJZ4wv7pzm53YKQMhyVtZd5Y8=;
        b=Lm6ZOVe15AReqA0id/p2nlD8fmIh+jckijZ6oMG+dpMM48ji+zc2dcezOW+KxRQUnx
         SYkfOHbC+bPjaHtNRaQkEpoPlQ8QNinH1AbD3nSP+uEqD/DBzqCHxn753KUYUhSdTqCZ
         hZJGY8AnLvOTVHUEEMH8SF3/dK6SRJ+AJx9xzS/9pymV3czHNzEBKvdkzR7ff7x1eSSe
         4VE2tRFWN+cwbkj3CEtsB7K5sSY472fogYZL6/fj2jp7Ew59mj5Zf38/KbcQMu0jJ666
         tS4S0IMqzj9kN2QfshnTmenWFVvGXdgU5GzyU7q9AE1LqlLy3lj7/MX/lFiol3YDIOl8
         0z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922007; x=1755526807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpD34gYBuiTanpGKm0aJZ4wv7pzm53YKQMhyVtZd5Y8=;
        b=k0wjkHMu5ghdNVfpBTRWG0SGAkWrbl9dtJ18QXbkBV3d/L7O3MjIe/1OWUNkMxQ/BX
         ap+79Sv8/IeKahvxks1FEFSKsA+zquOk+AXwgTNYL5dWsgTJs4zWBT7FbpHQgChy416t
         T4T7RST1j9hMH6tjd2Awe4X7R4K8i2WO/boBwOpO0Ci3hXXbzixtdYfqjobvIspQ+k7L
         o0Eo2vcOFgMqTMZqRjq3Tzxa91AXnNEAZJFylcs4mtra6Wpm/LfUgs1oEuOB0FrQ1Tty
         Wv0kFYPsIwfaVkVuQ1EIDMj1Y+tU3YSZp/QAQoSXSiyen+Ay9/xANOVx8/5QGc4jDS8n
         Sv/Q==
X-Gm-Message-State: AOJu0YwHtzGosSXt+PM3hewGoay0qZpQFWRXxfNBbsWlH+JZTWXm3mLO
	rLesnku7d6CYoCI7Y1qKgRbxcSlcqdvNk1Bw7APus/Jj/UnNO8U1fbqJusSIeC4B98plJ4lG9t4
	HPfeSUCWTBZa4Y053DKS+zyjrKFF/AaoEPG0HZ0rSLqswdZQgdEjJ
X-Gm-Gg: ASbGncu2Ak697+/Uk9d/aRQBy4C0a0fviNWmCPPc/ildrZRRJjKiXudlKQgyEC9v1uQ
	cw4XYfE7abknsSqgBq3DEPyi6ZDXuakZwfeqs95HP45LFiV5q0LYa/DobCcYIa7k2RfSxfVMEnB
	+wPZdUFEXUsIWlL8nTW26+GbTcj/KqTOidL6t9z4Xh8hQlloqZuBmLZmUu/G7Tkz4FAWZ5tbMvL
	gMORI6K4VgeS8F17xi5KmSvaSnXwrRcRnO5JaU=
X-Google-Smtp-Source: AGHT+IGdnRT/JmbOdxoLgRYpJ86bpbdi/G9nk4lwPtDHsVWnDo9eWLEoSKyxpv5ASP83CpE+8LM2trVDVs7cuPbu0d8=
X-Received: by 2002:a17:907:268b:b0:add:ede0:b9d4 with SMTP id
 a640c23a62f3a-af9c6055168mr1186273666b.0.1754922006864; Mon, 11 Aug 2025
 07:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811044003.1932937-1-sashal@kernel.org>
In-Reply-To: <20250811044003.1932937-1-sashal@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 11 Aug 2025 16:19:55 +0200
X-Gm-Features: Ac12FXwP2xNPgIwxTdFvfM1n1bGTLujPvieuAAtHfHtl5RHrajDe6RCQ6lst_ek
Message-ID: <CACMJSesNRqZLPrHcJF5aU=aR0nBKoseHmjD0mFQf_tV_9B-drg@mail.gmail.com>
Subject: Re: Patch "ARM: s3c/gpio: complete the conversion to new GPIO value
 setters" has been added to the 6.16-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Aug 2025 at 16:18, Sasha Levin <sashal@kernel.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     ARM: s3c/gpio: complete the conversion to new GPIO value setters
>
> to the 6.16-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      arm-s3c-gpio-complete-the-conversion-to-new-gpio-val.patch
> and it can be found in the queue-6.16 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

This is not something we should backport. This is a refactoring targeting v6.17.

Bartosz

>
>
> commit c09ce1148e4748b856b6d13a8b9fa568a1e687a2
> Author: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Date:   Wed Jul 30 09:14:43 2025 +0200
>
>     ARM: s3c/gpio: complete the conversion to new GPIO value setters
>
>     [ Upstream commit 3dca3d51b933beb3f35a60472ed2110d1bd7046a ]
>
>     Commit fb52f3226cab ("ARM: s3c/gpio: use new line value setter
>     callbacks") correctly changed the assignment of the callback but missed
>     the check one liner higher. Change it now too to using the recommended
>     callback as the legacy one is going away soon.
>
>     Fixes: fb52f3226cab ("ARM: s3c/gpio: use new line value setter callbacks")
>     Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/arch/arm/mach-s3c/gpio-samsung.c b/arch/arm/mach-s3c/gpio-samsung.c
> index 206a492fbaf5..3ee4ad969cc2 100644
> --- a/arch/arm/mach-s3c/gpio-samsung.c
> +++ b/arch/arm/mach-s3c/gpio-samsung.c
> @@ -516,7 +516,7 @@ static void __init samsung_gpiolib_add(struct samsung_gpio_chip *chip)
>                 gc->direction_input = samsung_gpiolib_2bit_input;
>         if (!gc->direction_output)
>                 gc->direction_output = samsung_gpiolib_2bit_output;
> -       if (!gc->set)
> +       if (!gc->set_rv)
>                 gc->set_rv = samsung_gpiolib_set;
>         if (!gc->get)
>                 gc->get = samsung_gpiolib_get;

