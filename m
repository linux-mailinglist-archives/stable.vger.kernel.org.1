Return-Path: <stable+bounces-192636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D99C3CAC1
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 18:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FFC563FE5
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E52534A3A2;
	Thu,  6 Nov 2025 16:54:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44C345749
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448092; cv=none; b=uxGhcHxMsFoWWnMfg26WjuU+r/pRrbO+NrlkMK/Z8kr0dJibyUaJNYIUToG3/lqs7PIk659N/8DcHWCm95e8h3PsyLbBGi2pW67VNrYA7BxT8BqLIoU3huwfbLrLw2ZtJ4DOa5ACShu6L/sEIbzOMewWvmUd+SxKLMO1S+MZAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448092; c=relaxed/simple;
	bh=0f45Jhy3vyneeuTWj7fqcWoBCV5Ykzs4Vow1o8J9vUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkQdWpvB+wkA1ArOIOivUFBPAcloL1q5igXX3zStmO++a4dygxX5z1I67+1daV5BA2yUQ2WGKW1zU4yJNQV7QeCegC+Zrtf7XO6Lfp5yUEFIUTDkrSvSKkrRbf+trpJLzEZJHGRiruoFI/HmIK85VZQnc6PeqLmCn81u5WkRRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b70bee93dc4so160316166b.3
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 08:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448087; x=1763052887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHEPbBF5p6FHfbwI0jMq/NClHsHl36pINBGK1avEHfY=;
        b=t2nYz4P8lqPVp0/vLhmRc1+gkj/+KBTo6c5gcvWCxT+scgP3moV2CB1kY3AjfCLUz3
         Zxir0TA5OUWTqGKDneLsHNK2mpoyMFdraUjXuoZkVKK1F69ImfjQEmqFU/TBVGO0kccc
         ObFtLHBMpDQL4vRhCvFy6CEx5Ym6ICaGd2a8ajXBq+u/+17BXRxDxad821DtglKS3uMl
         xP6r/dt8JhobHjwZBUh1AY4P9BTiBmumiTcGF4zVHW/eAzf2v5XYiIG8jTKg/uB3UEjr
         3iCkl8qdopekuRJDqv9AJM3jhCqOdWpLwotI4Z67z7gU5XDktiISMtCS+zcxY5TNUV3W
         wWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9/THL522+v34Thycg/ubSWq4CgMfdgEKJYTOCRNZZhFTrn+BoH1pdZigbxFajUr/SgtqinGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgGpVBSAbHnDJtdUGOpWEUPrHhuHG67YNhuveHbj634rUQllx
	xUKD+ScCc/fnJ+Pxn582P3vw7lkHerb90TFWpggl7PkUKARvPIH01nHZwQ1QF5hUNOg=
X-Gm-Gg: ASbGncuI9T3FiF5NpIc3cSgZlB1MXzxhNYB+tJ4SGmbaU2McNPHJw/dF4UeahBRap5p
	QoqlsuZj4thmcu2PFa4NXlrhjFgvZNj0oYeTwSPMYNhvXY0emmSFR6WSHGoBfarvVQdyQ6yE9RZ
	Ehtg1jZROKJZAUfliQLZ/thrTAZMJnN5BZUjX2FMLan2eJk6/wF8y1BIJfizXJDRB3lnFc6IM4U
	2MOs7nGWyp6Nb/Cn2ZhJlhXtSQkJz7P4tO2UPuFJMDjJi391WINIPgQdqMvkDX72e9GFbawAtbv
	MklDkhCi7lnnnQyNQtES17Ue5aGFztgejsiAZy0LrJKCJiSDd3UxugwrOXrxUP/+RXxit1H0K0s
	AW9CauhmZYw+qBBgf2iUbGwnV2bu4SF4gKMI2XT5WRYimoq1a18tOSfTx7imxWyACNorMM/T4Cl
	mpdv/Jg59fJU5zqB4oB1SzYkGpuMdBE8zig3IsMyC276OvloK2
X-Google-Smtp-Source: AGHT+IGVbLd1pYsZjRL/5rQxIVOTw4b5mlRN+jZf1Z54m1+lmg7wFhPELzzh/cO5OJYeHBBXZyMqyQ==
X-Received: by 2002:a17:906:f59d:b0:b70:50f1:3daa with SMTP id a640c23a62f3a-b726564af26mr839960466b.57.1762448086527;
        Thu, 06 Nov 2025 08:54:46 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf4fd021sm4361966b.25.2025.11.06.08.54.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:54:43 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so1520477a12.2
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 08:54:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvKLa5pwHSl/vVm9bhJ/rrB6NjdyorfIzlagHLx3CK0yeuEsQ9Not93vlP9aNZtzXZzW561Wc=@vger.kernel.org
X-Received: by 2002:a05:6402:460f:20b0:640:a7bc:30c5 with SMTP id
 4fb4d7f45d1cf-6413f070166mr36081a12.28.1762448083616; Thu, 06 Nov 2025
 08:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 17:54:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWRCGYLRK_WBmbB0cRP7PHiGPSi3U1jdWSVKaTSweruUw@mail.gmail.com>
