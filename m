Return-Path: <stable+bounces-135146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96398A971A3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751F8440EB9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C272900BB;
	Tue, 22 Apr 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WC2yptBz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE1290082
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337066; cv=none; b=F7KXpMi8PGyuQsIR5wCIqw8y4Qipk7QBgf1rsT37ugVjqBIwfkBhUBXOIWn4lvfFm+dgMJouAn4vKk7sIwbTLVY62bN8grNdtGiMlbJXSrjOPS8dBoSP+K9PS1V1vUUbOW4xZZySVJqNb6KOgBY32vJv9odlXhwl2QRT8W+gV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337066; c=relaxed/simple;
	bh=3sqNGatK3nNf3ioHPn/vTJ1ihZQnxYjPJUzKw2ujuNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMgVs7DjzbJHqShV2jhy1apAsBESUpITMnyfsahuLObtPrJdEOkvxxGKE2kFhGY0LPdz7jTk9QnFrYOalETI/OXbis1x9XbqTBu5+03dhsdaBPcN9HnP+wwcmpGoQF13FaoahTd34AiI9jJr3eoeyut7IPO/Ne2nDaV+qcTHKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WC2yptBz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54d486d3535so6774e87.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745337062; x=1745941862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdFGD2OG7sa0PhB8zVDzwTwQ3rmo3v4yX/7hU6EpgHE=;
        b=WC2yptBzUE4Cu5A/1Zf0rY4marKoohubisGqMU8HDaA2CjNIt4qc3VnKoqK32RBc8D
         YvwEXXqgZhR6L2rVT0epwwDea4opUN/G4hNHUNKRh8/OTxgDPCzPvOSISShOfzroiq4O
         3lNWa5dAXrIEVv6U2MiO3WRR0Ob/snHAXS6WSY6TGi23SM6Dwm3z0D/Mzfl0gGXrzmQj
         MKML2Xx1Jjg2ucMkUEF6hcyY7B6frA1bHLSpMM2vX2Gz7INJAb9tSk+8UKfeFFusiTtq
         sDofLki336i6ILQWAkTT6OpgDGG17ZlnrOzdEf6Gc3wjvSZi1G9f2eTZGAnB5InApZXb
         i7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337062; x=1745941862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdFGD2OG7sa0PhB8zVDzwTwQ3rmo3v4yX/7hU6EpgHE=;
        b=uQfw5ddXqijg5h3VipFLz0Qb65yM29ATrP34jotGuW3D8gNuY6bddNIsXFifKdTdpv
         5kqSnWNvp/9Wr130jOmoY8w5t1Sb2LtFjlT2nT8R/5BCOMfbxwANIM2W9Owd9E+1LVnn
         f1q+20bnLMKmjit7iQQx+yZgQG+VdiM0u8IGMy7kiX1ls4APpAWUMehjsiVK7ygXIDRa
         wNmBK8f6DClwUA135uPIh0zMeLwZcXFtVgfhYuCp6I7kchamCYph92ZJCTT4W6N9164U
         PmgCFtWNjQET9I1/T8ci2H6CJuq1ganR80AS0mm3Rc2nhCtFXtI2a2d01/yi8XorHyPR
         m8RA==
X-Forwarded-Encrypted: i=1; AJvYcCUq2VZMWrmmd6bJGKibFgjZVuF9eOamw/nqpYvwBRaH2yPj8EKEDRi2FVsfePakUKaBEW7KcQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hw63Fg3aUavONasA6+gYhgYq5Fu9eZWNwB8oUc7moKECKZlO
	OrHuaBLqFa96QMy1WpCxAcjHekSRG6Q5dSHnAMb+0nUoUvluyVkPkN3k3UwKMcwZZ55XnkjBNhd
	tBD89YdJM4J5uHZbRycPCBrUYlGF1PQeUSu+i
X-Gm-Gg: ASbGncsGVwcv8LwZf3pDzUgDrtdFCUIo+wWx9cxiZLYMcFFl41JqD0EcN10m9gC6Ees
	Yjfih4kbE4cjPAdJVnJ/PhHeTA6jYVoXmKmpXLS/mM2M5Oq7ibFYcNv6XhNzYmPlRm54ZWdlsGT
	JD5IF0CkEK/X2meX6AnDOeUcuusX5ZA0AHPyMpVtwOolLRHRVfqctMHhlD
