Return-Path: <stable+bounces-47667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0913A8D4156
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 00:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72EDDB23D4F
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 22:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2569516B74E;
	Wed, 29 May 2024 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XySo82ld"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D615B0E6
	for <stable@vger.kernel.org>; Wed, 29 May 2024 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021497; cv=none; b=KrLdR60roX4QF+IouCnXguv/p4oLumax9754ycE5vtLs/Tdg+b28ycJMjLO633w8S9toeICSFqygvJ8XNjTuUyr/WkQARYnuMy2z9cIRxodx7BlWwjnxKViVKdZQxLUFwEi9DtQfBF9G+skEzOVWQ3NRBiWkO71JbWB+/Es/k4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021497; c=relaxed/simple;
	bh=GRVvWMc6jEsyaMdaECyfkXQVMYCVUM8e/n0b8e82vu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+1nPnEAF1L/C8V8DEyaifRXwTIYjRiOOFuHnO2lgNA/se1gzWBUFruMZgO9U8RvH1FExxtKJmFye2tczlOxTTpCGo5ri7pQmfdhXNoi+icKF+jdbDGPY++l9caIctqYCcAreMo1mrajOsWDB7AOHGvWhDc73j6QnrSnc+YofKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XySo82ld; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so6520a12.0
        for <stable@vger.kernel.org>; Wed, 29 May 2024 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717021495; x=1717626295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmgn0iguBHzjec86+QBU6BresH5wuUbRjs/56VQrvfE=;
        b=XySo82ld6YzA2sGN2dcT+qMyA5GcXdOqhFszjCcS70HHUCFStDBRGm9Jni4h5byoig
         zCG/f3HXDrwrOEtPIs247qfRzN2zdaI/jPeCtrbWXTB1fDCxIU/Q/j/ocNfLQ5fXoi8l
         5fUBoZ6tQAAefBzDHxbWElRPqQl7xE8JTqyeHFg9gszjYwTA0pzzrNooKZoNpnZAVInJ
         ONECsCgQSYfBUsbXnJsqL9oPI/6KEdONE/QjS/mcGfFsfwJur3a2pLKr7vj1VEUtiwjX
         6G4YVAeJIHftRvZTMfx6a3l8YUEXeCjCgwmGKKj5iX9GTfYsRX8YEArfCjPBON3EVfm2
         e47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021495; x=1717626295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmgn0iguBHzjec86+QBU6BresH5wuUbRjs/56VQrvfE=;
        b=UjRX6GsoSKyRpoyrwqqLFhXfR4iPrQQq1Ov9WMMBM1pgcWox3dJC3rVL1jTwOeI4rY
         fqMRU2leTQ6srwVE+MGo6IR62rPo+YEAuDvGv4frg7iY5NdMPpT3xfE3S64G1NrgHduf
         vZk8Hh0ed1oE6uzpB5YPtEGG/8HigxXOU0JHqELV+Cc+WZsTvQ5/rxxOLbCJ0AslC8Sd
         tIEKXV8wucgpxK0ENUhqow2gI0H0KgfwXb2RxPAkV4tDNGcroVy6l8rvw+rSLdiKaib1
         CKQLcI2IlxLj7+c9mmtLKVzVtBoaedz8TUjC2FFoXjZ/COZDbHewn/lE3QzEMGLpmC2U
         JGFw==
X-Forwarded-Encrypted: i=1; AJvYcCWY572YP38KvGiwoQ3aY1x2twmrXMt4AhrQ5WCYeEJCVOp+ot/M6v0LYKRT3xxam1titsykWxsbjPER6hhhee1RidQ6scpz
X-Gm-Message-State: AOJu0Yyc3G/ooKBzEvX+4WCiLYKXUrwtVRUjCu2CMjjW5Xo3ufkWTNxS
	DgoUzaq/LxS+bYulP1CfxgFXQa/SrgqndhL/dQtDsRxHnqCqWqeMp0iIwVWMeKL/3siCfOmq11j
	FG3+WKKvOwOV+yRnNAUYHw6KjrRfJReUNUxCL
