Return-Path: <stable+bounces-45159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307658C64D8
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 12:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95CF283B16
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA79E59B4E;
	Wed, 15 May 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUZ2cIt4"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6457CB5
	for <stable@vger.kernel.org>; Wed, 15 May 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768166; cv=none; b=FUHvSxYRS/jMX3hovG3eROO1jrgI3/hSmhCdp6FsSeieazO2x5KMkFDaOFBI01tjK8g7sbFQzDEPhSlgJFT38y03z1+qo4MuH/+MXIjYeoB3VjxpkCLqtSToabYaSxx7tpbEwxfvauQhUv0dY6V/KM06d0J68UA/D6u+FXFcHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768166; c=relaxed/simple;
	bh=gXggWbnUgn/mfjIKpjPmMwn25xSIqBJo+H6I6JNm25E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiETZbgNay28LN2oh2SES65To93IYJ5XwGqdEKICpquOCCoz418TnKyUVoLZ44ZgdQH0hAU0rOtPCSZlVslDB+In+gchVf8oH7apWiK0ytnkDErduQSpTsciABiB9GxFPywd15GX327LPmueO4DcLxkP3YxUeoxme6Rzmu4tia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUZ2cIt4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e45c0a8360so69097151fa.3
        for <stable@vger.kernel.org>; Wed, 15 May 2024 03:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715768163; x=1716372963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V4is+tAHNm6NjlZfRps+lWqihtorK58wlyQNHpZXZU=;
        b=QUZ2cIt4bt7MkigZq+90+685dDQHL4wsrMxk46b5PIfxG/iCJJ/C/oEomWLMAd0Ly6
         0gteOZ0MSyKevcJRTypoab3TiHl9BPre8k/TJvRr2B2tVWsYpeJaCLk+XMmXrAk0oihE
         zyQOJW9/oQYrLBztt2QgPAFzKLtiJb7ZJx9lN6O66BQ5mIvaZR5lT4D2S9xaUuXsthgv
         t3klMbA+EZujPohIt6MkQBDqor7DbDFkqk14zkTdhGs8HiHYp2plmTfxkdDwJLbXbBDY
         5Vu6NKdCgf2SeYjEab/1KMa6MVlO+wyhWZY/f+zUlQfrc0UglV37jXAfNdx6zrfEYVlY
         Sw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715768163; x=1716372963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V4is+tAHNm6NjlZfRps+lWqihtorK58wlyQNHpZXZU=;
        b=EJUtDa7X42suSnPLvrlVUR3Ol85PZMnkZtSMm/RpWMRaeqvqTyHLOBECej/2bRSWk+
         NMF0HqvReFXzi1iRQttVtQlDW2ho0O0Yb0P7mBxpqmY+GJH00Hwq1SFGCswQ8uRmvegS
         y7AC1fZaPmq0aI7D//xqKGukYhtxukSOS0al6n2nHNjMshKpQLYzaDGzvi4Vu2hRK+kf
         qlCoMpTbyD7qCjZWF8qEsTg03e8Othc46rxiCcdoExRPSE0dePLaCw/hMiJdVIlbwlK8
         5IiqH9gEm3xT6Cjh3Xt30whHYwYxzXyVv7W3a7YsWWOyEVfwQ7WpJxy2oIxxH6bvSIFM
         OHuw==
X-Forwarded-Encrypted: i=1; AJvYcCUTmIlMAgs2tRabb3xJa2tGHh79CNbp1uOXY05OJg2A0hW8pNUiOBTmoj0O0nOpyeNTW55YVgzPR8Gay9SGsViXOG7kfYro
X-Gm-Message-State: AOJu0Yx5OVJSPqFLy6t7HO+eCvrEDs727bu9RQnnyqsUuRlLXrwk6ps+
	QQq6h3eO4Q58M3i/dRTw8zfIOtVKkH7lISdgHGAHkrgN6BHElEySJqg6YCc1dQtgMViwR6x9in7
	ENP3c4WyWF11BfNZHTT8WF0vqNY6BG9Vn
