Return-Path: <stable+bounces-128418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D8A7CDEE
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 14:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D4616C5B5
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5BD1C5D57;
	Sun,  6 Apr 2025 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7N0QPC8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8819EED3;
	Sun,  6 Apr 2025 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743943583; cv=none; b=I8T2hZhAZs2xYtqH8h1wK+6+C55t3GQtZjerLmLHm6OPPJwE6PeSZvPu8jMrgQsRw5VaHntaqL+yL5zRIVlxE4JcZ1YX0VyhDJvNFI6C9DrLuQF9YfED5mux/3KmuKzIj1OkPUqpxodyNja9Zhme+m41JFqcSBAovF95Y7YktTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743943583; c=relaxed/simple;
	bh=gDRUi0NI8kQYwmKuZl0m+Ur9O2Fc5C+GFVFGTF5IwGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1Pj2JJ9XuBBluNZB6eycoAIoQbk66/MFXwbLTP4VV5yKnt+r2MAdysaCF12DC76/7EXDpfnO2FkR9jOHkUz1yEnn45ijHx+TY0dNVOivBsuRzHNgeNbJEGrgFnjYraSPSEop1vuwoMmL3QFtebIKlpkuPsgEG5PheZy1r3iIvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7N0QPC8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25520a289so599712166b.3;
        Sun, 06 Apr 2025 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743943580; x=1744548380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ircvmU6AcvisynzACHzv5i+leKz+5HUrSfkvcOot0M=;
        b=D7N0QPC8PPlL3wwltBnQBUAWIr57TvR9nnyHuFV4q5zWda63KXAi+mU1YMWSUgrlLO
         eJyiN+2aeuYReKEwHoIANmGJ146KSwv2yHjiToRPqqgUiHoiDccPJPCTrznUc6ZyYGjq
         ykdAr06WLoNPjx7yQ0P66bx3EOIbnUm0P9+rSkP9ltaYrxkdCSf8UUZVfMZWYY2Q6Rll
         TvF6BvNRrJff1XB9idB24G5Gnx7/I/OJ6IzPCZYJ1R+/G5bML6yq6zMLCFSqRiW+BXZH
         i3DP8vExjM9VdUJcklXjXGk0LQH584w4NgadHPNAh5gPBbAKdOgwmDse4M+JfMt/n77L
         /IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743943580; x=1744548380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ircvmU6AcvisynzACHzv5i+leKz+5HUrSfkvcOot0M=;
        b=McDM13t/658+xzFqkuJaKVagV6X3FKdIot1A41sdO70r/Lak2gZPINJYh7FHgub+JN
         OFNo2kPalHlnvUha/LAzdd+WorafdvyPMKAYGk6XApd8bnIDsGH35DOkq4g1MoCw9k2t
         PZyP+7zdOWMnMXifDuJjchvWi1Nddu5DDoYqOmxoPudciQgTXwQGSQshMJDFq9GNOxo/
         NqBc8xGg+NDyhDRTIOzx6Czh/F3C1Qn38vl/9joeW6SW1sifZ7gabk4PbP4XPL/Vtors
         s5tByUkE0Is4bT7kfVvU7JfVDEOGhidz1Nac7jbTWxFp5cfBrOpH2lveMEfLlztIBLQY
         SgKw==
X-Forwarded-Encrypted: i=1; AJvYcCVkYoQWwJGUfwnuP8ntNV28AOh5W3cfkL1syG1j8kfty5FqTVgzMX3fmG/rl4uNrHdP6fqAwfyj1Uo1QKM=@vger.kernel.org, AJvYcCWIW/qcwXh0fPp+r/2OfPciXnlpGy0wApy9PhfwFrDQw7OgJ/P4XPogN6uPUuSgQ+KsuYZNMtMw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9ps9ShXNQjD0zl7o1qFL+aT2MR8FU+RnyEABVgJA14xIndjF
	cMDy0IMdYt/zZFeQJD58WDo151J7Sw8OIPZ8zsGNhsWUpet+XvIuVqwIMLxK+VWKm+nZdCKdlbk
	TcqLCPwac05LmWnJcVDW4YCWe3IsaIBL9wmE7XSix
X-Gm-Gg: ASbGncu6ENuh6jd40/gwZD1wrYroFM7mTDcLHOOtxHRaYd9q/HppNURgwC7u5Lnuzll
	Rrua67GdrfraV8DNNfLqJDPJU0HbSG6XZHa4F1cfLfYCqEKQwBgziB7shAt66Hr6dpKR2FGqSXg
	VX5+b2jNqhCrVVhOgtDYe0ujkl
X-Google-Smtp-Source: AGHT+IGitcGraUpEzeGPayo9yp88AFDu4vcwiHo9XtmluhHdkA/424R1XEhpG0A0l6iLG8NPlldSEUx5kp3+sw1SFDQ=
X-Received: by 2002:a17:907:72c3:b0:ac7:9acf:4ef with SMTP id
 a640c23a62f3a-ac7d6e9fe06mr730495366b.56.1743943579980; Sun, 06 Apr 2025
 05:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402092500.514305-1-chenhuacai@loongson.cn>
 <87jz81uty3.ffs@tglx> <CAAhV-H5sO0x1EkWks5QZ8ah-stB7JbDk6eFFeeonXD6JT9fHAw@mail.gmail.com>
 <87bjt9wq3b.ffs@tglx>
In-Reply-To: <87bjt9wq3b.ffs@tglx>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sun, 6 Apr 2025 20:46:12 +0800
X-Gm-Features: ATxdqUHAzOTUEtG6B6EooHmEZYykWnMr9U5FR11OuJop70kp4nyf68vPoNg1nrY
Message-ID: <CAAhV-H6r_iiKauPB=7eWhyTetvsTvxt5O9HtmmKb72y62yvXnA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-liointc: Support to set IRQ_TYPE_EDGE_BOTH
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Yinbo Zhu <zhuyinbo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 6, 2025 at 6:18=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Sun, Apr 06 2025 at 17:46, Huacai Chen wrote:
> > On Thu, Apr 3, 2025 at 11:48=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> But it won't trigger on both. So no, you cannot claim that this fixes
> >> anything.
> > Yes, it won't trigger on both (not perfect), but it allows drivers
> > that request "both" work (better than fail to request), and there are
>
> By some definition of 'work'. There is probably a good technical reason
> why those drivers expect EDGE_BOTH to work correctly and otherwise fail
> to load.
The real problem we encounter is the MMC driver. In
drivers/mmc/core/slot-gpio.c there is
devm_request_threaded_irq(host->parent, irq,
                        NULL, ctx->cd_gpio_isr,
                        IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
IRQF_ONESHOT,
                        ctx->cd_label, host);

"IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING" is an alias of
"IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING", and
"IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING" is
"IRQ_TYPE_EDGE_BOTH".

Except MMC, "grep IRQ_TYPE_EDGE_BOTH drivers" can give some more examples.

Huacai

>
> You completely fail to explain, why this hack actually 'works' and what
> the implications are for such drivers.
>
> > other irqchip drivers that do similar things.
>
> Justifying bogosity with already existing bogosity is not a technical
> argument.
>
> Thanks,
>
>         tglx

