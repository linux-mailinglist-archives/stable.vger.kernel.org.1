Return-Path: <stable+bounces-85064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F38B99D591
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 19:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D29B23AAB
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1851BFE10;
	Mon, 14 Oct 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dCZQSQJo"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C31BDABD
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926768; cv=none; b=S0YZgOmRTM4bdF92PBr6/JfUcygdBAKsbG/qr/I4seV+wigLZUCm7NIeQfYzZzmZ6qR1eE13PSxw0yhIHTdCnxyq2aiyciw0H5heOC6F4tULt7+6DppvGNrtq9gFlIzPwMCw1OLzZPH2sDStYpGfAiqTCkdh23yLs/nj959nnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926768; c=relaxed/simple;
	bh=uigYimarVzmmeVkZ6JXlUiB4rHUo2e1dTwi63nRQ5BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2okl2TVQdaeYo091G+sgzdCOjdNLmeb5PMm99MJLiBeKanaPDVco++lS50cRkn+VVm//T591i71pgtLBEEEMrsDMqJk0ZG/klt27FCb0rpJdmkblulXJ8hnltiFvyY/GUfsoXeDM72PH1yfmKkBqTOaFmuzfZNWcZdLuKRfACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dCZQSQJo; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-286f4d2abf1so116847fac.2
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728926766; x=1729531566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlnlxvjVr6HTljTZe9LtOqMCzvo+1189HVWgfn/7xjA=;
        b=dCZQSQJokve5qlW6KT4Im5BzJKOzI79GJ4hXmEHV04iKOIiApR7OTGHjgd44ZTxAKc
         rX2bm5mei3/b44XIJE50ibTOUkPsv8gzwrq+wEo9F5z+GHwfOcpUgVVpKhrJXaa+5xIJ
         VoCqz6pRmjq9woIgzRZ1WR+Dbpuaa9IkcpbPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728926766; x=1729531566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlnlxvjVr6HTljTZe9LtOqMCzvo+1189HVWgfn/7xjA=;
        b=Ffggo1/JiwPC3qQhHdaUqRRsHdqLGA8kRW8FeThkS6UmsTImkgECBXKTvDqozFC7y4
         NYaWCMhCGgVnZLkpOuJL4dkbSuylG/s7pvyZGldpsocIZP5NYJrov/soMzgohYxhod8V
         yheErnHyfbtVxwQAMfNpfDqriwWiacymT2hNKjOl8AiTG7EdUZ77qpgPN992+HixrLoq
         9Z5K0gJ49t858wQPOGlhp6VaUCiOMZxrVY6ny1kXJYp7g/baSv3iWV4dJq1M/mL41D8O
         4Zda8040onZ00qwd6IIIRhrLwgzbtGiV12GOo7GwwbZGviDr/XD7cpx2gotw5fl1kneZ
         YrvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVPulSYZ8Ni9lKb7tM3R/bwNHl9oUGumBE3wd0I+iCmvbn158gLtC4QthgGmWQr6b3qFRqUH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRYgs/rM0KWDkJXeYoD6QNMMqPHAqXpJ3RU1bwlVpdQpLIr9jw
	CMP7K3uSjNr7RKSgQCEDaqnecEOSbNTi/MXdI67hfrEmUpN2sV+lElJoY3y/EnuwvNDquDY8vyH
	TmjzcFTrtZoLFjjOvupDzxfD+MuAUtD3kRyM5
X-Google-Smtp-Source: AGHT+IHTH8AOz9uztCsGXW0o/GDRNhYq/rvHXYz8hf0T2GIgALRC9GLMXM7S8ZVz8u4sW44R+4zy5GwV4bsfyuI0GWQ=
X-Received: by 2002:a05:6870:b48c:b0:277:df45:a49e with SMTP id
 586e51a60fabf-2886da44981mr1947334fac.0.1728926766328; Mon, 14 Oct 2024
 10:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkW0Q8zAkmVg8qz9WV+Fkjft4stO67ajx0Gos82Sc4vjhg@mail.gmail.com>
 <2024101439-scotch-ceremony-c2a8@gregkh> <CABi2SkWSLHfcBhsa2OQqtTjUa-gNRYXWthwPeWrrEQ1pUhfnJg@mail.gmail.com>
 <2024101437-taco-confusion-379f@gregkh> <CABi2SkVA3qynBG1Ra_v2pg_k-pAzfjGc4VSDMN2L9tv9BreAiw@mail.gmail.com>
 <2024101409-catcall-sequence-3ecf@gregkh>
