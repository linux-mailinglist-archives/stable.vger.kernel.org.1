Return-Path: <stable+bounces-70091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179A695DE7C
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 16:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47551F22E2C
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE50217A5BC;
	Sat, 24 Aug 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDMTk9dN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6297176AAB
	for <stable@vger.kernel.org>; Sat, 24 Aug 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510434; cv=none; b=kZgX6EFPwY92e3v4b00LxhdtVm/38m5TCxPAqGwxs9Hwg2ItlImrOyab+mtVS96tNDy8BlQxxTZO7gIYO1sU26j/dBrc6LFS6zU3ipfqnj8CcWSv6g7LThn3kEr+LCoXVpwf3SgL+PwLf01MQrLPItjBD9lwFgtKcfkhy69DuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510434; c=relaxed/simple;
	bh=M+00aPqAIJfQiLjQyOBdsrvt8KcSjON06jxPta54+9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAM8iXsvzhkEyhFnavtKDAD0J6yaSewOKjNj6d940EA5MFKU4gE2PEC0rj1to/zeug07NG34FMM8dRGJMwfe8SP4PS767R9uxinaRVs4XcBOuSCuZJhGRv/HdrVXlo0jHiJA7DAqh0yR+OGX7apN7yQ4lk99UHqA9YPZ3pqHY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QDMTk9dN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53345dcd377so3763751e87.2
        for <stable@vger.kernel.org>; Sat, 24 Aug 2024 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724510430; x=1725115230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+00aPqAIJfQiLjQyOBdsrvt8KcSjON06jxPta54+9s=;
        b=QDMTk9dNOUy0+i8YYeYxAOhm2q3fWfLYizvZUngq8S02sjpKAIumowxwQQ725rgXzL
         VRb515NEiF/W67k/y8/jF4UHYo4+e22XcW9bUwRIRsXexC+06QXfL7w/DOw8daCXPfS2
         sE0YNMZFJzRP9+52+adbO3cQTkab4SxLymLA/cVd6ThiswP2Fm4suqtEze4CUFchFXFg
         3+g2yu41sTN18vx08KOh9gDv6VXJaLsDT9hurr0jURKFsnwz9b9cv+3fgrXH7ZGLyU2j
         0u0oRnvnXZ77IP1ajyZHhNZqYlHePvG8+9nyH7FKDUKjnK8LPH8Lo+xPpvWF93t7qQBc
         qCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510430; x=1725115230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+00aPqAIJfQiLjQyOBdsrvt8KcSjON06jxPta54+9s=;
        b=NNwGzbb+7eXWT54JVd5M+/25R1vwiibWmuSFkl8qd4WklXw0EbcJzSgW8CMBMKIaWZ
         Wlh2rmb6lCbU44WdLCYzjUNTO6n6aOw2K7jClJwEdOSILZLpkGRDvLVAJWRBlkNLyIdu
         rTQQ6XmhmUVVKvx/KmcNN7qCvjWgr+IzamJ2LC5fjcducTyOu6P5fDR3BCvRqGOqjdFE
         IuTMc6mE4WT8FjjLLfyUWmY2f6fu5AvO6Qjj8D6l+oeXKFkCmAZkyfiC6whYgEQNseBa
         gioDLxhIvKtm9upWbyDNIZX7YakHdtOUxdgaO/pDxboGAeFH615rNFRWKInB+ya2FabB
         Qwqg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Ci8n/qwxWJzOHxuBplwd3HWaXe6ngXOQtI9WhMI5KGzjMacIP0n1Y7/VkwasgSD0NeBs0as=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhiVo8+XJ9RCIGHvTGA+nmN35uDibKoUpwDr+WTcEnEkalef6
	pDM+K/PlX4gj/QhJ3fGyX+vHoFNi/pyoh7NC48AF2AuNPqG0xTw4+lg+AcVp67MMugCKhCZ/Stq
	EpQ0xolqlpsXY2HMj4sNGAGhC3Usf9h398M7Ct1jgtH4HAPvM
X-Google-Smtp-Source: AGHT+IFUWwNU4JjKJfUkk5+b7VaNM9tcGLgDxOphG4oT66UVqnMDc84a+SVvS7/Tom2C/L+hvh4W6uCE9zsb/aWB89Q=
X-Received: by 2002:a05:6512:230a:b0:533:4560:48b7 with SMTP id
 2adb3069b0e04-53438783ff4mr3214329e87.30.1724510429403; Sat, 24 Aug 2024
 07:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709105428.1176375-1-i@eh5.me>
In-Reply-To: <20240709105428.1176375-1-i@eh5.me>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 24 Aug 2024 16:40:18 +0200
Message-ID: <CACRpkdaekcM-rGNzczQFFwDcte8cR2D=j6LB9h5W1XRbBtBhJg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rockchip: correct RK3328 iomux width flag for
 GPIO2-B pins
To: Huang-Huang Bao <i@eh5.me>
Cc: Heiko Stuebner <heiko@sntech.de>, Richard Kojedzinszky <richard@kojedz.in>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 12:55=E2=80=AFPM Huang-Huang Bao <i@eh5.me> wrote:

> The base iomux offsets for each GPIO pin line are accumulatively
> calculated based off iomux width flag in rockchip_pinctrl_get_soc_data.
> If the iomux width flag is one of IOMUX_WIDTH_4BIT, IOMUX_WIDTH_3BIT or
> IOMUX_WIDTH_2BIT, the base offset for next pin line would increase by 8
> bytes, otherwise it would increase by 4 bytes.
>
> Despite most of GPIO2-B iomux have 2-bit data width, which can be fit
> into 4 bytes space with write mask, it actually take 8 bytes width for
> whole GPIO2-B line.
>
> Commit e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328
> GPIO2-B pins") wrongly set iomux width flag to 0, causing all base
> iomux offset for line after GPIO2-B to be calculated wrong. Fix the
> iomux width flag to IOMUX_WIDTH_2BIT so the offset after GPIO2-B is
> correctly increased by 8, matching the actual width of GPIO2-B iomux.
>
> Fixes: e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2=
-B pins")
> Cc: stable@vger.kernel.org
> Reported-by: Richard Kojedzinszky <richard@kojedz.in>
> Closes: https://lore.kernel.org/linux-rockchip/4f29b743202397d60edfb3c725=
537415@kojedz.in/
> Tested-by: Richard Kojedzinszky <richard@kojedz.in>
> Signed-off-by: Huang-Huang Bao <i@eh5.me>

Patch applied for fixes!

Yours,
Linus Walleij

