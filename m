Return-Path: <stable+bounces-132837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D4A8B6E2
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 12:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED77444EEA
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F2F2327A1;
	Wed, 16 Apr 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHsTS0wk"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C81BC9E2
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800010; cv=none; b=C7z6SCIauJel/WQoHgoEAWDhzMaCoR3utTtR3WQrIH5C75LgnUrBmHiI8wq2I/JeVntz0bgZLv4jKKHSVnWptjSMGOAn1sa+mO4yMdXM0fRaOrUhgUcjBJjQjHZ8vbscDhqSij8yup7RzyzzOsstpi0NNpe4LtVR9CRurehpPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800010; c=relaxed/simple;
	bh=O43vBZXURJqZi5/YVIFLW0+npdbUxEBlQ/F7/trHqLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+ZJ6FtwMABmpnsfhSuaUjj0oUvXexV5KsZBWDXDa3zjBez/jjSd7iM05+DT6ZXOQhYRW+XEyX7YkcbD1ytOUpvoqYx2xwf5QaEAoUFYxgvL+GXIN1JPtQBdMkiB//xH2dIFubmzNV+zaCBBTbpZlyu98mrcJwAhvJdq1e//AdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHsTS0wk; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54d486d3535so5426e87.1
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744800006; x=1745404806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5ZXVb5dTrb9owxQOaSc6zse/02f6gsl8oULQh4e96c=;
        b=EHsTS0wkOzCfHSuRVYtTHP6PMnYmh1qqtQ+o+FbKOp4FdtxD0KhGZJv8J8i3Tq0XYL
         RI1g+91v35Jyv2vvhFK1TTcWGc0iX1a5Zs0T7vS+ubkd8Y0nejh84fc5SwBBCuAuXM0f
         j8GrQk+GMwG6mO2oJgfVDAG3kaxtdCZ/R3nMiwz0bt4aQ/Rpi7NHo7gb5S7p80yOVaqN
         64XXo+ZNS4QRj/+wNuZgwvuDCJlIJfkWGg1wPmaDkynRbXh9mGi+8HHWenQjJ7qUpkLw
         oYQuvGaU9nqQ55uXMxjjKL33hXNJzCo7fakVG74sGcK1XC5WZv7DG3tVaK6lzcZXWQ+F
         BfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744800006; x=1745404806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5ZXVb5dTrb9owxQOaSc6zse/02f6gsl8oULQh4e96c=;
        b=McoYh9IGGXrEnIfWq1ecx/epx7DzIl9C+w41wGm5aLy0O6pQJ2y6j+65QwVaTeUsi8
         Q8D3/bhddbMu1RqGXqLXaBvsGhTnZ7pAxnhP/5rmlVvKIWbbv+f67F1l5aIkMHxekseT
         ChqbWtUzfhBHqftAlFMvdifsUhElSDj88+zjGQvG86Y1DTF3fVOaS0MBVLlxRkVvBvRF
         dQ3GQnQCii26qKqrO7nxO+xWTBh0WZDhTDRklwfJXw5ksTm+1ftC59Bs6vvqyTZcBOmW
         BEn3JLtbrlWlSNiaIxduwJYW20WvFI2AG8/MmRBDw5wq7z/dqTHMjtasG6V5tQoLRToa
         kJpA==
X-Forwarded-Encrypted: i=1; AJvYcCUV1nnc87mqAXijq3ejTm2iVpVblMZ+u493Ia/dCkxX9uUHOw8pcXmLBPj5tfclv9ibNrNkE+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6upqd93327i6b3CbORoN9eK57Mp912oD2vTrIUn4P1e0jbGD
	1xGkiD1FeKVtQumwsXc7FN4oSBFxBDgE/Ml/20NwZ4Gtus71+HGAUJPVBnbZeQkY0NF0DaxS+AX
	0LosVJz2CQ2UVV3BVwV36DPGzVy9RVdOwde1r
X-Gm-Gg: ASbGncsHTfXNrjUNzRxgRxyD6u9+djG3fQxaY6Zf1RfskyNAqweTCKfdeNzkFuCq1Kv
	nFQKiqKC8DE/J7rF/Yec1p/96kCSjH5TP/JeT3e1pjTGAxMqWnihy6rfc3N/5+EQ714mT6iVcTe
	1KSM/7AbiK2Z3POGJtXjJeeYRIuQtwnLy5bMh8BRkkOkwOYbhE
X-Google-Smtp-Source: AGHT+IG0RRQcjL0vTELyRBOF75YqbYQVhuLkLnGrg0E8ngHimeLXE2D4ctxxmq3vsKAQL1uhbg5wwG9sZ5PWlbwkso8=
X-Received: by 2002:a05:6512:328d:b0:543:cf0c:ed14 with SMTP id
 2adb3069b0e04-54d6437ea2cmr72985e87.5.1744800005838; Wed, 16 Apr 2025
 03:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327133233.2566528-1-khtsai@google.com>
