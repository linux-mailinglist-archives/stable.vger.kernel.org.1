Return-Path: <stable+bounces-181896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CA5BA9231
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C331781D4
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC73301482;
	Mon, 29 Sep 2025 12:03:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A32F9C38
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147420; cv=none; b=UM9cOoWtd3lMhHfVx5vKncnR4jjJClwlXdjKP5UecSEW19DoGe6BkZHWZA6vU/8hRFIcy+bYMIA+pPZZOKDgBTdCv5zmXVCvDB7W8l6AbJMi/uarUmzZMuCrVfUd31/oBLbNKd6/x35uuUGNAKH+EN56ffaCuuYNkzqHc29PHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147420; c=relaxed/simple;
	bh=iLYkCX8MnbGM+WvBqu5+ySMmMdQcE0wd6aLEFI6IROE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fg5Qpt/UhNt00Ra2i9OF7WUYPrwu832X4ecf3DpQhKFwyRysZKQwBxdiHfVrjg3tVv19L9TJhbFzhwg+dqcfczs8bfM5IIQ+WYo3cw5mC1sXdrbAclylBPzVvKJ6D3VzVokh5PuhbA/yMcF7yPLc148GzHuzHI6w3/D1pKZ3aF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7abbdf3c476so3260520a34.1
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 05:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759147418; x=1759752218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXIms1qxK4a3gyYpBmcKGTsZc+c3udJFil3wkwqeK0w=;
        b=oh/0SvnuOUe5XAgOYlwXZHlE+gNMTH5CIg3NtEHCIjSb3I8N2vt2r8ddCjTEzOPt1O
         NwAR2ftRBARTcpH6iuAIdsn9O6gzHjbF1yI6ToklnuP44uMyySw/18YR5fYhOj/gxQAI
         7332D+4Ad2+o2Pxkc+O8ddv9wcmtrXBWe1dkq7sZUHGGxNv4vAGTM5Rj1KSVASIlrXIz
         7uNU6faAEYCR0HeRMxDHgOPWlPtiC7hU6LwwQ0NL64Fez4eo61vishUoKgrz6pQSOeuc
         Gri4NJHDIRbCQ4NqwKigr3gMnx7dELR31tcL+r5gxOxM9d0B2s7OsP1vRjaxwGPthaY/
         I2cg==
X-Forwarded-Encrypted: i=1; AJvYcCVv1qxJa99guZNoOLum6BlNxE4X8ZO7D3woIUeH32QixIVtRxRb6OwT5Tm3ZGW1owjen6uSgfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQz87xBT0th5FU1GMr4CrfBm+gb/NAOWwEKGQrDuFvi3grzti
	2zUak9omO5VCuOLl/NQ6+CSEcAD+DGHCnXNQx7RAd9EQfzlV3dOwyRJJXusSyWmj
X-Gm-Gg: ASbGncumvqNs9uVPiqREWdTHKmBIzG/I0gSqKMHXNyvSN6HZtrHU3+5XSwsLEEPfVf+
	KfpnAyp1byN9q6CJYTUC6s209nbI779AJWYG53iTh+xgJDXgPw9zlCPIfiu1MbbmwomQTapGs66
	NHB8OXB6wYyYs31rpSAnyeSfBcGYwRRx+SUDX+tYlcbdLetxsSSaT13f6rfT96hf/ccWR07+XAu
	bdtCmU/2ZfYQNcjU6vRPA3R4K/eH1nnvpKPv8+PoRr7bV8ujvC4O0VmsxLu5HV7moDufh0llFdY
	8YznNdeGUsvnX81Af+XCrCQsvkGjoswS+FS2xzNTtn3cGUeD4SfjXh2NSrV5RY4nETPHwp5Fyet
	6pIfkCCGMR0CeEgmZcly/OX2zUF/+Y5ifAD/Rr+MG+/Bg8QqmGLj29xu2U3SdJe92/qfNMH6OtD
	I=