X-Google-Smtp-Source: AGHT+IHkkh9x06qFU9ZLKk1fSNy1UgCz5Aewkn3gIQT7QDAopstbEwZwp0LySpOiKlbZGOlCiquPRCB7g2nzucbt4so=
X-Received: by 2002:a05:6402:174d:b0:578:5f77:1e77 with SMTP id
 4fb4d7f45d1cf-57a1625924dmr72973a12.0.1717021494478; Wed, 29 May 2024
 15:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033933.135049-1-jeffxu@google.com> <20240524033933.135049-2-jeffxu@google.com>
 <79b3aa3e-bc70-410e-9646-0b6880a4a74b@app.fastmail.com> <CALmYWFu61FkbboWkXUSKBGmXeiNtBwrgfizS5kNvPMx4ByUqPQ@mail.gmail.com>
 <b8cGJnU5ofWgsiKD5z8RGlW-2ijs7IW9h4LUg1tzFBu3agFinCvdxuiSaUDG_DfVen2vCDNu-QbGfOR7DeARf4jsy3CNNTfzQGMX1HfqHdo=@protonmail.com>
In-Reply-To: <b8cGJnU5ofWgsiKD5z8RGlW-2ijs7IW9h4LUg1tzFBu3agFinCvdxuiSaUDG_DfVen2vCDNu-QbGfOR7DeARf4jsy3CNNTfzQGMX1HfqHdo=@protonmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 29 May 2024 15:24:16 -0700
Message-ID: <CALmYWFv+Tsqwv96oB4rTrJ7_ZC3CoNZFjmKFYKQgGZuceqZ6vg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
To: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc: David Rheinsberg <david@readahead.eu>, Jeff Xu <jeffxu@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, cyphar@cyphar.com, dmitry.torokhov@gmail.com, 
	Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, jorgelo@chromium.org, 
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:46=E2=80=AFPM Barnab=C3=A1s P=C5=91cze <pobrn@pro=
tonmail.com> wrote:
>
> Hi
>
>
> 2024. m=C3=A1jus 29., szerda 23:30 keltez=C3=A9ssel, Jeff Xu <jeffxu@goog=
le.com> =C3=ADrta:
>
> > Hi David and Barnab=C3=A1s
> >
> > On Fri, May 24, 2024 at 7:15=E2=80=AFAM David Rheinsberg <david@readahe=
ad.eu> wrote:
> > >
> > > Hi
> > >
> > > On Fri, May 24, 2024, at 5:39 AM, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@google.com>
> > > >
> > > > By default, memfd_create() creates a non-sealable MFD, unless the
> > > > MFD_ALLOW_SEALING flag is set.
> > > >
> > > > When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD crea=
ted
> > > > with that flag is sealable, even though MFD_ALLOW_SEALING is not se=
t.
> > > > This patch changes MFD_NOEXEC_SEAL to be non-sealable by default,
> > > > unless MFD_ALLOW_SEALING is explicitly set.
> > > >
> > > > This is a non-backward compatible change. However, as MFD_NOEXEC_SE=
AL
> > > > is new, we expect not many applications will rely on the nature of
> > > > MFD_NOEXEC_SEAL being sealable. In most cases, the application alre=
ady
> > > > sets MFD_ALLOW_SEALING if they need a sealable MFD.
> > >
> > > This does not really reflect the effort that went into this. Shouldn'=
t this be something along the lines of:
> > >
> > >     This is a non-backward compatible change. However, MFD_NOEXEC_SEA=
L
> > >     was only recently introduced and a codesearch revealed no breakin=
g
> > >     users apart from dbus-broker unit-tests (which have a patch pendi=
ng
> > >     and explicitly support this change).
> > >
> > Actually, I think we might need to hold on to this change. With debian
> > code search, I found more codes that already use MFD_NOEXEC_SEAL
> > without MFD_ALLOW_SEALING. e.g. systemd [1], [2] [3]
>
> Yes, I have looked at those as well, and as far as I could tell,
> they are not affected. Have I missed something?
>
In the example, the MFD was created then passed into somewhere else
(safe_fork_full, open_serialization_fd, etc.), the scope and usage of
mfd isn't that clear to me, you might have checked all the user cases.
In addition, MFD_NOEXEC_SEAL  exists in libc and rust and go lib.  I
don't know if debian code search is sufficient to cover enough apps .
There is a certain risk.