X-Google-Smtp-Source: AGHT+IHZqy7XY/xZ3UuGR2SPKxflo8jnbBotYBY3aqyTQ4g3u13St+fGHNonculwMi0AH5TideMPUJXyMYBKXnzHDR4=
X-Received: by 2002:a2e:7812:0:b0:2e0:aeba:ba90 with SMTP id
 38308e7fff4ca-2e6da17c320mr26972991fa.46.1715768162931; Wed, 15 May 2024
 03:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514083920.3369074-1-ubizjak@gmail.com> <2024051540-tranquil-stoppable-30ff@gregkh>
 <CAFULd4an2qYe3L-yrfnmf3F1AZPciNemjdMEorO2BLHJX72uXg@mail.gmail.com>
In-Reply-To: <CAFULd4an2qYe3L-yrfnmf3F1AZPciNemjdMEorO2BLHJX72uXg@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 15 May 2024 12:15:51 +0200
Message-ID: <CAFULd4bma_gVhzRkV=Ds1P8z9g-Xn_kw0XSYNnhTogJY98uUYQ@mail.gmail.com>
Subject: Re: [PATCH] x86/percpu: Use __force to cast from __percpu address space
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:03=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
>
> On Wed, May 15, 2024 at 9:32=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Tue, May 14, 2024 at 10:39:18AM +0200, Uros Bizjak wrote:
> > > commit a55c1fdad5f61b4bfe42319694b23671a758cb28 upstream.
> > >
> > > Fix Sparse warning when casting from __percpu address space by using
> > > __force in the cast. x86 named address spaces are not considered to
> > > be subspaces of the generic (flat) address space, so explicit casts
> > > are required to convert pointers between these address spaces and the
> > > generic address space (the application should cast to uintptr_t and
> > > apply the segment base offset). The cast to uintptr_t removes
> > > __percpu address space tag and Sparse reports:
> > >
> > >   warning: cast removes address space '__percpu' of expression
> > >
> > > Use __force to inform Sparse that the cast is intentional.
> >
> > Why is a fix for sparse required for stable kernels?
>
> Named address spaces is a new feature in the 6.8 kernel. When someone
> compiles this version with Sparse (and certain sparse parameters), it
> will spew many sparse warnings. We have fixed this in the tip tree
> (so, the fix will be in v6.9), but the tip tree diverted from the
> mainline in this area, so it was not possible to fix the issue in 6.8
> via "urgent" tip branches.
>
> I thought that the fix falls into "some =E2=80=9Coh, that=E2=80=99s not g=
ood=E2=80=9D issue"
> category (due to many sparse warnings). Also, the fix is
> straightforward with a low possibility of breaking something.
>
> > > The patch deviates from upstream commit due to the unification of
> > > arch_raw_cpu_ptr() defines in the commit:
> > >
> > >   4e5b0e8003df ("x86/percpu: Unify arch_raw_cpu_ptr() defines").
> > >
> > > Fixes: 9a462b9eafa6 ("x86/percpu: Use compiler segment prefix qualifi=
er")
> > > Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
> > > Closes: https://lore.kernel.org/lkml/CAFGhKbzev7W4aHwhFPWwMZQEHenVgZU=
j7=3DaunFieVqZg3mt14A@mail.gmail.com/
> > > Cc: stable@vger.kernel.org # v6.8
> > > Link: https://lore.kernel.org/r/20240402175058.52649-1-ubizjak@gmail.=
com
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > ---
> > >  arch/x86/include/asm/percpu.h | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > And also, what kernel version(s) is this for?
>
> As instructed in the "Procedure for submitting patches to the -stable
> tree", it is stated at:
>
> Cc: stable@vger.kernel.org # v6.8

Oh, I mixed up kernel versions... this should apply to just released v6.9.

> >
> > I don't see this in any released kernels yet either, is that
> > intentional?
>
> The original fix was committed to the current mainline and will be in
> v6.9, but please also see the above reasoning. However, it is your

The original fix will be in v6.10, I mixed up the number ...

> call, so if you think that this issue is not problematic for a stable
> kernel, it's also OK with me.

Thanks,
Uros.