X-Google-Smtp-Source: AGHT+IHQqUWx2u3/cq0FvzsslIUm5Dy/4pb7LqJE77ayHMAIePU0Cj0gbTYfXvpwXwPkr+tZIRDQNcab7m9Im8ZO0D8=
X-Received: by 2002:ac2:5181:0:b0:545:1cbb:74e5 with SMTP id
 2adb3069b0e04-54d6e956f35mr697284e87.3.1745337061944; Tue, 22 Apr 2025
 08:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416100515.2131853-1-khtsai@google.com> <20250419012408.x3zxum5db7iconil@synopsys.com>
 <CAKzKK0qCag3STZUqaX5Povu0Mzh5Ntfew5RW64dTtHVcVPELYQ@mail.gmail.com> <20250421232007.u2tmih4djakhttxq@synopsys.com>
In-Reply-To: <20250421232007.u2tmih4djakhttxq@synopsys.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Tue, 22 Apr 2025 23:50:35 +0800
X-Gm-Features: ATxdqUHW9FF8cqE3jm_WZD_OgsvjOfh6Q1uw_o-6F0YcJvOWm3NGOVNgd0xjp7M
Message-ID: <CAKzKK0pReSZeJ1-iRUbU=w+dK0O1fB7AgecfC7KJap6m5cQWnQ@mail.gmail.com>
Subject: Re: [PATCH v4] usb: dwc3: Abort suspend on soft disconnect failure
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 7:20=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> On Mon, Apr 21, 2025, Kuen-Han Tsai wrote:
> > On Sat, Apr 19, 2025 at 9:24=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@syno=
psys.com> wrote:
> > >
> > > On Wed, Apr 16, 2025, Kuen-Han Tsai wrote:
>
> <snip>
>
> > > > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > > > index 89a4dc8ebf94..630fd5f0ce97 100644
> > > > --- a/drivers/usb/dwc3/gadget.c
> > > > +++ b/drivers/usb/dwc3/gadget.c
> > > > @@ -4776,26 +4776,22 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
> > > >       int ret;
> > > >
> > > >       ret =3D dwc3_gadget_soft_disconnect(dwc);
> > > > -     if (ret)
> > > > -             goto err;
> > > > -
> > > > -     spin_lock_irqsave(&dwc->lock, flags);
> > > > -     if (dwc->gadget_driver)
> > > > -             dwc3_disconnect_gadget(dwc);
> > > > -     spin_unlock_irqrestore(&dwc->lock, flags);
> > > > -
> > > > -     return 0;
> > > > -
> > > > -err:
> > > >       /*
> > > >        * Attempt to reset the controller's state. Likely no
> > > >        * communication can be established until the host
> > > >        * performs a port reset.
> > > >        */
> > > > -     if (dwc->softconnect)
> > > > +     if (ret && dwc->softconnect) {
> > > >               dwc3_gadget_soft_connect(dwc);
> > > > +             return -EAGAIN;
> > >
> > > This may make sense to have -EAGAIN for runtime suspend. I supposed t=
his
> > > should be fine for system suspend since it doesn't do anything specia=
l
> > > for this error code.
> > >
> > > When you tested runtime suspend, did you observe that the device
> > > successfully going into suspend on retry?
> >
> > Hi Thinh,
> >
> > Yes, the dwc3 device can be suspended using either
> > pm_runtime_suspend() or dwc3_gadget_pullup(), the latter of which
> > ultimately invokes pm_runtime_put().
> >
> > One question: Do you know how to naturally cause a run stop failure?
> > Based on the spec, the controller cannot halt until the event buffer
> > becomes empty. If the driver doesn't acknowledge the events, this
> > should lead to the run stop failure. However, since I cannot naturally
> > reproduce this problem, I am simulating this scenario by modifying
> > dwc3_gadget_run_stop() to return a timeout error directly.
> >
>
> I'm not clear what you meant by "naturally" here. The driver is
> implemented in such a way that this should not happen. If it does, we
> need to take look to see what we missed.
>
> However, to force the driver to hit the controller halt timeout, just
> wait/generate some events and don't clear the GEVNTCOUNT of event bytes
> before clearing the run_stop bit.
>
> BR,
> Thinh

Hi Thinh,

Thank you for getting back to me and the method to force the timeout!

By "naturally," I meant reproducing the issue without artificial steps
designed solely to trigger it. You're right; since the driver is
designed to prevent this state, reproducing it "naturally" is
difficult.

I really appreciate your patience, and thank you once more for the
helpful clarification.

Regards,
Kuen-Han

