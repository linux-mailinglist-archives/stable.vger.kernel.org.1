Return-Path: <stable+bounces-192637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECDEC3CAE5
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 18:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE7C3B4F61
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35716284665;
	Thu,  6 Nov 2025 16:56:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EAA226D02
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448181; cv=none; b=BFQJ5EGYDJyMh2JJRcuzIeHfaywTbbisREtwTMQC7kuyC5pYz04ZWidwSyOesbYNqyqWnSRSCgIRyCVvySYSJlCrAaC8SX6ln5WGgGG4ohlrDSAaKpv/EssQkwKnGU5RqGZqlTm98P1NPxu6rK8njMzrd2smVzqUPahcqOZOcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448181; c=relaxed/simple;
	bh=Xj40SOVd3NdTrp2a+VlYBaRTsQy7SgaLV/T8JlG11G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQG9VHHYdQsM5XLT1YwsYa35sJpAbrJwrSFmpiclCdqwyO9JDl/rBGuPz7KeB22gi0JNWp2s3TU1A1VTEO1amv9nNPswwhUIwUoRcMweTWMwOxDGqRKJqFYVhGmo1GuZVLUZcM0DDgV+xKyEq+Pa4zyh5hcZa57vcjk57N4TV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso161264166b.3
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 08:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448174; x=1763052974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kv/zSHNSp67g0DzJLnFh7pwO7THLs7Hn+7HBTbFfIPw=;
        b=O5i4x7StJUxHrIM8UKilnM+KTCrj9csRwExWxdjIb/US+M0eDijgLtMHFKV3/RsGHr
         XdQPljzYecREVL1+bTw73SxjqgqSnELsyiNg1PPunOP7q5B3am0F6fuq82ASC4yTpWQ8
         38oMzaXBLAFQbS2RASeIfpxTf4y6GX3BDDK/VFVeIkqisOHovdfVs8wkSGmqrBWVw2ch
         9sirMsuRQtCfFWwGH1ttvQXYZyHUoB+FFXBOjNODzKwqNnATN0jKtF25HHKgenU125mj
         j8FqAOV3uFvA6bmkdHj/aYqGvUHXCPAs/azxXSr0x2M52OvNreAHiXruuIClL4vhH3p7
         CROw==
X-Forwarded-Encrypted: i=1; AJvYcCVTdb5y6v/1a8rNeCZTlbqDD+Lh16SXTCD4Q1MrbE92KCSIizD9zB19MlV7nCQVNFGLfjNMdwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzshFNmuG+NPOntnaXAZtr93tpW7jJQQ5GdIjCOTAupRoT0IWw2
	oYsn/4seIotEi1GxPbh7SkdMCSylU4yQAA4bEWBw/4/MCDY04eyP5bPRLnpeqCBHIOQ=
X-Gm-Gg: ASbGncvE4/Sq2LlpZlkdNmRzJjxP3Of3f6PuS0dGRM1+cPqyzW0z8SohUneYznnG20H
	3wo8TJBYu4dowzJWANRW62YQyBE0bFwWgVl6sojxnDl5o435r5cPNBpprXWKk/ogTjjMfR9D639
	Re8BI5VbgBIZxjfBdsEqFW6vDqXBi3UxOXFzpiZsERzwBSVoNR4Z75OXcZOLhpfeZmwcTzEzqFo
	x5Ln60XnUZONYZx41znmUIMcZLd4rQHclzSmwPmkfPQr5UQ3JGVWkfcOLhowXJiuo2Yp+8Asr0m
	cWVyA3xwK4ap4X3yI/ltAFt4+FoS4FDpK7bn8uo7rt/96VL58MWJkgJiYm/YVPOKamjPIwTsQvA
	pTvPAd25b8SEL1nsMS8AtPKZ4uejLOwpQ83RgpgiGfWPSV2oP5ZyRGJ57EzNudRWqekjbpQHZAZ
	a2nw5gJlWb/mVPwVSrXOuIb9Pmzjrtk0mRYT7Q5Q==
