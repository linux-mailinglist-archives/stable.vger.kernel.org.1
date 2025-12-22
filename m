Return-Path: <stable+bounces-203230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 877E5CD6A78
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 17:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E512A3050CD5
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AA4331A47;
	Mon, 22 Dec 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="gOVfiXMo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2E32ABE8
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766420655; cv=none; b=VbMAn4JyqIVFCUDaLWpJFahWq3aYHmEY7bMMZ8PIZ6MIFl3jaWKgtOrfG1fJj99i5LVsAn9EhB2YFrLDk7hc6UFoLHqi4DTjaoB1rk3Y5fWYdTHZlgak3JZpcU2BsbDAjvdXaevc7aPKHc6r9An8WuLa5ASYngPi3F8x92K+c+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766420655; c=relaxed/simple;
	bh=XVItW6gSKcVHQwKm0pZtptoh0/iOSe212L7bTsXr/iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHsI6PIDg2gpZbZH60irLBWhoiYvYxXoSddxNeGddwEHcyi85dHEKh9cHuVg/YzX57xjbRoJZv9FkZ50EKM7+r7COVihoczTATzgPdPTB7jfiWF0Xa9cVO36R/X3qT3iJfH1q5+1aNoStoUz7Vi5W36aViCcEq/s/hx54jNsbrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=gOVfiXMo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47755de027eso24227455e9.0
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1766420652; x=1767025452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLjJfObP/K+oUunUOwA+6cGq02GgqBNfpHQK+UmjiP0=;
        b=gOVfiXMo1dkjzvNXKEU7vR61IZ9B+Rnu9LFLP8WfOgG+FNAN19eYmnVco64ovU9B86
         4gK5TzJf2AAuxhMMKO9Sl5BpqOJ910Ug0FK2N6K57jl0HsOiY4BJ5HdVpimcMvcncFs5
         /nJSIvxJ3Y162VJftruPJ8G/BLUKkLQxcQYnM+TTehU0Wm8czcMA+LH+lZt84w/tAH5s
         TZS8aPz4zvNtYqMGIq2CC5WmqbA5PpM3ZLDUrEbHNylQSXB0iyPeERzzwWP/L4El+B4X
         u6HGg1lN/WLHRUaqUV4P5/OA7Ayl77X/gUKPfyNuNBYwblOhBIM4qEL0Rx1LcOCEdRq3
         kwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766420652; x=1767025452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DLjJfObP/K+oUunUOwA+6cGq02GgqBNfpHQK+UmjiP0=;
        b=V5A2Dhmb7XFxJ3Nvnf670x95p4kX7OQyQruddySkbs7FObTZy34GcUBm9bws5J8ls3
         DtGMF2vyAuv03aUdsQtCfeDGUM+DEf11+ILazdXAzPS74ZS508dQn2B3eimeWJbIEsQa
         R8w+jcPCQDTR4akRYtJYQgRoyOJLSPr89sMui8rbkEHywlC/C2kT3V4m1OZLBvr8a/Yr
         svk29KxwqgTBSVQwC3Mqramd/nh5APBbu9K3svkVLBKCu4UBFtBTnl2XvUehOs1xjDbf
         ArkLlyK89IEtW17DBIQDjmf6GbryCKiy/zenTIcj7jhXrroNfJaiaAAnHNlOnWY5DkKk
         QKQA==
X-Forwarded-Encrypted: i=1; AJvYcCWejmZErZFE+4NybdwWs3KeK3CJlAScZYgZca9f2pQzSQsS9ftMYKDOEtzq7dGXHExDK3WEnAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHN+5rS4OMvBMhqcs1YCWBxMmIic7MFDh2R4xyPGmTBlaBCImF
	OY/ky4q/bHsm92S5j6Kip+BYQmGWt01BrxaWv1G1XF/EP0eaRmpCJZ/Uwwr1/AM2ALZk5pwWRJx
	915VWzLF/XyLgcFSgwAFpY6lYUA/LcaPW+vLUFXhyJA==
X-Gm-Gg: AY/fxX5kRdI4Luiou5mro/SVYiWEP+uD+4v6MC3bBzqiudVOnw6zVdMszQJ6SCIkj49
	cvhAda/CvFGODAXik5d2A5dyDunJsGUUk8aiLjl4Tjno47xsvH4MLQOKK8mo1py8GQ3cf9rBMLv
	kSAsBKYIaqmszFSdncLGwkz4v3PXikTzDIRc+bBQqh78Y9D3bBX9vcucqU4X98Er7oVb/+G5iFS
	h2sKNOhSVATcI51x1fxk+TRyylwAq/kDiBoVVdRK/hWe3z3vgKof7pLrYIrjaH3ylinSBTTBcZi
	/AgJSVzIdZilRH9FLvLZEAvROYSs7UPFeGB8
X-Google-Smtp-Source: AGHT+IFW/UBY1GDGZy7+JOBpHniCxqKE76N35WUggR4qMT49RPhicXeZeNC8NVwnBV+j+R6YmNXQD2WuLXhh6A7dquM=
X-Received: by 2002:a05:600c:620d:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-47d19549f5dmr114996105e9.10.1766420651686; Mon, 22 Dec 2025
 08:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-virtio-console-lost-wakeup-v2-1-5de93cb3f1c1@isovalent.com>
 <abdeaef1-e6d4-43c3-b8c4-d5f0c645a169@app.fastmail.com>
In-Reply-To: <abdeaef1-e6d4-43c3-b8c4-d5f0c645a169@app.fastmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 22 Dec 2025 17:23:59 +0100
X-Gm-Features: AQt7F2ru5QJkYpqy-M7Zh310tyr-FS5keGw6oQRiOhDRRgbfqq5wSsUhJLfU_As
Message-ID: <CAN+4W8hAqVxbr040b_+Q-zF0Dv0utoj_UfwH+4LVk=Vx2TTFZA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: console: fix lost wakeup when device is
 written and polled
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 5:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Dec 22, 2025, at 17:04, Lorenz Bauer wrote:
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -971,10 +971,17 @@ static __poll_t port_fops_poll(struct file *filp,
> > poll_table *wait)
> >               return EPOLLHUP;
> >       }
> >       ret =3D 0;
> > -     if (!will_read_block(port))
> > +
> > +     spin_lock(&port->inbuf_lock);
> > +     if (port->inbuf)
>
> As far as I can tell, you got the interrupt flag handling wrong
> in both places: port_fops_poll() is called with interrupts
> enabled, so you have to use spin_lock_irq() to block the
> interrupt from hanging.

Ack.

> > @@ -1705,6 +1713,10 @@ static void out_intr(struct virtqueue *vq)
> >               return;
> >       }
> >
> > +     spin_lock_irqsave(&port->outvq_lock, flags);
> > +     reclaim_consumed_buffers(port);
> > +     spin_unlock_irqrestore(&port->outvq_lock, flags);
> > +
> >       wake_up_interruptible(&port->waitqueue);
>
> The callback seems to always be called with interrupts
> disabled(), so here it's safe to use spin_lock() instead
> of spin_lock_irqsave().

This is pretty much just copied from in_intr which also uses _irqsave.
I think it makes sense to stick to that for consistency's sake. What
do you think?

