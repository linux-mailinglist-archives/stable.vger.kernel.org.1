Return-Path: <stable+bounces-47663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1914B8D4054
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 23:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303641C21DA4
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C5E16D4E7;
	Wed, 29 May 2024 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqMn3XO7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24E15B576
	for <stable@vger.kernel.org>; Wed, 29 May 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717018284; cv=none; b=gMm28+Z5vCZS4l4fxtV6s6GcbXXrMF/729j+/ZpAuWksv92+3f7G60bV7Vprhm6z/mRhupv1UKXqU2OFulx0mYVgWUE/8SmLFce0zAkFICKPKeN/BfbWwveXAckj2e/7ytjBzJ3S1tR0D968jUtPHxiyECY3GJhdpZAPmrcOYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717018284; c=relaxed/simple;
	bh=W05mNXb0UrG3pIeEAflXGkFgca+10GQzjYeUMQhZlUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWpU/22O/gigqHwE2wror/02G2/44svKoiDcf1lWthl9qK07I6b2ede4Ez1Z+/QcQW+xP9HEg010Xn+wYnriQZYqzfZBTwCEXi4c0f/UobY3sZFqeegIHzlF7q78jphTkfYYKXjj01kzS8oYJ1TULTiZiJ2AARHi1Q7/4lHtf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqMn3XO7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso3992a12.0
        for <stable@vger.kernel.org>; Wed, 29 May 2024 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717018281; x=1717623081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLiA1NhyieWQfcXd3ARNdY+JpVH2itsFMZIhqt+3Mg4=;
        b=iqMn3XO7KUt9usB7I6kjcLjHC4Ct0kCh4a0F4Iu8IaG3ujUJgtRn42nJJkX+gOlYNu
         J4F/m4wnGIqfV5SFNuem21NiWZaiTv5dSj1DcZrmuAs91XhzWYa2zkwEkZjYe48kq99C
         KUp93M6Idsd3VKMKpNbGxkqnvBPdDmX3F49aBpRw1LZEryMSEIADu2opNDGm+4AEYpSK
         XeHB3dEFdwz19F7qA9cucDQNBxF+yAip0dynRNdfycy326L750GRkUSrPbd3C/z5Uo7D
         O9R9DDwNQh/uSAYxf3ZhLyepY2HQzV88EFJYzPmHXlWSxOSfVQwSXH8bNYGK4KXzfdoM
         RJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717018281; x=1717623081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLiA1NhyieWQfcXd3ARNdY+JpVH2itsFMZIhqt+3Mg4=;
        b=hNGCIk89/zOTdkE6zlDhJ1TwweqGp0fLXCMk9M9hOUoUDuOQXC9OfHydAwczOkfBk4
         E8PhdmPlIUL949GWAdH2QbtkCMBWcmMsVuUW3vBS6RlJWKIiq4p2NnfemP4tgYMyh/8m
         GAPV82gdL4fT75e+K3TMBths8HQjOaR2QyvuhU6lhLFdImbbVEBo5znu84YAdIaMif0u
         4FZmJMeYWlmuMHX0df52YnUofta7F0OZnYPUgwFl/agHeHsxt0SRuj5CfvVisy6h6RKv
         OfyR/HBbpaozhNfS+6bzHxw+BDB8f/+oP1G2snT+1olZS4iCSfd1PZykULs/7PPtkE0p
         XJng==
X-Forwarded-Encrypted: i=1; AJvYcCVQN52b+jeeot1QQQ486diSSS4UlKCecspEb/pATr1DygOq5tCn5K4g9xgoeVcp7k7Cj0A10CI07i1mbdoC8DorNboccTAg
X-Gm-Message-State: AOJu0YwUd3FZpDYIxGUvXT+2D9153hI3prEws2SCUew+B9WOFaARaRBy
	05nQ5olaQ3AAh+SnamXsPwkT7SiZqE0xChPxfpmbaRZAsoqi9unREYx7jnQmoooWYYnkepEfvJz
	g6X+60xtYtu+SUVWChg6qkfIjg/U0tGnoG/St
X-Google-Smtp-Source: AGHT+IE+x8lFbKLlWU1Fq0CgkMn615w4ys1te7GNt5dz/IZuvIoJg4ejLZAvtFf70Zb8LZLZNTajFROLwUn0R5dzS2k=
X-Received: by 2002:aa7:c2ce:0:b0:576:b1a9:2960 with SMTP id
 4fb4d7f45d1cf-57a18c8ab10mr22904a12.5.1717018280000; Wed, 29 May 2024
 14:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033933.135049-1-jeffxu@google.com> <20240524033933.135049-2-jeffxu@google.com>
 <79b3aa3e-bc70-410e-9646-0b6880a4a74b@app.fastmail.com>