X-Google-Smtp-Source: AGHT+IGBe8Ppgut74060b1GeFTE5ZhaoKkUjfn9lOyK6Da/w2KaqARKd5IbIbDY9fQPzpVSzR4Z49g==
X-Received: by 2002:a17:906:7949:b0:b70:b3e8:a353 with SMTP id a640c23a62f3a-b726557fcafmr790436866b.50.1762448174013;
        Thu, 06 Nov 2025 08:56:14 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbce8f9sm5005566b.2.2025.11.06.08.56.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:56:09 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640e9a53ff6so2243012a12.0
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 08:56:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVG/VhgvqRryt2MceVjjOOuqx1j+KhsNHgavoG3/0PZmIv1gbdBZMWwyAlOvrMW7mg5Yq7uABg=@vger.kernel.org
X-Received: by 2002:a05:6402:524f:b0:641:3d64:b10d with SMTP id
 4fb4d7f45d1cf-6413f2399ebmr7718a12.36.1762448168196; Thu, 06 Nov 2025
 08:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com> <CAMuHMdWRCGYLRK_WBmbB0cRP7PHiGPSi3U1jdWSVKaTSweruUw@mail.gmail.com>
In-Reply-To: <CAMuHMdWRCGYLRK_WBmbB0cRP7PHiGPSi3U1jdWSVKaTSweruUw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 17:55:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUn5cd++TeWQvwLhFYQ7_iwwrRT0pdiENVRvOTGbDmGOw@mail.gmail.com>
X-Gm-Features: AWmQ_bni4h7F77aBUeRJILkTfeTNGn3rlXJkkeh9_4oFRfgsraYOOXpjZIOku4I
Message-ID: <CAMuHMdUn5cd++TeWQvwLhFYQ7_iwwrRT0pdiENVRvOTGbDmGOw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: sh-sci: fix RSCI FIFO overrun handling
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Nam Cao <namcao@linutronix.de>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-reneas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

CC Biju, linux-renesas-soc