X-Google-Smtp-Source: AGHT+IF5r4DTUMfemoQAVo+OAXBIIdEV7DEkmm7EclZuBd7NmLnDfw+KQFgGdo5JSK9lbpfd+t48aA==
X-Received: by 2002:a05:6830:6084:b0:745:2585:9c57 with SMTP id 46e09a7af769-7a044bce569mr9863261a34.7.1759147417717;
        Mon, 29 Sep 2025 05:03:37 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7b5d4c63648sm960536a34.35.2025.09.29.05.03.36
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 05:03:36 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-43f8b797db6so336588b6e.3
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 05:03:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXldpNZ3R3f5r15zsiMkxvvHEJp/XNhlhfp7bdA7GGojUrO+FFo+V+GaGD4+6JOmoyt7e2qoiA=@vger.kernel.org
X-Received: by 2002:a05:6808:221e:b0:43f:6a3f:8684 with SMTP id
 5614622812f47-43f6a3f888dmr4624453b6e.46.1759147416004; Mon, 29 Sep 2025
 05:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912095308.3603704-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250912095308.3603704-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 14:03:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXv1-w0SE7FZy5k3jg2FO-a-RB2w1WB=VM_UFEA9zjWDw@mail.gmail.com>
X-Gm-Features: AS18NWC7v-OseuyFqrHruqAuq7rYHWtEGJnN6neIxNJcWvFaWXQAD7P7nX1ecUQ
Message-ID: <CAMuHMdXv1-w0SE7FZy5k3jg2FO-a-RB2w1WB=VM_UFEA9zjWDw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: renesas: rzg2l: Fix ISEL restore on resume
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, biju.das.jz@bp.renesas.com, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Fri, 12 Sept 2025 at 11:53, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in
> gpio_irq_{en,dis}able*()") dropped the configuration of ISEL from
> struct irq_chip::{irq_enable, irq_disable} APIs and moved it to
> struct gpio_chip::irq::{child_to_parent_hwirq,
> child_irq_domain_ops::free} APIs to fix spurious IRQs.
>
> After commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL
> in gpio_irq_{en,dis}able*()"), ISEL was no longer configured properly on
> resume. This is because the pinctrl resume code used
> struct irq_chip::irq_enable  (called from rzg2l_gpio_irq_restore()) to
> reconfigure the wakeup interrupts. Some drivers (e.g. Ethernet) may also
> reconfigure non-wakeup interrupts on resume through their own code,
> eventually calling struct irq_chip::irq_enable.
>
> Fix this by adding ISEL configuration back into the
> struct irq_chip::irq_enable API and on resume path for wakeup interrupts.
>
> As struct irq_chip::irq_enable needs now to lock to update the ISEL,
> convert the struct rzg2l_pinctrl::lock to a raw spinlock and replace the
> locking API calls with the raw variants. Otherwise the lockdep reports
> invalid wait context when probing the adv7511 module on RZ/G2L:
>
>  [ BUG: Invalid wait context ]
>  6.17.0-rc5-next-20250911-00001-gfcfac22533c9 #18 Not tainted
>  -----------------------------
>  (udev-worker)/165 is trying to lock:
>  ffff00000e3664a8 (&pctrl->lock){....}-{3:3}, at: rzg2l_gpio_irq_enable+0x38/0x78
>  other info that might help us debug this:
>  context-{5:5}
>  3 locks held by (udev-worker)/165:
>  #0: ffff00000e890108 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x90/0x1ac
>  #1: ffff000011c07240 (request_class){+.+.}-{4:4}, at: __setup_irq+0xb4/0x6dc
>  #2: ffff000011c070c8 (lock_class){....}-{2:2}, at: __setup_irq+0xdc/0x6dc
>  stack backtrace:
>  CPU: 1 UID: 0 PID: 165 Comm: (udev-worker) Not tainted 6.17.0-rc5-next-20250911-00001-gfcfac22533c9 #18 PREEMPT
>  Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
>  Call trace:
>  show_stack+0x18/0x24 (C)
>  dump_stack_lvl+0x90/0xd0
>  dump_stack+0x18/0x24
>  __lock_acquire+0xa14/0x20b4
>  lock_acquire+0x1c8/0x354
>  _raw_spin_lock_irqsave+0x60/0x88
>  rzg2l_gpio_irq_enable+0x38/0x78
>  irq_enable+0x40/0x8c
>  __irq_startup+0x78/0xa4
>  irq_startup+0x108/0x16c
>  __setup_irq+0x3c0/0x6dc
>  request_threaded_irq+0xec/0x1ac
>  devm_request_threaded_irq+0x80/0x134
>  adv7511_probe+0x928/0x9a4 [adv7511]
>  i2c_device_probe+0x22c/0x3dc
>  really_probe+0xbc/0x2a0
>  __driver_probe_device+0x78/0x12c
>  driver_probe_device+0x40/0x164
>  __driver_attach+0x9c/0x1ac
>  bus_for_each_dev+0x74/0xd0
>  driver_attach+0x24/0x30
>  bus_add_driver+0xe4/0x208
>  driver_register+0x60/0x128
>  i2c_register_driver+0x48/0xd0
>  adv7511_init+0x5c/0x1000 [adv7511]
>  do_one_initcall+0x64/0x30c
>  do_init_module+0x58/0x23c
>  load_module+0x1bcc/0x1d40
>  init_module_from_file+0x88/0xc4
>  idempotent_init_module+0x188/0x27c
>  __arm64_sys_finit_module+0x68/0xac
>  invoke_syscall+0x48/0x110
>  el0_svc_common.constprop.0+0xc0/0xe0
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x4c/0x160
>  el0t_64_sync_handler+0xa0/0xe4
>  el0t_64_sync+0x198/0x19c
>
> Having ISEL configuration back into the struct irq_chip::irq_enable API
> should be safe with respect to spurious IRQs, as in the probe case IRQs
> are enabled anyway in struct gpio_chip::irq::child_to_parent_hwirq. No
> spurious IRQs were detected on suspend/resume, boot, ethernet link
> insert/remove tests (executed on RZ/G3S). Boot, ethernet link
> insert/remove tests were also executed successfully on RZ/G2L.
>
> Fixes: 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in gpio_irq_{en,dis}able*(")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - changed the implementation approach by dropping the spinlock in
>   rzg2l_gpio_irq_endisable(), renaming it to
>   __rzg2l_gpio_irq_endisable() and using it in
>   rzg2l_gpio_irq_endisable(), the newly introduced
>   __rzg2l_gpio_irq_enable() and rzg2l_gpio_irq_restore()
> - convert struct rzg2l_pinctrl::lock to raw_spinlock_t

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.19.

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -543,7 +543,7 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
>         unsigned long flags;
>         u32 reg;
>
> -       spin_lock_irqsave(&pctrl->lock, flags);
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         /* Set pin to 'Non-use (Hi-Z input protection)'  */
>         reg = readw(pctrl->base + PM(off));

This conflicts with commit d57183d06851bae4 ("pinctrl: renesas: rzg2l:
Drop unnecessary pin configurations"), which I have already queued
in renesas-drivers/renesas-pinctrl-for-v6.19.  Hence I am replacing
the above hunk by:

            /* Switching to GPIO is not required if reset value is
same as func */
            reg = readb(pctrl->base + PMC(off));
    -       spin_lock_irqsave(&pctrl->lock, flags);
    +       raw_spin_lock_irqsave(&pctrl->lock, flags);
            pfc = readl(pctrl->base + PFC(off));
            if ((reg & BIT(pin)) && (((pfc >> (pin * 4)) & PFC_MASK) == func)) {
    -               spin_unlock_irqrestore(&pctrl->lock, flags);
    +               raw_spin_unlock_irqrestore(&pctrl->lock, flags);
                    return;
            }

while applying.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