In-Reply-To: <79b3aa3e-bc70-410e-9646-0b6880a4a74b@app.fastmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 29 May 2024 14:30:41 -0700
Message-ID: <CALmYWFu61FkbboWkXUSKBGmXeiNtBwrgfizS5kNvPMx4ByUqPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
To: David Rheinsberg <david@readahead.eu>, =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc: Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, cyphar@cyphar.com, 
	dmitry.torokhov@gmail.com, Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, 
	jorgelo@chromium.org, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David and Barnab=C3=A1s

On Fri, May 24, 2024 at 7:15=E2=80=AFAM David Rheinsberg <david@readahead.e=
u> wrote:
>
> Hi
>
> On Fri, May 24, 2024, at 5:39 AM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > By default, memfd_create() creates a non-sealable MFD, unless the
> > MFD_ALLOW_SEALING flag is set.
> >
> > When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD created
> > with that flag is sealable, even though MFD_ALLOW_SEALING is not set.
> > This patch changes MFD_NOEXEC_SEAL to be non-sealable by default,
> > unless MFD_ALLOW_SEALING is explicitly set.
> >
> > This is a non-backward compatible change. However, as MFD_NOEXEC_SEAL
> > is new, we expect not many applications will rely on the nature of
> > MFD_NOEXEC_SEAL being sealable. In most cases, the application already
> > sets MFD_ALLOW_SEALING if they need a sealable MFD.
>
> This does not really reflect the effort that went into this. Shouldn't th=
is be something along the lines of:
>
>     This is a non-backward compatible change. However, MFD_NOEXEC_SEAL
>     was only recently introduced and a codesearch revealed no breaking
>     users apart from dbus-broker unit-tests (which have a patch pending
>     and explicitly support this change).
>
Actually, I think we might need to hold on to this change. With debian
code search, I found more codes that already use MFD_NOEXEC_SEAL
without MFD_ALLOW_SEALING. e.g. systemd [1], [2] [3]

I'm not sure if this  will break  more applications not-knowingly that
have started relying on MFD_NOEXEC_SEAL being sealable. The feature
has been out for more than a year.

Would you consider my augments in [4] to make MFD to be sealable by default=
 ?

At this moment, I'm willing to add a document to clarify that
MFD_NOEXEC_SEAL is sealable by default, and that an app that needs
non-sealable MFD can  set  SEAL_SEAL.  Because both MFD_NOEXEC_SEAL
and vm.memfd_noexec are new,  I don't think it breaks the existing
ABI, and vm.memfd_noexec=3D0 is there for backward compatibility
reasons. Besides, I honestly think there is little reason that MFD
needs to be non-sealable by default.  There might be few rare cases,
but the majority of apps don't need that.  On the flip side, the fact
that MFD is set up to be sealable by default is a nice bonus for an
app - it makes it easier for apps to use the sealing feature.

What do you think ?

Thanks
-Jeff

[1] https://codesearch.debian.net/search?q=3DMFD_NOEXEC_SEAL
[2] https://codesearch.debian.net/show?file=3Dsystemd_256~rc3-5%2Fsrc%2Fhom=
e%2Fhomed-home.c&line=3D1274
[3] https://sources.debian.org/src/elogind/255.5-1debian1/src/shared/serial=
ize.c/?hl=3D558#L558
[4] https://lore.kernel.org/lkml/CALmYWFuPBEM2DE97mQvB2eEgSO9Dvt=3DuO9OewMh=
GfhGCY66Hbw@mail.gmail.com/


> > Additionally, this enhances the useability of  pid namespace sysctl
> > vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel will
> > add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
> > MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables the MFD
> > to be sealable. This means, any application that does not desire this
> > behavior will be unable to utilize vm.memfd_noexec =3D 1 or 2 to
> > migrate/enforce non-executable MFD. This adjustment ensures that
> > applications can anticipate that the sealable characteristic will
> > remain unmodified by vm.memfd_noexec.
> >
> > This patch was initially developed by Barnab=C3=A1s P=C5=91cze, and Bar=
nab=C3=A1s
> > used Debian Code Search and GitHub to try to find potential breakages
> > and could only find a single one. Dbus-broker's memfd_create() wrapper
> > is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tries to
> > work around it [1]. This workaround will break. Luckily, this only
> > affects the test suite, it does not affect
> > the normal operations of dbus-broker. There is a PR with a fix[2]. In
> > addition, David Rheinsberg also raised similar fix in [3]
> >
> > [1]:
> > https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46f26=
7d4a8784cb/src/util/misc.c#L114
> > [2]: https://github.com/bus1/dbus-broker/pull/366
> > [3]:
> > https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.eu=
/
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
> > Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > Reviewed-by: David Rheinsberg <david@readahead.eu>
>
> Looks good! Thanks!
> David