In-Reply-To: <2024101409-catcall-sequence-3ecf@gregkh>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 14 Oct 2024 10:25:54 -0700
Message-ID: <CABi2SkUvE3uJT0Zt+1WWSgSAneVo+Y_-UYR7DqhGk8OBevs1Qw@mail.gmail.com>
Subject: Re: backport mseal and mseal_test to 6.10
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pedro Falcato <pedro.falcato@gmail.com>, 
	stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:23=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Oct 14, 2024 at 09:19:55AM -0700, Jeff Xu wrote:
> > On Mon, Oct 14, 2024 at 9:12=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 08:27:29AM -0700, Jeff Xu wrote:
> > > > On Sun, Oct 13, 2024 at 10:54=E2=80=AFPM Greg KH <gregkh@linuxfound=
ation.org> wrote:
> > > > >
> > > > > On Sun, Oct 13, 2024 at 10:17:48PM -0700, Jeff Xu wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > How are you?
> > > > > >
> > > > > > What is the process to backport Pedro's recent mseal fixes to 6=
.10 ?
> > > > >
> > > > > Please read:
> > > > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-=
rules.html
> > > > > for how all of this works :)
> > > > >
> > > > > > Specifically those 5 commits:
> > > > > >
> > > > > > 67203f3f2a63d429272f0c80451e5fcc469fdb46
> > > > > >     selftests/mm: add mseal test for no-discard madvise
> > > > > >
> > > > > > 4d1b3416659be70a2251b494e85e25978de06519
> > > > > >     mm: move can_modify_vma to mm/vma.h
> > > > > >
> > > > > >  4a2dd02b09160ee43f96c759fafa7b56dfc33816
> > > > > >   mm/mprotect: replace can_modify_mm with can_modify_vma
> > > > > >
> > > > > > 23c57d1fa2b9530e38f7964b4e457fed5a7a0ae8
> > > > > >       mseal: replace can_modify_mm_madv with a vma variant
> > > > > >
> > > > > > f28bdd1b17ec187eaa34845814afaaff99832762
> > > > > >    selftests/mm: add more mseal traversal tests
> > > > > >
> > > > > > There will be merge conflicts, I  can backport them to 5.10 and=
 test
> > > > > > to help the backporting process.
> > > > >
> > > > > 5.10 or 6.10?
> > > > >
> > > > 6.10.
> > > >
> > > > > And why 6.10?  If you look at the front page of kernel.org you wi=
ll see
> > > > > that 6.10 is now end-of-life, so why does that kernel matter to y=
ou
> > > > > anymore?
> > > > >
> > > > OK, I didn't know that. Less work is nice :-)
> > >
> > > So, now that you don't care about 6.10.y, what about 6.11.y?  Are any=
 of
> > > these actually bugfixes that people need?
> > >
> > Oh, yes. It would be great to backport those 5 mentioned to 6.11.y.
>
> Why, are they bugfixes?
>
Yes. For performance, there are 5% impact with mprotect/madvise.

> > I don't know what will be the lifetime of 6.11.y, but keeping mseal's
> > semantics consistent across releases is important.
>
> Stable kernels last until the next release happens, like has been
> happening for 15+ years now, nothing new here :)
>
Does it mean that with 6.12, 6.11.y will be EOL soon ? say in the next
few months?
(Sorry that I didn't know much about linux release cycle. )

> If you wish to have patches backported to stable kernels, please read
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> thanks,
>
> greg k-h