In-Reply-To: <20250327133233.2566528-1-khtsai@google.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Wed, 16 Apr 2025 18:39:39 +0800
X-Gm-Features: ATxdqUEz3Vxoy2SWWp3ckll3jRAQgcoBue0UND1ir68nE66lyLygn_C_oCNJUro
Message-ID: <CAKzKK0oqdxvnfGg6GR_N3M59fdPqR+uTW=YC6SPGOB7+aojV_A@mail.gmail.com>
Subject: Re: [PATCH v3] usb: dwc3: Abort suspend on soft disconnect failure
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 9:32=E2=80=AFPM Kuen-Han Tsai <khtsai@google.com> w=
rote:
>
> When dwc3_gadget_soft_disconnect() fails, dwc3_suspend_common() keeps
> going with the suspend, resulting in a period where the power domain is
> off, but the gadget driver remains connected.  Within this time frame,
> invoking vbus_event_work() will cause an error as it attempts to access
> DWC3 registers for endpoint disabling after the power domain has been
> completely shut down.
>
> Abort the suspend sequence when dwc3_gadget_suspend() cannot halt the
> controller and proceeds with a soft connect.
>
> Fixes: 9f8a67b65a49 ("usb: dwc3: gadget: fix gadget suspend/resume")
> CC: stable@vger.kernel.org
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---
>
> Kernel panic - not syncing: Asynchronous SError Interrupt
> Workqueue: events vbus_event_work
> Call trace:
>  dump_backtrace+0xf4/0x118
>  show_stack+0x18/0x24
>  dump_stack_lvl+0x60/0x7c
>  dump_stack+0x18/0x3c
>  panic+0x16c/0x390
>  nmi_panic+0xa4/0xa8
>  arm64_serror_panic+0x6c/0x94
>  do_serror+0xc4/0xd0
>  el1h_64_error_handler+0x34/0x48
>  el1h_64_error+0x68/0x6c
>  readl+0x4c/0x8c
>  __dwc3_gadget_ep_disable+0x48/0x230
>  dwc3_gadget_ep_disable+0x50/0xc0
>  usb_ep_disable+0x44/0xe4
>  ffs_func_eps_disable+0x64/0xc8
>  ffs_func_set_alt+0x74/0x368
>  ffs_func_disable+0x18/0x28
>  composite_disconnect+0x90/0xec
>  configfs_composite_disconnect+0x64/0x88
>  usb_gadget_disconnect_locked+0xc0/0x168
>  vbus_event_work+0x3c/0x58
>  process_one_work+0x1e4/0x43c
>  worker_thread+0x25c/0x430
>  kthread+0x104/0x1d4
>  ret_from_fork+0x10/0x20
>
> ---
> Changelog:
>
> v3:
> - change the Fixes tag
>
> v2:
> - move declarations in separate lines
> - add the Fixes tag
>
> ---
>  drivers/usb/dwc3/core.c   |  9 +++++++--
>  drivers/usb/dwc3/gadget.c | 22 +++++++++-------------
>  2 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 66a08b527165..1cf1996ae1fb 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2388,6 +2388,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm=
_message_t msg)
>  {
>         u32 reg;
>         int i;
> +       int ret;
>
>         if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
>                 dwc->susphy_state =3D (dwc3_readl(dwc->regs, DWC3_GUSB2PH=
YCFG(0)) &
> @@ -2406,7 +2407,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm=
_message_t msg)
>         case DWC3_GCTL_PRTCAP_DEVICE:
>                 if (pm_runtime_suspended(dwc->dev))
>                         break;
> -               dwc3_gadget_suspend(dwc);
> +               ret =3D dwc3_gadget_suspend(dwc);
> +               if (ret)
> +                       return ret

Sorry about forgetting the semicolon.

>                 synchronize_irq(dwc->irq_gadget);
>                 dwc3_core_exit(dwc);
>                 break;
> @@ -2441,7 +2444,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm=
_message_t msg)
>                         break;
>
>                 if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_DEVICE) {
> -                       dwc3_gadget_suspend(dwc);
> +                       ret =3D dwc3_gadget_suspend(dwc);
> +                       if (ret)
> +                               return ret;
>                         synchronize_irq(dwc->irq_gadget);
>                 }
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 89a4dc8ebf94..316c1589618e 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4776,26 +4776,22 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
>         int ret;
>
>         ret =3D dwc3_gadget_soft_disconnect(dwc);
> -       if (ret)
> -               goto err;
> -
> -       spin_lock_irqsave(&dwc->lock, flags);
> -       if (dwc->gadget_driver)
> -               dwc3_disconnect_gadget(dwc);
> -       spin_unlock_irqrestore(&dwc->lock, flags);
> -
> -       return 0;
> -
> -err:
>         /*
>          * Attempt to reset the controller's state. Likely no
>          * communication can be established until the host
>          * performs a port reset.
>          */
> -       if (dwc->softconnect)
> +       if (ret && dwc->softconnect) {
>                 dwc3_gadget_soft_connect(dwc);
> +               return ret;

This should return -EAGAIN after a soft connect to keep dwc3 active,
allowing dwc3_gadget_pullup() to perform the subsequent pull-down
normally.

> +       }
>
> -       return ret;
> +       spin_lock_irqsave(&dwc->lock, flags);
> +       if (dwc->gadget_driver)
> +               dwc3_disconnect_gadget(dwc);
> +       spin_unlock_irqrestore(&dwc->lock, flags);
> +
> +       return 0;
>  }
>
>  int dwc3_gadget_resume(struct dwc3 *dwc)
> --
> 2.49.0.472.ge94155a9ec-goog
>

Hi Thinh and Greg,

Sorry again for the lack of thorough testing on my patches. I've
corrected silly mistakes and sent out v4.

https://lore.kernel.org/linux-usb/20250416100515.2131853-1-khtsai@google.co=
m/

Thanks,
Kuen-Han