Fundamentally, I'm not convinced that making MFD default-non-sealable
has  meaningful benefit, especially when MFD_NOEXEC_SEAL is new.


>
> Regards,
> Barnab=C3=A1s
>
>
> >
> > I'm not sure if this  will break  more applications not-knowingly that
> > have started relying on MFD_NOEXEC_SEAL being sealable. The feature
> > has been out for more than a year.
> >
> > Would you consider my augments in [4] to make MFD to be sealable by def=
ault ?
> >
> > At this moment, I'm willing to add a document to clarify that
> > MFD_NOEXEC_SEAL is sealable by default, and that an app that needs
> > non-sealable MFD can  set  SEAL_SEAL.  Because both MFD_NOEXEC_SEAL
> > and vm.memfd_noexec are new,  I don't think it breaks the existing
> > ABI, and vm.memfd_noexec=3D0 is there for backward compatibility
> > reasons. Besides, I honestly think there is little reason that MFD
> > needs to be non-sealable by default.  There might be few rare cases,
> > but the majority of apps don't need that.  On the flip side, the fact
> > that MFD is set up to be sealable by default is a nice bonus for an
> > app - it makes it easier for apps to use the sealing feature.
> >
> > What do you think ?
> >
> > Thanks
> > -Jeff
> >
> > [1] https://codesearch.debian.net/search?q=3DMFD_NOEXEC_SEAL
> > [2] https://codesearch.debian.net/show?file=3Dsystemd_256~rc3-5%2Fsrc%2=
Fhome%2Fhomed-home.c&line=3D1274
> > [3] https://sources.debian.org/src/elogind/255.5-1debian1/src/shared/se=
rialize.c/?hl=3D558#L558
> > [4] https://lore.kernel.org/lkml/CALmYWFuPBEM2DE97mQvB2eEgSO9Dvt=3DuO9O=
ewMhGfhGCY66Hbw@mail.gmail.com/
> >
> >
> > > > Additionally, this enhances the useability of  pid namespace sysctl
> > > > vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel wil=
l
> > > > add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
> > > > MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables the MF=
D
> > > > to be sealable. This means, any application that does not desire th=
is
> > > > behavior will be unable to utilize vm.memfd_noexec =3D 1 or 2 to
> > > > migrate/enforce non-executable MFD. This adjustment ensures that
> > > > applications can anticipate that the sealable characteristic will
> > > > remain unmodified by vm.memfd_noexec.
> > > >
> > > > This patch was initially developed by Barnab=C3=A1s P=C5=91cze, and=
 Barnab=C3=A1s
> > > > used Debian Code Search and GitHub to try to find potential breakag=
es
> > > > and could only find a single one. Dbus-broker's memfd_create() wrap=
per
> > > > is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tries t=
o
> > > > work around it [1]. This workaround will break. Luckily, this only
> > > > affects the test suite, it does not affect
> > > > the normal operations of dbus-broker. There is a PR with a fix[2]. =
In
> > > > addition, David Rheinsberg also raised similar fix in [3]
> > > >
> > > > [1]:
> > > > https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc4=
6f267d4a8784cb/src/util/misc.c#L114
> > > > [2]: https://github.com/bus1/dbus-broker/pull/366
> > > > [3]:
> > > > https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahea=
d.eu/
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC"=
)
> > > > Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> > > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > > > Reviewed-by: David Rheinsberg <david@readahead.eu>
> > >
> > > Looks good! Thanks!
> > > David
> >

