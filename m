Return-Path: <stable+bounces-106207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0FF9FD580
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 16:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C7E3A4BF7
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAA51F63C9;
	Fri, 27 Dec 2024 15:18:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E573F9D6;
	Fri, 27 Dec 2024 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735312707; cv=none; b=Y5bcUtjdpEZPTcSShtt+fsqRXCnk42LtYln/AAyY3rTDj6GH3JvfAhyQJLBBB2e8BXrukJcxdYLND1onULL8SMMA/enOR/Ou0/rlPRCQucjLk/jF0t5ImkO8UiCyy4Bfr/fYu4dVrtG8oJuJHRCoDzHORx4nyYfQBO0SatIWTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735312707; c=relaxed/simple;
	bh=5mHgPD47KHRO3TRouHZwXsGVGtTqUwYDN+U+WO6IdEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrzCnKSJvKWI5dDocvjHNqxOouZpGAcQvZfGY7EbQEn7TYIPYcd40wcddW6qNuTdeD1wAbstBA1oC00fwjq9F8AOGoeFtyjEGduIjpl+D2X4olj2/gvYkSSkLMF8fvaQSEGn84+l8LHRrGjiU0xm7ohEXDNcp3TB4NU5Gug/4wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5401fb9fa03so7298274e87.1;
        Fri, 27 Dec 2024 07:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735312702; x=1735917502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0eDlOw9p3DnVtbNe3F5E+YgQxPXK7eYD6omdeJR05k=;
        b=eMfK+FGLi0PSA30t8KPhaodRLmn2byocjuzac7pzyJsiWdj+Uxe8t8G8hLJm9DX7dJ
         MQSspMm4n+0M1HF+2ju5+l4D7KP4AmrwCYSD51t7EtgGK92FvJximQ/2MhagCE20KAGy
         g50+s4IjkLUJ8/YJqiz0YBZnJMV1JYWqCv/1nJx3dnsvOaxUYW2LB5O5MUjAHsGkI79j
         5u0raFWnkIY/+qBPxW/3qY5hO4sfUGErrg0nuU0dFXZUPm5KRMxiNuAACq0BP1Wh5IBi
         gmp65zEdMCA66eZgADfDNmzIndYxnQA7xEoqel23ETLScbAqB0Zz4can8DAwVa+KlyJH
         maRA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+crzksLcnyAX5yO3jJ22NN8HtpZIJTAhWreFdw7PvWbWFGc9wjdb9tZroMTyX57d9PSM9sIAA4WkPJuD@vger.kernel.org, AJvYcCVdCJvHHCUdJ6xEyCNaGuDBD58U2ukVHtb4bn071JScPlNJPs9LZp9cF1azzLHi7hjobFFsS5FNCWA=@vger.kernel.org, AJvYcCWoBRj+iJw/y+NDz8ZQep+Lr7Frq4ppE9O809Hvho0OjkSofJPs4tNKeXeuFBpBGu+qbt/Xlchv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzodi63ro38RjfhKemQZYCK8uRL/odsnBmVbc4fwg6qhi9qGB5p
	2er8Qi/1ilkM/VlF0+nNrRXVmG4NufWbDs61+Uk+uWAbWqYxjAvIfx9LtHzV
X-Gm-Gg: ASbGncsFV2rPgI7NeU2rAHcPfTd/rkQ6tVKdFtp+WEn+GUUpEVFXflWTkx0p6yZh7gn
	RWFHO7xQ7GR0bDLMt6AtdbSuNa97Akv/STlDQAeLgmSx808SLT6wMk65MDMbSh1Xvhfwf0VPIUk
	AjR0gx66VTgLRG6lDV3/b6uMxQjeHsgkbN941IgAE+CcxFsbRxbQeqCeDFRMpPQ28t0C7D+g3Am
	v0NIaq6RHKcKkUywX+md293S3/VgqTiYWwa99Wb46sH9YqAaiPb7M9XSSi1t3VR/0YWsyJQaKzI
	Yz5uhUgrc0M3HQ==
