Return-Path: <stable+bounces-85067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EAA99D667
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 20:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453A91F231B7
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678A51C830B;
	Mon, 14 Oct 2024 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or/bHMp0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E61FAA
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930249; cv=none; b=mUQ5u8vlHLOjS76R/QGHM3ljRt7tHMVZvu+cCqkwsg3qlnZi+soUmWgvTDx85cOKsregv9/z2wuyGUOxHIOYMv8QUicGwXagquNzJ8W3DMzPSzwhIat/kZarjH3AyRY6HEhuaxq50lzawwoNRkhZuuO6efkB7zJVdS5u3HxuRDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930249; c=relaxed/simple;
	bh=Ugpf28+BX21KTDlzOXA55jWdAh3tO3bIx4b8bkrJTjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSRLaCAuAN46w/hl0rOdTpZUVYFG8iqPp2sHupaPryWrlWshtba6DBLJBkCvU+CjwE2E+Voo9NVx2Y1i1yNJthvq3KS8AGC+XsEYJk/VchbA1z8K5JM8UysY8tu5x80RW7lhTkntrw+Axf45JBnTH4T6Riy+H6FdMMSPgitm3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Or/bHMp0; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fb86af725so1076983241.0
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728930246; x=1729535046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWA3q1xxRb7xYKQA+x0DoblDlxuuohVMInSPlIyE/0o=;
        b=Or/bHMp0AJ+NwGgZh2oCKnnmNaAw6svFZYOiZFDTOHAKeRGkldb4g8pUnLkfdxZwSp
         KwQre+f0tHygu5pi7Xo5jYjKZmPklHdX8OIk0h2dTRa10Iait2kiShLjHQomWYFRdXxR
         XznSZEKBeI1jpc75pHSl/0zzprMHKeHV0i/UVm68U1ZS/VlKkw+Ce2J8Z4v7111NwgL/
         aGT3x2tMhaiOZsAq211WlVPXEMGdhwdeUE8ahA0yr9rB+/WsfoLk03E0yncPzDDag8Ou
         7M45PtkeJYMjUh276cjUAl51DbsiQppKfvJZyu/puCF/XRabgCwCDTpZ5wXFypIEgzv/
         j55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930246; x=1729535046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWA3q1xxRb7xYKQA+x0DoblDlxuuohVMInSPlIyE/0o=;
        b=J8Le11ay7IfxETkTGZUQ59ratdFhrgEHb3OJAr9co4vJy5bOmCvbbIi7RGaWxHtuWG
         wgTwc8QY6G4iQsv+Ye5jXceCjHGHjdj6K21FV7rid8WDGG+plz+5oQwdN9IsIcoMP/6t
         XUDvlldYbjqXpFeAf5OruwKFf3PsYXA/J4j1kcmy4qWL5bnOlSsFIJw7I2vXZFH0AFce
         9fS9xkifa0rNxMv7BpVVm1R+oNz2N4FoG8ibdaw+GA+wZjFe+f7447dpFClzVsTJwTjL
         mmB7U1GtDqrssbBwFxhOCbcRM/zNlmQzTbpN5QolVvsoHppfKOCt3DfxH0THefUPwj70
         SRag==
X-Forwarded-Encrypted: i=1; AJvYcCWTcm5HmnAG49ZMnnupNgPbg26lMciBR2nsSxXySUO7XIAtzQuvhqBwv+pFZ9VSPargFkYN8KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOv5p/0FOnB4KyxsIup1AwLwTk2x+nkyHtvlS0IGTDb5kQGinz
	P1Ebn5MtTDsBpWk/ysqDwHbMj/1pq6ms8IIFQnUtniEZUdQ9ZQMv6J7Xs0wNUjn9OINlgdmlXkU
	lxcUARirDIwrmL/oaVEOIMZVdfA4=
