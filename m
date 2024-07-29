Return-Path: <stable+bounces-62577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E293F8B2
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 16:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2582228305C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4A155C8F;
	Mon, 29 Jul 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4iGqQY8h"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A453B1534EC
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264603; cv=none; b=nucNFRPCA+7FCpADw3jVSmomThCAPb+IuY20lSkkjTGBxPqF6RWBfzeqlsyMlZczXqblOJHzLsP8FQWSg8o2GugleQhEIM2lpNjbHTK3xUyOAQMeIVw3P6HcQHBEtl4GP9mnfHMkx+53KlMS4ZfDT2wi22a2kMOrv4LpdaPIQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264603; c=relaxed/simple;
	bh=woLQBPacf7DTDxtXPvYGoMG7Uok2hCJqM57wPvFxsxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQbILCuMesOEGAWgTGMRWPdFOnEmDaKvuG0ebplSBEh/kDh+tN2YvHaNIB/DIx6wfKR4WX1uMsxynp5k144NbkIaDnElyLFLR+fLcFJN4m8H1qbiB91eYuJdlmGlnfMksY6FRtcWlF1VgZ2vdXDMNQPCT8VCqLjz9KmBo3rIGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4iGqQY8h; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f51e80f894so1486613e0c.1
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722264599; x=1722869399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc5OnpQkO4GI5cUSMqWm8aEGW3XO5gfb3sMJB+82c8A=;
        b=4iGqQY8hcJFqrjfF6+a+YsZqO90WvprJ3hC0RKaUX9aeEGJNBUIOH50i8K/Y6WhhWL
         7CkPvEv/CoADTm715FI3XRYOBAyUdWWOoTwoZoWxP29OV2Oyw+NLOeexykE8ZP6exC/a
         +vLPYqwmAusLXHY5FaaRbE4T/MfY4dG0agp1NjD4EBt3d8wXITSV0yjh8ozTlQOvjocc
         MQR++4sEQLzKFlpeoLHRf+EZ4fUIaDYSovkBs6WBSARyR/InsYIqFeec40hUyHcivpnI
         KOVKKITW7I+/FqTFGlBugrDMNT+XmiC7B8d26Fj2nVpCwHi2eSqm5dDfjey7b64exs4e
         0BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264599; x=1722869399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dc5OnpQkO4GI5cUSMqWm8aEGW3XO5gfb3sMJB+82c8A=;
        b=jKKjFqZ4NbqDIHFURA4ekxF/Ggn9VWdNy4VbrIgYpQTV4Ngj8XS5JVDlHokgFURpTG
         X5WfvMrtELXasxlzu7FVxAtDbf0qtYm9uCyKT9+iGBPokh4+lEK4cQioGlUZm4fQ22+o
         qvBvn3PrptQTPY3Uq5OLdLRFw89TptOkYClpWUkjy0SCNfXgNsy9xYlZZkhnr/7w0h/p
         6EIV+M+A3oQqNTLYrmhf0R/93+HfS1yAYxee63YMOIwQUO+hCMBnXLZZ3ZIuvqcuFCJO
         CCTT9fDtNi+eBQOyAfHgAc8v9FYFxyaUD6Zr0Gg4Q+yr1A9WXb9ciatwQBCg5mx4F1uA
         iNww==
X-Forwarded-Encrypted: i=1; AJvYcCWxrN5SWPAekZHrhbkwJcHhDu6teSz9PwopgFC8JQttFeiB2G2kjQaovjjPoJvlkdBPLISttLIou6sEQm1A1i/r2c50I3by
X-Gm-Message-State: AOJu0YxJFIdBs9KcmG5N/X2AHT7Xjz2RpQEgGSqNqE8ca1FhF2l/0wVe
	SZI+m3WZepugYKKhaRq0NuYftX1dGs7D2sppm+FUXpH4NfGlbPRAnjTAQBBPeDUYLjsOI9m+0lQ
	uUTQBpe92y542r0cQxwjlAFvmJEVgX0wYUEuE
X-Google-Smtp-Source: AGHT+IHFMADPLpMiCf0PtUHwwXP9ydcCss5DHpj4/ujsEVhBsMJ/f20LMGXqV2SAf4576Qb9p5SV9/SHngSzxzrhnsQ=
X-Received: by 2002:a05:6122:310a:b0:4f6:a5ed:eb11 with SMTP id
 71dfb90a1353d-4f6e68f714amr9340551e0c.8.1722264599389; Mon, 29 Jul 2024
 07:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729022158.92059-1-andrey.konovalov@linux.dev> <CANpmjNP6ouX1hSayoeOHu7On1DYtPtydFbEQtxoTbsnaE9j77w@mail.gmail.com>
