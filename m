Return-Path: <stable+bounces-56015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C7591B2E4
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 01:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543012836A4
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC21A2FCE;
	Thu, 27 Jun 2024 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6sx5cx2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2B1A2FCA;
	Thu, 27 Jun 2024 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531567; cv=none; b=OpOWcO84mOGkCxsuBqwPQwRvpaO/9k5895L+88OV92AgVQlAvR6LcfdfEebmaY9Jr8CO+jKF11WeRMG1NZJVXWj3AQudW9I66U69O2aA9awvAYZuAZQjJ5x1V32PgmLyfYAwmnNv1VkwjMXbLRw7YaOkJ2x0A4FT8EyEvQ3Ywss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531567; c=relaxed/simple;
	bh=4dgo0vzozQ1kcwKyT88n1cGwFAwgm+5DIZMYhAxw+ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arevWGMCBuEe9WFX1X7Y2l33LcGX1iTZsDPhyQetLzxy634nPQVfyjJOIrFD6wev59nu209RitomyICaaAlhgXsCvsf/jVDKh8NB188N4Ps+ZMY6/6WsJQ/PvqeR2RxOLzpisCoFsIQA/+PH9YQiuoapXTSSXsIXP4EbbQZ6knU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6sx5cx2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354b722fe81so5716438f8f.3;
        Thu, 27 Jun 2024 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719531564; x=1720136364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2DwRKJydhM2IlkFOwSrRQDjXR/j+nt3JFuEntb/+Ks=;
        b=D6sx5cx29U6k/Fk3zGTpEY4Q6oUtKZ/ZTA+8gUcoekgD6gBE4AbZPkpS5vA9+tWVBK
         CDbHtvYNdUKQ1l+b6OFPkiremT0pnO7grolORNJ8pCnsb1k+/bKdU6MSxwPylvhQz2Pv
         arqILzc+CyXOvKiu8uRNxX7TUxN1yUFuv87bPxYFl3YOiAN3qBTDacth+y+EEm/n8zB+
         R9XodqEClu3x5EEsFZPm6lmI58jhfYcEVveBmHAUgAgLGsuu/CahI0l/eIvt6PDOTztr
         b2/cTFZAi48oJRMGTFENhlmIcAmHxNJ3W9uT2DqXr1qz0432NABcq2dSsY65n1mmzTMY
         0nJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719531564; x=1720136364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2DwRKJydhM2IlkFOwSrRQDjXR/j+nt3JFuEntb/+Ks=;
        b=bhVHS7LnH5PXAS7vV730yvuZF2X5cTO5OzmN7Ak8z+GIxl5IRwNVR8yhkOb6TgwotY
         tlqaXV5ICbayae4I/EBTzzzC9EPblpUpMUQ/AmnoViI8L/Dd8iVoqtylNum299RVnOZe
         cAjWyk4LRNZ2np9GgFeMLaCg8GctXnvGVxHE0jXv5K1SS4IP1sya0MScevTS08c92h4P
         nio8Jw4fsl+03C7a04bJkLRlLQZxpS7IoXrTBx6I/pnYGJR1t/F+q3Q5+Xvi4d1x/Lbw
         RvQ9va0P4EEQTOwzSebuUS79YHvnlATnuc3JnKvBT325ZYfXj6cZV74PKk1iNOFWM7/t
         0gLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT0Zl4a3CfPLa6OHPydxbF/KGyALEj+okwmEGo/0V5CczTk64wPop9ywYm36PI8mbnmPMM8V/lQL2auNhzubO/hRDjCjM+mTPIa34bjhjxkt+SJxbbIfkjIgrhukP2hs2OtImx
X-Gm-Message-State: AOJu0Yyqk1Doe4r2FTn1juyA0bdmpIV4mIpjUc1WM+skMi3s4Zk6a4gD
	gCG/wFijY54nvUurXT4ULa/prkKmaPDc/taWffSBXB4nWQp6GfYc6JLujEAwUrH/gyyDPrC4YnX
	3upHkukji22OUgAuUYID5hIsgZG0=
X-Google-Smtp-Source: AGHT+IHEFyDEf4x/+0sDRu/nIqEnSKIGdauq1Fpp/i9QoWl++9ebYITc5C9oApYduIzCM4IO42LH1G8rWlyzmNafKPU=
X-Received: by 2002:a05:6000:d0a:b0:362:80af:1adc with SMTP id
 ffacd0b85a97d-366e4f00a9fmr9622395f8f.53.1719531564003; Thu, 27 Jun 2024
 16:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627221413.671680-1-yang@os.amperecomputing.com>
 <Zn3zjKnKIZjCXGrU@x1n> <20240627163242.39b0a716bd950a895c032136@linux-foundation.org>
In-Reply-To: <20240627163242.39b0a716bd950a895c032136@linux-foundation.org>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 27 Jun 2024 16:39:11 -0700
Message-ID: <CAHbLzkqtDxcqDH-ujiqsY6tp49vkyU8RQTrmjT6oA4Cc-cdsxw@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Yang Shi <yang@os.amperecomputing.com>, yangge1116@126.com, 
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 4:32=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 27 Jun 2024 19:19:40 -0400 Peter Xu <peterx@redhat.com> wrote:
>
> > Yang,
> >
> > On Thu, Jun 27, 2024 at 03:14:13PM -0700, Yang Shi wrote:
> > > The try_grab_folio() is supposed to be used in fast path and it eleva=
tes
> > > folio refcount by using add ref unless zero.  We are guaranteed to ha=
ve
> > > at least one stable reference in slow path, so the simple atomic add
> > > could be used.  The performance difference should be trivial, but the
> > > misuse may be confusing and misleading.
> >
> > This first paragraph is IMHO misleading itself..
> >
> > I think we should mention upfront the important bit, on the user impact=
.
> >
> > Here IMO the user impact should be: Linux may fail longterm pin in some
> > releavnt paths when applied over CMA reserved blocks.  And if to extend=
 a
> > bit, that include not only slow-gup but also the new memfd pinning, bec=
ause
> > both of them used try_grab_folio() which used to be only for fast-gup.
>
> It's still unclear how users will be affected.  What do the *users*
> see?  If it's a slight slowdown, do we need to backport this at all?

I think Peter meant the warning reported by yangge?

Peter also mentioned the patch subject is misleading. I agree. So
how's about "mm: gup: stop abusing try_grab_folio()"?

>
> >
> > The patch itself looks mostly ok to me.
> >
> > There's still some "cleanup" part mangled together, e.g., the real meat
> > should be avoiding the folio_is_longterm_pinnable() check in relevant
> > paths.  The rest (e.g. switch slow-gup / memfd pin to use folio_ref_add=
()
> > not try_get_folio(), and renames) could be good cleanups.
> >
> > So a smaller fix might be doable, but again I don't have a strong opini=
on
> > here.
>
> The smaller the better for backporting, of course.

I view the fix to the warning as just by-product of the clean up. The
whole patch is naturally integral IMHO. We can generate a smaller fix
if it is too hard to backport. However, it should be ok since we just
need to backport to 6.6+.

>