X-Google-Smtp-Source: AGHT+IFB/fuyS34HvKmc8Aw7C+i39y90Wsl1/tRIoZtj5qXrbWyoPRmGQWLR6giyKuhCWTzRUpRI7A==
X-Received: by 2002:a05:6512:1246:b0:53d:f769:14cb with SMTP id 2adb3069b0e04-5422944350cmr7783825e87.9.1735312701961;
        Fri, 27 Dec 2024 07:18:21 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238135a0sm2434736e87.151.2024.12.27.07.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 07:18:20 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30033e07ef3so37764241fa.0;
        Fri, 27 Dec 2024 07:18:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxclGAWVzNQ6ZI1xSENgxnhs3NutUG1/WfWa+kWZNjB1XFLPR+HJLiKuIF939AfEJo2JnKj19i@vger.kernel.org, AJvYcCWdg4/kn+3EyHsFjfQTWjBWPFhl3z0pFlXXVKJJXfyIRf9f7clQuzahvlKHWmcnMDbTjtvhu12BF03semGs@vger.kernel.org, AJvYcCWvDuiaeXuKCBx2LVCaTN6BPaf7zQPQoeQrcv7JTMLgO6tTfMih1CroX52/f9rCc0beyaDC8XesFrg=@vger.kernel.org
X-Received: by 2002:a2e:a591:0:b0:302:1fce:393d with SMTP id
 38308e7fff4ca-3045833692cmr107500831fa.2.1735312700069; Fri, 27 Dec 2024
 07:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109003739.3440904-1-masterr3c0rd@epochal.quest>
 <173124139852.3585539.10704015898700065278.b4-ty@csie.org> <9415ca9c-f303-4507-8cd6-cb08ee09e988@linumiz.com>
In-Reply-To: <9415ca9c-f303-4507-8cd6-cb08ee09e988@linumiz.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 27 Dec 2024 23:18:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v650sctP83mdoYtcws2zVzJzfBqq=AvAXYH-WaOoPBDx2Q@mail.gmail.com>
Message-ID: <CAGb2v650sctP83mdoYtcws2zVzJzfBqq=AvAXYH-WaOoPBDx2Q@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: a100: enable MMC clock reparenting
To: Parthiban <parthiban@linumiz.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Yangtao Li <frank@allwinnertech.com>, Maxime Ripard <mripard@kernel.org>, 
	Rob Herring <robh@kernel.org>, Cody Eksal <masterr3c0rd@epochal.quest>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 4:45=E2=80=AFPM Parthiban <parthiban@linumiz.com> w=
rote:
>
> On 11/10/24 5:53 PM, Chen-Yu Tsai wrote:
> > On Fri, 08 Nov 2024 20:37:37 -0400, Cody Eksal wrote:
> >> While testing the MMC nodes proposed in [1], it was noted that mmc0/1
> >> would fail to initialize, with "mmc: fatal err update clk timeout" in
> >> the kernel logs. A closer look at the clock definitions showed that th=
e MMC
> >> MPs had the "CLK_SET_RATE_NO_REPARENT" flag set. No reason was given f=
or
> >> adding this flag in the first place, and its original purpose is unkno=
wn,
> >> but it doesn't seem to make sense and results in severe limitations to=
 MMC
> >> speeds. Thus, remove this flag from the 3 MMC MPs.
> >>
> >> [...]
> >
> > Applied to clk-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, =
thanks!
> >
> > [1/1] clk: sunxi-ng: a100: enable MMC clock reparenting
> >       commit: 3fd8177f0015c32fdb0af0feab0bcf344aa74832
> This commit is missing in 6.13-rc4. Will it be merged in the next rcX?

It looks like I tagged the wrong commit when I sent the pull request.

I'll try to send a PR for it as a fix.

ChenYu