In-Reply-To: <CANpmjNP6ouX1hSayoeOHu7On1DYtPtydFbEQtxoTbsnaE9j77w@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 29 Jul 2024 16:49:20 +0200
Message-ID: <CANpmjNOTnYUZDNG0z64rY7fOd2f2ZPW9qV6Gaz1=n_NWmHjAZA@mail.gmail.com>
Subject: Re: [PATCH] kcov: properly check for softirq context
To: andrey.konovalov@linux.dev
Cc: Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Aleksandr Nogikh <nogikh@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Marcello Sylvester Bauer <sylv@sylv.io>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 11:42, Marco Elver <elver@google.com> wrote:
>
> On Mon, 29 Jul 2024 at 04:22, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > When collecting coverage from softirqs, KCOV uses in_serving_softirq() to
> > check whether the code is running in the softirq context. Unfortunately,
> > in_serving_softirq() is > 0 even when the code is running in the hardirq
> > or NMI context for hardirqs and NMIs that happened during a softirq.
> >
> > As a result, if a softirq handler contains a remote coverage collection
> > section and a hardirq with another remote coverage collection section
> > happens during handling the softirq, KCOV incorrectly detects a nested
> > softirq coverate collection section and prints a WARNING, as reported
> > by syzbot.
> >
> > This issue was exposed by commit a7f3813e589f ("usb: gadget: dummy_hcd:
> > Switch to hrtimer transfer scheduler"), which switched dummy_hcd to using
> > hrtimer and made the timer's callback be executed in the hardirq context.
> >
> > Change the related checks in KCOV to account for this behavior of
> > in_serving_softirq() and make KCOV ignore remote coverage collection
> > sections in the hardirq and NMI contexts.
> >
> > This prevents the WARNING printed by syzbot but does not fix the inability
> > of KCOV to collect coverage from the __usb_hcd_giveback_urb when dummy_hcd
> > is in use (caused by a7f3813e589f); a separate patch is required for that.
> >
> > Reported-by: syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=2388cdaeb6b10f0c13ac
> > Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> > ---
> >  kernel/kcov.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index f0a69d402066e..274b6b7c718de 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -161,6 +161,15 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
> >         kmsan_unpoison_memory(&area->list, sizeof(area->list));
> >  }
> >
> > +/*
> > + * Unlike in_serving_softirq(), this function returns false when called during
> > + * a hardirq or an NMI that happened in the softirq context.
> > + */
> > +static inline bool in_softirq_really(void)
> > +{
> > +       return in_serving_softirq() && !in_hardirq() && !in_nmi();
> > +}
>
> Not sure you need this function. Check if just this will give you what you want:
>
>   interrupt_context_level() == 1
>
> I think the below condition could then also just become:
>
>   if (interrupt_context_level() == 1 && t->kcov_softirq)
>
> Although the softirq_count() helper has a special PREEMPT_RT variant,
> and interrupt_context_level() doesn't, so it's not immediately obvious
> to me if that's also ok on PREEMPT_RT kernels.
>
> Maybe some RT folks can help confirm that using
> interrupt_context_level()==1 does what your above function does also
> on RT kernels.

Hmm, so Thomas just told me that softirqs always run in threaded
context on RT and because there's no nesting,
interrupt_context_level() won't work for what I had imagined here.

So your current solution is fine.

Acked-by: Marco Elver <elver@google.com>

> >  static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
> >  {
> >         unsigned int mode;
> > @@ -170,7 +179,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
> >          * so we ignore code executed in interrupts, unless we are in a remote
> >          * coverage collection section in a softirq.
> >          */
> > -       if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
> > +       if (!in_task() && !(in_softirq_really() && t->kcov_softirq))
> >                 return false;
> >         mode = READ_ONCE(t->kcov_mode);
> >         /*
> > @@ -849,7 +858,7 @@ void kcov_remote_start(u64 handle)
> >
> >         if (WARN_ON(!kcov_check_handle(handle, true, true, true)))
> >                 return;
> > -       if (!in_task() && !in_serving_softirq())
> > +       if (!in_task() && !in_softirq_really())
> >                 return;
> >
> >         local_lock_irqsave(&kcov_percpu_data.lock, flags);
> > @@ -991,7 +1000,7 @@ void kcov_remote_stop(void)
> >         int sequence;
> >         unsigned long flags;
> >
> > -       if (!in_task() && !in_serving_softirq())
> > +       if (!in_task() && !in_softirq_really())
> >                 return;
> >
> >         local_lock_irqsave(&kcov_percpu_data.lock, flags);
> > --
> > 2.25.1
> >

