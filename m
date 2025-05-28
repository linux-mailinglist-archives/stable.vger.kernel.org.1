Return-Path: <stable+bounces-147914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A358AC6322
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 09:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11122189BB7C
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 07:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B9A2459D9;
	Wed, 28 May 2025 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLEgx4p5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8C212FBE
	for <stable@vger.kernel.org>; Wed, 28 May 2025 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417747; cv=none; b=neC6mhUTQsDdYeBBKvyvw62j0O9xaggNFk02xMnXMoUZOE68nNe6JNdNw+n62O85B37OBVWXYHuB5ymmAIJFCkWmUBqS/GkayHVkE7+OqGllvPWlm+iv11dkLMWpMMQoWIMkdvaJDwsLcdob6e0hDxBdPbQuC6SeK9xe9G/TCV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417747; c=relaxed/simple;
	bh=ojn98cYobv8qkM4itGJX5hRlTmzBGUDcqXxDm4IrqQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JK8kZP013PfzWPryKC3byOdJsuyspp4tfFFplaOvKaNEBMSJOX8ZAiFpS0cJ22dm7araldrslwMHRH/q3/SvdWSxHmS0nCVEdGfPPvmOYDdJi2yTddGDYvN7VXNo7WgqbXTCUQ++B0Tw51YIOyv8aHLpGepLfE0yP/gVkUi6UwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLEgx4p5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55320f715bdso5726e87.0
        for <stable@vger.kernel.org>; Wed, 28 May 2025 00:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748417742; x=1749022542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOJ/Erz3NJEWEC/FBnmroRUFyLvJzHrkOgqhXobzPPA=;
        b=pLEgx4p519hz6HzqbX7CBpIldy9HZWvzxSgxLjotp3NtiqGeIwYdNHQgi87QGY10ag
         OkdGDkjZ0e6BS1BjfWfg7mmpS/yxqKd6IGkxSVPr/kCKrMcTBzhaWPUNabrYLmfffW6R
         Ndw1ncOJAor0Z4WyonS6RhTldVkVDzqXCTRIipXerhZM5qj+VcK8Bk3ppdWqKQ/A/dqg
         FWrOcisZI3QeSBsrq76QhxhE6l1ngtNHZH0KzfnTsVjqfIyD9IjY90nwFVTc0jsSDPrH
         HlfYbumqSZk0bStQ5Nh868RbLk167acGjjcPdkuVOiBft7n2xt0WAuZ99/4QFWyQ8Itr
         AhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417742; x=1749022542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOJ/Erz3NJEWEC/FBnmroRUFyLvJzHrkOgqhXobzPPA=;
        b=p6BELkDjV+hQTdzgVQ3by2Ds5cHdRzbjdI6qH+dVYdaHOtbrYP3SQC3Y9clKr2f5vY
         F+ogDkzg1HCkkA/k8J+VItl5g6i3TmtB6GU4bhhVirv0G9Iye5cnAKa5u1cp1z4KoZsX
         M6k40TTJcvvnmpwFai1S3Nt5r6lSnA6cWvgrr3WxP+nVOPXEsscmSmxdGNu5TtSc/7In
         ZoGk8ZrWaaGmRpmyQBAwbBDcOMV1vWoWWllHNtg5PruQcKnrohvs8mPkqUreRn/4I+PI
         RaJH0Xckl5QpA133n8hr1Ttw9tYMBmwD/W17gnVOlkCAFSIlYi+NRrastWsfZa3GmbFx
         oeXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXawPNtnc7iyC1KYO6Y4IZWOqaKVEl17GI7hYcuI1d6CWMhti40FgiasX2X4W5yygFVyZYTWb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBM99ZliUgK5BrM0n0p2YHjlQUipbEL+tuSGQ6egz7kycgbpr3
	Veq4XQ3y0LYRdFfmHCOVlYWJbqCo6rehVbhMN2q2mwrg4kJH2YiOQEsiYBVdwP8NUScn0k2UO+5
	FH8gWay4d/rhIYvB7RdEkX+oAemvJRKDLx5lBxiNy
X-Gm-Gg: ASbGncsKr+wflLVS3n4uOm97UpO/uAU9PwDrZogPv4WWihrLfPdQ9EvF16/MKJriYaW
	/AT/U/EFxCgXYQoPyrK7sHaxY2X2SNOCEgxPd6xx+d96wPBhRxjDjb7CCns/Lc0lseTV+vcW9zS
	Wf+kDphROdtNHwxetHwcNHo0w/NLqsxoJify2Rzz4f8/qtKA4DsBGWQI2oLZcGi65dd6OrEi8=
X-Google-Smtp-Source: AGHT+IG+Mn1V+0c8QsQxG5c4rJueBt0y7/DVe9ZoPgIASiHSjGTjAuBSn8DXHY3zE+rzvci8KtUFh03pCmzzb6qQqs0=
X-Received: by 2002:a19:c212:0:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-5532ef82470mr123218e87.3.1748417742176; Wed, 28 May 2025
 00:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416100515.2131853-1-khtsai@google.com> <20250419012408.x3zxum5db7iconil@synopsys.com>