X-Google-Smtp-Source: AGHT+IHA1i/qDMaVvt1/YWtyflqkegSmEnU/ED3CLHuquHFA2OW2bkqt/KMoYWTglf1EJSuTYjpzecJusxOXP8Za5NA=
X-Received: by 2002:a05:6122:791:b0:50c:eb10:9799 with SMTP id
 71dfb90a1353d-50d374a2d6emr5037446e0c.1.1728930246496; Mon, 14 Oct 2024
 11:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkW0Q8zAkmVg8qz9WV+Fkjft4stO67ajx0Gos82Sc4vjhg@mail.gmail.com>
 <2024101439-scotch-ceremony-c2a8@gregkh> <CABi2SkWSLHfcBhsa2OQqtTjUa-gNRYXWthwPeWrrEQ1pUhfnJg@mail.gmail.com>
 <2024101437-taco-confusion-379f@gregkh> <CABi2SkVA3qynBG1Ra_v2pg_k-pAzfjGc4VSDMN2L9tv9BreAiw@mail.gmail.com>
 <2024101409-catcall-sequence-3ecf@gregkh> <CABi2SkUvE3uJT0Zt+1WWSgSAneVo+Y_-UYR7DqhGk8OBevs1Qw@mail.gmail.com>
In-Reply-To: <CABi2SkUvE3uJT0Zt+1WWSgSAneVo+Y_-UYR7DqhGk8OBevs1Qw@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Mon, 14 Oct 2024 19:23:55 +0100
Message-ID: <CAKbZUD33caL6yU7tkunTT5RweMoUmcny=AT-pcMOU+piY0X6cg@mail.gmail.com>
Subject: Re: backport mseal and mseal_test to 6.10
To: Jeff Xu <jeffxu@chromium.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:26=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Mon, Oct 14, 2024 at 9:23=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Mon, Oct 14, 2024 at 09:19:55AM -0700, Jeff Xu wrote:
> > > On Mon, Oct 14, 2024 at 9:12=E2=80=AFAM Greg KH <gregkh@linuxfoundati=
on.org> wrote:
> > > >
> > > > On Mon, Oct 14, 2024 at 08:27:29AM -0700, Jeff Xu wrote:
> > > > > On Sun, Oct 13, 2024 at 10:54=E2=80=AFPM Greg KH <gregkh@linuxfou=
ndation.org> wrote:
> > > > > >
> > > > > > On Sun, Oct 13, 2024 at 10:17:48PM -0700, Jeff Xu wrote:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > How are you?
> > > > > > >
> > > > > > > What is the process to backport Pedro's recent mseal fixes to=
 6.10 ?
> > > > > >
> > > > > > Please read:
> > > > > >     https://www.kernel.org/doc/html/latest/process/stable-kerne=
l-rules.html
> > > > > > for how all of this works :)
> > > > > >
> > > > > > > Specifically those 5 commits:
> > > > > > >
> > > > > > > 67203f3f2a63d429272f0c80451e5fcc469fdb46
> > > > > > >     selftests/mm: add mseal test for no-discard madvise
> > > > > > >
> > > > > > > 4d1b3416659be70a2251b494e85e25978de06519
> > > > > > >     mm: move can_modify_vma to mm/vma.h
> > > > > > >
> > > > > > >  4a2dd02b09160ee43f96c759fafa7b56dfc33816
> > > > > > >   mm/mprotect: replace can_modify_mm with can_modify_vma
> > > > > > >
> > > > > > > 23c57d1fa2b9530e38f7964b4e457fed5a7a0ae8
> > > > > > >       mseal: replace can_modify_mm_madv with a vma variant
> > > > > > >
> > > > > > > f28bdd1b17ec187eaa34845814afaaff99832762
> > > > > > >    selftests/mm: add more mseal traversal tests
> > > > > > >
> > > > > > > There will be merge conflicts, I  can backport them to 5.10 a=
nd test
> > > > > > > to help the backporting process.
> > > > > >
> > > > > > 5.10 or 6.10?
> > > > > >
> > > > > 6.10.
> > > > >
> > > > > > And why 6.10?  If you look at the front page of kernel.org you =
will see
> > > > > > that 6.10 is now end-of-life, so why does that kernel matter to=
 you
> > > > > > anymore?
> > > > > >
> > > > > OK, I didn't know that. Less work is nice :-)
> > > >
> > > > So, now that you don't care about 6.10.y, what about 6.11.y?  Are a=
ny of
> > > > these actually bugfixes that people need?
> > > >
> > > Oh, yes. It would be great to backport those 5 mentioned to 6.11.y.
> >
> > Why, are they bugfixes?
> >
> Yes. For performance, there are 5% impact with mprotect/madvise.

They're not bugfixes, they fix a performance regression. As far as I'm
aware, they do not fit the criteria for -stable inclusion.

But ofc Greg might know better :)

--=20
Pedro