On Thu, 6 Nov 2025 at 17:54, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Cosmin,
>
> On Tue, 23 Sept 2025 at 17:47, Cosmin Tanislav
> <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > The receive error handling code is shared between RSCI and all other
> > SCIF port types, but the RSCI overrun_reg is specified as a memory
> > offset, while for other SCIF types it is an enum value used to index
> > into the sci_port_params->regs array, as mentioned above the
> > sci_serial_in() function.
> >
> > For RSCI, the overrun_reg is CSR (0x48), causing the sci_getreg() call
> > inside the sci_handle_fifo_overrun() function to index outside the
> > bounds of the regs array, which currently has a size of 20, as specified
> > by SCI_NR_REGS.
> >
> > Because of this, we end up accessing memory outside of RSCI's
> > rsci_port_params structure, which, when interpreted as a plat_sci_reg,
> > happens to have a non-zero size, causing the following WARN when
> > sci_serial_in() is called, as the accidental size does not match the
> > supported register sizes.
> >
> > The existence of the overrun_reg needs to be checked because
> > SCIx_SH3_SCIF_REGTYPE has overrun_reg set to SCLSR, but SCLSR is not
> > present in the regs array.
> >
> > Avoid calling sci_getreg() for port types which don't use standard
> > register handling.
> >
> > Use the ops->read_reg() and ops->write_reg() functions to properly read
> > and write registers for RSCI, and change the type of the status variable
> > to accommodate the 32-bit CSR register.
> >
> > sci_getreg() and sci_serial_in() are also called with overrun_reg in the
> > sci_mpxed_interrupt() interrupt handler, but that code path is not used
> > for RSCI, as it does not have a muxed interrupt.
> >
> > ------------[ cut here ]------------
> > Invalid register access
> > WARNING: CPU: 0 PID: 0 at drivers/tty/serial/sh-sci.c:522 sci_serial_in+0x38/0xac
> > Modules linked in: renesas_usbhs at24 rzt2h_adc industrialio_adc sha256 cfg80211 bluetooth ecdh_generic ecc rfkill fuse drm backlight ipv6
> > CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc1+ #30 PREEMPT
> > Hardware name: Renesas RZ/T2H EVK Board based on r9a09g077m44 (DT)
> > pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : sci_serial_in+0x38/0xac
> > lr : sci_serial_in+0x38/0xac
> > sp : ffff800080003e80
> > x29: ffff800080003e80 x28: ffff800082195b80 x27: 000000000000000d
> > x26: ffff8000821956d0 x25: 0000000000000000 x24: ffff800082195b80
> > x23: ffff000180e0d800 x22: 0000000000000010 x21: 0000000000000000
> > x20: 0000000000000010 x19: ffff000180e72000 x18: 000000000000000a
> > x17: ffff8002bcee7000 x16: ffff800080000000 x15: 0720072007200720
> > x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> > x11: 0000000000000058 x10: 0000000000000018 x9 : ffff8000821a6a48
> > x8 : 0000000000057fa8 x7 : 0000000000000406 x6 : ffff8000821fea48
> > x5 : ffff00033ef88408 x4 : ffff8002bcee7000 x3 : ffff800082195b80
> > x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff800082195b80
> > Call trace:
> >  sci_serial_in+0x38/0xac (P)
> >  sci_handle_fifo_overrun.isra.0+0x70/0x134
> >  sci_er_interrupt+0x50/0x39c
> >  __handle_irq_event_percpu+0x48/0x140
> >  handle_irq_event+0x44/0xb0
> >  handle_fasteoi_irq+0xf4/0x1a0
> >  handle_irq_desc+0x34/0x58
> >  generic_handle_domain_irq+0x1c/0x28
> >  gic_handle_irq+0x4c/0x140
> >  call_on_irq_stack+0x30/0x48
> >  do_interrupt_handler+0x80/0x84
> >  el1_interrupt+0x34/0x68
> >  el1h_64_irq_handler+0x18/0x24
> >  el1h_64_irq+0x6c/0x70
> >  default_idle_call+0x28/0x58 (P)
> >  do_idle+0x1f8/0x250
> >  cpu_startup_entry+0x34/0x3c
> >  rest_init+0xd8/0xe0
> >  console_on_rootfs+0x0/0x6c
> >  __primary_switched+0x88/0x90
> > ---[ end trace 0000000000000000 ]---
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
>
> Thanks for your patch, which is now commit ef8fef45c74b5a00 ("tty:
> serial: sh-sci: fix RSCI FIFO overrun handling") in v6.18-rc3.
>
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -1014,16 +1014,18 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
> >         struct sci_port *s = to_sci_port(port);
> >         const struct plat_sci_reg *reg;
> >         int copied = 0;
> > -       u16 status;
> > +       u32 status;
> >
> > -       reg = sci_getreg(port, s->params->overrun_reg);
> > -       if (!reg->size)
> > -               return 0;
> > +       if (s->type != SCI_PORT_RSCI) {
> > +               reg = sci_getreg(port, s->params->overrun_reg);
> > +               if (!reg->size)
> > +                       return 0;
> > +       }
> >
> > -       status = sci_serial_in(port, s->params->overrun_reg);
> > +       status = s->ops->read_reg(port, s->params->overrun_reg);
> >         if (status & s->params->overrun_mask) {
> >                 status &= ~s->params->overrun_mask;
> > -               sci_serial_out(port, s->params->overrun_reg, status);
> > +               s->ops->write_reg(port, s->params->overrun_reg, status);
> >
> >                 port->icount.overrun++;
> >
>
> Ouch, this is really becoming fragile, and thus hard to maintain.
> See also "[PATCH v2 2/2] serial: sh-sci: Fix deadlock during RSCI FIFO
> overrun error".
> Are you sure this is the only place where that can happen?
> sci_getreg() and sci_serial_{in,out}() are used all over the place.
>
> [1] https://lore.kernel.org/20251029082101.92156-3-biju.das.jz@bp.renesas.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