In-Reply-To: <20250419012408.x3zxum5db7iconil@synopsys.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Wed, 28 May 2025 15:35:15 +0800
X-Gm-Features: AX0GCFtkf15X4Sr4-XlDSBRSZecuoEyX3tXHqe5snVtx6egSAV0hGdIdZpP3X8Y
Message-ID: <CAKzKK0qi9Kze76G8NGGoE=-VTrtf47BbTWCA9XWbKK1N=rh9Ew@mail.gmail.com>
Subject: Re: [PATCH v4] usb: dwc3: Abort suspend on soft disconnect failure
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 9:24=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> On Wed, Apr 16, 2025, Kuen-Han Tsai wrote:
> > When dwc3_gadget_soft_disconnect() fails, dwc3_suspend_common() keeps
> > going with the suspend, resulting in a period where the power domain is
> > off, but the gadget driver remains connected.  Within this time frame,
> > invoking vbus_event_work() will cause an error as it attempts to access
> > DWC3 registers for endpoint disabling after the power domain has been
> > completely shut down.
> >
> > Abort the suspend sequence when dwc3_gadget_suspend() cannot halt the
> > controller and proceeds with a soft connect.
> >
> > Fixes: 9f8a67b65a49 ("usb: dwc3: gadget: fix gadget suspend/resume")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> > ---
> >
> > Kernel panic - not syncing: Asynchronous SError Interrupt
> > Workqueue: events vbus_event_work
> > Call trace:
> >  dump_backtrace+0xf4/0x118
> >  show_stack+0x18/0x24
> >  dump_stack_lvl+0x60/0x7c
> >  dump_stack+0x18/0x3c
> >  panic+0x16c/0x390
> >  nmi_panic+0xa4/0xa8
> >  arm64_serror_panic+0x6c/0x94
> >  do_serror+0xc4/0xd0
> >  el1h_64_error_handler+0x34/0x48
> >  el1h_64_error+0x68/0x6c
> >  readl+0x4c/0x8c
> >  __dwc3_gadget_ep_disable+0x48/0x230
> >  dwc3_gadget_ep_disable+0x50/0xc0
> >  usb_ep_disable+0x44/0xe4
> >  ffs_func_eps_disable+0x64/0xc8
> >  ffs_func_set_alt+0x74/0x368
> >  ffs_func_disable+0x18/0x28
> >  composite_disconnect+0x90/0xec
> >  configfs_composite_disconnect+0x64/0x88
> >  usb_gadget_disconnect_locked+0xc0/0x168
> >  vbus_event_work+0x3c/0x58
> >  process_one_work+0x1e4/0x43c
> >  worker_thread+0x25c/0x430
> >  kthread+0x104/0x1d4
> >  ret_from_fork+0x10/0x20
> >
> > ---
> > Changelog:
> >
> > v4:
> > - correct the mistake where semicolon was forgotten
> > - return -EAGAIN upon dwc3_gadget_suspend() failure
> >
> > v3:
> > - change the Fixes tag
> >
> > v2:
> > - move declarations in separate lines
> > - add the Fixes tag
> >
> > ---
> >  drivers/usb/dwc3/core.c   |  9 +++++++--
> >  drivers/usb/dwc3/gadget.c | 22 +++++++++-------------
> >  2 files changed, 16 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 66a08b527165..f36bc933c55b 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -2388,6 +2388,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, =
pm_message_t msg)
> >  {
> >       u32 reg;
> >       int i;
> > +     int ret;
> >
> >       if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
> >               dwc->susphy_state =3D (dwc3_readl(dwc->regs, DWC3_GUSB2PH=
YCFG(0)) &
> > @@ -2406,7 +2407,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, =
pm_message_t msg)
> >       case DWC3_GCTL_PRTCAP_DEVICE:
> >               if (pm_runtime_suspended(dwc->dev))
> >                       break;
> > -             dwc3_gadget_suspend(dwc);
> > +             ret =3D dwc3_gadget_suspend(dwc);
> > +             if (ret)
> > +                     return ret;
> >               synchronize_irq(dwc->irq_gadget);
> >               dwc3_core_exit(dwc);
> >               break;
> > @@ -2441,7 +2444,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, =
pm_message_t msg)
> >                       break;
> >
> >               if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_DEVICE) {
> > -                     dwc3_gadget_suspend(dwc);
> > +                     ret =3D dwc3_gadget_suspend(dwc);
> > +                     if (ret)
> > +                             return ret;
> >                       synchronize_irq(dwc->irq_gadget);
> >               }
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 89a4dc8ebf94..630fd5f0ce97 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -4776,26 +4776,22 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
> >       int ret;
> >
> >       ret =3D dwc3_gadget_soft_disconnect(dwc);
> > -     if (ret)
> > -             goto err;
> > -
> > -     spin_lock_irqsave(&dwc->lock, flags);
> > -     if (dwc->gadget_driver)
> > -             dwc3_disconnect_gadget(dwc);
> > -     spin_unlock_irqrestore(&dwc->lock, flags);
> > -
> > -     return 0;
> > -
> > -err:
> >       /*
> >        * Attempt to reset the controller's state. Likely no
> >        * communication can be established until the host
> >        * performs a port reset.
> >        */
> > -     if (dwc->softconnect)
> > +     if (ret && dwc->softconnect) {
> >               dwc3_gadget_soft_connect(dwc);
> > +             return -EAGAIN;
>
> This may make sense to have -EAGAIN for runtime suspend. I supposed this
> should be fine for system suspend since it doesn't do anything special
> for this error code.
>
> When you tested runtime suspend, did you observe that the device
> successfully going into suspend on retry?
>
> In any case, I think this should be good. Thanks for the fix:
>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>
> Thanks,
> Thinh

Hi Greg,

It looks like this patch hasn't been cherry-picked into the usb-next
branch yet. Am I missing something?

Regards,
Kuen-Han

>
> > +     }
> >
> > -     return ret;
> > +     spin_lock_irqsave(&dwc->lock, flags);
> > +     if (dwc->gadget_driver)
> > +             dwc3_disconnect_gadget(dwc);
> > +     spin_unlock_irqrestore(&dwc->lock, flags);
> > +
> > +     return 0;
> >  }
> >
> >  int dwc3_gadget_resume(struct dwc3 *dwc)
> > --
> > 2.49.0.604.gff1f9ca942-goog
> >

