Return-Path: <stable+bounces-104108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97909F107A
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D96916C539
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420C91E1C07;
	Fri, 13 Dec 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgg8RGr8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AA1E1020;
	Fri, 13 Dec 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102626; cv=none; b=MZHlCr9Uv3RgiVVIgYKFCE/+H6Ha71D4jsxqF6ropoilH3sPqWtlgLnyK035mBaB0YHJv79cu0cFQYYk9q0TyopWf2ai+lxBYUVfjSG63K4ulo22Pm/PoTK/O06NKT+ZBT2/KehSQsJ60SSumINDEm1ahWz0giscIXtYI1NpGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102626; c=relaxed/simple;
	bh=7rGYYKks2MEAi+q8RZqhrYRZGipLH9Pjib1jzgb/fXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQxwzZhC4s0Qm1Jvts0aYTMZR9OcKYC+/5m+/fSXEDLRn/YUjV/dmNB1LQ/gBbmQTk+DOaMmdVVWO+RoSlWwkdpM89dhra6CQzsyCWV9191WkIwuhjnddihRANCOiJmewgI0A9rlhFYKEmuQ9O0cQjNUF+TuOFq62JQ/HLhus1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgg8RGr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B1CC4CEDE;
	Fri, 13 Dec 2024 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102625;
	bh=7rGYYKks2MEAi+q8RZqhrYRZGipLH9Pjib1jzgb/fXk=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=mgg8RGr8gIjtj61OhTetZkA1d0aGvS4JT7KCZpCYNQDG2jzCy+Ml1Clx3hHlA9Y4G
	 QCJloxPBQB4s7QSs3XFhkziBrVo5Ffrdgd6pFJ+yJ2zNSgfLXufwVxtcUwL77xoJCj
	 deverJ7wwOzwL2dHfFG5PVjhNVFLRfCJwH8Edt5TUeJale+JlHUMxgBKvHaflnwH6k
	 udpURyFhiZyNwh7lWWc9KXK6nTGPVX+q57g72weRLCs/k10h61sdyiKASYwmlv4Y9h
	 bcNjNa9fZwDzjCZ+oFPobiKbhbplIHAhxhmoaGlNJ1ooQ+NqPjjYZZWazuubNdohWi
	 wkp3WKBCh+bGQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso20763951fa.0;
        Fri, 13 Dec 2024 07:10:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzl3UxXsC+EmNlsKu9M7mAszZsOXF4oM224dIGw481/H/iYMqWKx05xokoBPtrkX6gjdoDjlj0@vger.kernel.org, AJvYcCXjzOW1AwLdceHW5A/0rP9WYQvjmzk7nc68H0KQ2es2cA/kQzr9qcxPdA4ihRaBQ5fRYS6mz/MD8qr/3rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGx/frohKNuEDukx+qsTEDZyI26R/OY3u6GzWIFRL9i/+lRrN
	hyZNhDck6v8q7Zb5b8nF4+LHF4f1BjMXdYstLsHO0IRFrRy2rgZh8i+e6tYQ58w7YGcmh9zfmMZ
	D5CQP9/YbTW3GzLcqxKIg9i3Tofc=
X-Google-Smtp-Source: AGHT+IGDFvr2zsjfqD8NaCsTVvFuyZlBxurx6y5trjl6JqR98HwSzgFaX+Zrs452OMiQuLpq6Zp9nyogMDd0TgQVXRI=
X-Received: by 2002:a05:651c:1994:b0:300:3a15:8f19 with SMTP id
 38308e7fff4ca-30254611fafmr13669331fa.32.1734102623974; Fri, 13 Dec 2024
 07:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213141037.3995049-1-maz@kernel.org>
In-Reply-To: <20241213141037.3995049-1-maz@kernel.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 13 Dec 2024 23:10:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v67vgoZr_1T579SrwG9UvNs0eRfT37Qk_g2k7Z-mRfEXNg@mail.gmail.com>
Message-ID: <CAGb2v67vgoZr_1T579SrwG9UvNs0eRfT37Qk_g2k7Z-mRfEXNg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: Work around insecure GIC integrations
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Kettenis <mark.kettenis@xs4all.nl>, Chen-Yu Tsai <wenst@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 10:34=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> It appears that the relatively popular RK3399 SoC has been put together
> using a large amount of illicit substances, as experiments reveal
> that its integration of GIC500 exposes the *secure* programming
> interface to non-secure.
>
> This has some pretty bad effects on the way priorities are handled,
> and results in a dead machine if booting with pseudo-NMI enabled
> (irqchip.gicv3_pseudo_nmi=3D1) if the kernel contains 18fdb6348c480
> ("arm64: irqchip/gic-v3: Select priorities at boot time"), which
> relies on the priorities being programmed using the NS view.
>
> Let's restore some sanity by going one step further and disable
> security altogether in this case. This is not any worse, and
> puts us in a mode where priorities actually make some sense.
>
> Huge thanks to Mark Kettenis who initially identified this issue
> on OpenBSD, and to Chen-Yu Tsai who reported the problem in
> Linux.
>
> Fixes: 18fdb6348c480 ("arm64: irqchip/gic-v3: Select priorities at boot t=
ime")
> Reported-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> Reported-by: Chen-Yu Tsai <wenst@chromium.org>

Should be

Reported-by: Chen-Yu Tsai <wens@csie.org>

(I know it's confusing, I even mix up inboxes at work.)

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org

Tested-by: Chen-Yu Tsai <wens@csie.org>

My RK3399 boots normally with pseudo NMI enabled with this patch now.
Also tried NMI backtraces through sysrq, though I'm not sure that
always goes through the pseudo NMI path?

> ---
>  drivers/irqchip/irq-gic-v3.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 34db379d066a5..79d8cc80693c3 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -161,7 +161,22 @@ static bool cpus_have_group0 __ro_after_init;
>
>  static void __init gic_prio_init(void)
>  {
> -       cpus_have_security_disabled =3D gic_dist_security_disabled();
> +       bool ds;
> +
> +       ds =3D gic_dist_security_disabled();
> +       if (!ds) {
> +               u32 val;
> +
> +               val =3D readl_relaxed(gic_data.dist_base + GICD_CTLR);
> +               val |=3D GICD_CTLR_DS;
> +               writel_relaxed(val, gic_data.dist_base + GICD_CTLR);
> +
> +               ds =3D gic_dist_security_disabled();
> +               if (ds)
> +                       pr_warn("Broken GIC integration, security disable=
d");
> +       }
> +
> +       cpus_have_security_disabled =3D ds;
>         cpus_have_group0 =3D gic_has_group0();
>
>         /*
> --
> 2.39.2
>
>