X-Gm-Features: AWmQ_bmQmsHt_92KjlOBxlqZCgcBwWXwdvX6xOc66LuFHB1pYmrIKPozpRSE9Ro
Message-ID: <CAMuHMdWRCGYLRK_WBmbB0cRP7PHiGPSi3U1jdWSVKaTSweruUw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: sh-sci: fix RSCI FIFO overrun handling
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Nam Cao <namcao@linutronix.de>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Tue, 23 Sept 2025 at 17:47, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The receive error handling code is shared between RSCI and all other
> SCIF port types, but the RSCI overrun_reg is specified as a memory
> offset, while for other SCIF types it is an enum value used to index
> into the sci_port_params->regs array, as mentioned above the
> sci_serial_in() function.
>
> For RSCI, the overrun_reg is CSR (0x48), causing the sci_getreg() call
> inside the sci_handle_fifo_overrun() function to index outside the
> bounds of the regs array, which currently has a size of 20, as specified
> by SCI_NR_REGS.
>
> Because of this, we end up accessing memory outside of RSCI's
> rsci_port_params structure, which, when interpreted as a plat_sci_reg,
> happens to have a non-zero size, causing the following WARN when
> sci_serial_in() is called, as the accidental size does not match the
> supported register sizes.
>
> The existence of the overrun_reg needs to be checked because
> SCIx_SH3_SCIF_REGTYPE has overrun_reg set to SCLSR, but SCLSR is not
> present in the regs array.
>
> Avoid calling sci_getreg() for port types which don't use standard
> register handling.
>
> Use the ops->read_reg() and ops->write_reg() functions to properly read
> and write registers for RSCI, and change the type of the status variable
> to accommodate the 32-bit CSR register.
>
> sci_getreg() and sci_serial_in() are also called with overrun_reg in the
> sci_mpxed_interrupt() interrupt handler, but that code path is not used
> for RSCI, as it does not have a muxed interrupt.
>
> ------------[ cut here ]------------
> Invalid register access
> WARNING: CPU: 0 PID: 0 at drivers/tty/serial/sh-sci.c:522 sci_serial_in+0x38/0xac
> Modules linked in: renesas_usbhs at24 rzt2h_adc industrialio_adc sha256 cfg80211 bluetooth ecdh_generic ecc rfkill fuse drm backlight ipv6
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc1+ #30 PREEMPT
> Hardware name: Renesas RZ/T2H EVK Board based on r9a09g077m44 (DT)
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : sci_serial_in+0x38/0xac
> lr : sci_serial_in+0x38/0xac
> sp : ffff800080003e80
> x29: ffff800080003e80 x28: ffff800082195b80 x27: 000000000000000d
> x26: ffff8000821956d0 x25: 0000000000000000 x24: ffff800082195b80
> x23: ffff000180e0d800 x22: 0000000000000010 x21: 0000000000000000
> x20: 0000000000000010 x19: ffff000180e72000 x18: 000000000000000a
> x17: ffff8002bcee7000 x16: ffff800080000000 x15: 0720072007200720
> x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> x11: 0000000000000058 x10: 0000000000000018 x9 : ffff8000821a6a48
> x8 : 0000000000057fa8 x7 : 0000000000000406 x6 : ffff8000821fea48
> x5 : ffff00033ef88408 x4 : ffff8002bcee7000 x3 : ffff800082195b80
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff800082195b80
> Call trace:
>  sci_serial_in+0x38/0xac (P)
>  sci_handle_fifo_overrun.isra.0+0x70/0x134
>  sci_er_interrupt+0x50/0x39c
>  __handle_irq_event_percpu+0x48/0x140
>  handle_irq_event+0x44/0xb0
>  handle_fasteoi_irq+0xf4/0x1a0
>  handle_irq_desc+0x34/0x58
>  generic_handle_domain_irq+0x1c/0x28
>  gic_handle_irq+0x4c/0x140
>  call_on_irq_stack+0x30/0x48
>  do_interrupt_handler+0x80/0x84
>  el1_interrupt+0x34/0x68
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x6c/0x70
>  default_idle_call+0x28/0x58 (P)
>  do_idle+0x1f8/0x250
>  cpu_startup_entry+0x34/0x3c
>  rest_init+0xd8/0xe0
>  console_on_rootfs+0x0/0x6c
>  __primary_switched+0x88/0x90
> ---[ end trace 0000000000000000 ]---
>
> Cc: stable@vger.kernel.org
> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch, which is now commit ef8fef45c74b5a00 ("tty:
serial: sh-sci: fix RSCI FIFO overrun handling") in v6.18-rc3.

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1014,16 +1014,18 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
>         struct sci_port *s = to_sci_port(port);
>         const struct plat_sci_reg *reg;
>         int copied = 0;
> -       u16 status;
> +       u32 status;
>
> -       reg = sci_getreg(port, s->params->overrun_reg);
> -       if (!reg->size)
> -               return 0;
> +       if (s->type != SCI_PORT_RSCI) {
> +               reg = sci_getreg(port, s->params->overrun_reg);
> +               if (!reg->size)
> +                       return 0;
> +       }
>
> -       status = sci_serial_in(port, s->params->overrun_reg);
> +       status = s->ops->read_reg(port, s->params->overrun_reg);
>         if (status & s->params->overrun_mask) {
>                 status &= ~s->params->overrun_mask;
> -               sci_serial_out(port, s->params->overrun_reg, status);
> +               s->ops->write_reg(port, s->params->overrun_reg, status);
>
>                 port->icount.overrun++;
>

Ouch, this is really becoming fragile, and thus hard to maintain.
See also "[PATCH v2 2/2] serial: sh-sci: Fix deadlock during RSCI FIFO
overrun error".
Are you sure this is the only place where that can happen?
sci_getreg() and sci_serial_{in,out}() are used all over the place.

[1] https://lore.kernel.org/20251029082101.92156-3-biju.das.jz@bp.renesas.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

