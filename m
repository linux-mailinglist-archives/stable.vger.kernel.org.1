Return-Path: <stable+bounces-69388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE0955831
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 15:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3F31F21AAB
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046D14EC4E;
	Sat, 17 Aug 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V676TsH3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886FF507;
	Sat, 17 Aug 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723902748; cv=none; b=g+UXTmiP+GRT7kKZV5znit+EJnVIkb741hUeqF91rwiqo5rGY8Yw+Ie0o3t6mDgoJpsq5cArKU9MeKTngOaymK6OEgFxzOul/lXHPqX0FFuh8MLOWOPILrImaFgUuo+D5NdLygI7JcchAz7YGyMTVtYGBpURbUVDry1gAuHbzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723902748; c=relaxed/simple;
	bh=10ShYPpgkaroFS2ksMKDMWdNDO8MC7xsOob74hArJYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCN4i33IF6wfKm5hob6TsCrJ8Q7uV2Jlvblwe5m5WyLRq76uG30Qv8qh+Wl0EFNwCGli0IxApIBbt2J8Bw1lCE9VTdqqkLdqQjyOV3RJcf9RKpvHWKCpd7VP6lBaN+yPUm2Jo8zacLsesaYa8vBsJi9gWrK3vIFhXCQgTQkWwSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V676TsH3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso14826895e9.1;
        Sat, 17 Aug 2024 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723902745; x=1724507545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhF0RYx6ynDaRd0C4Ob0aLdco1kIfELnk5gy0xZdEL8=;
        b=V676TsH339LmUaBzvUIwJkj4JKT99d/+zeBszATxihX46mM0P6Qzj0EixqUIwwS8aX
         z+OblT8QUChUirVpE/vKmrOJPxZlVHDsnWZj7ibOtdoL26rR1FXN8tnRsjIqZuvIsuIj
         pg69SPCCWjD/vW6UrI1fLltC7CKXXeKFdniiKQFJC6nMGzEwxVLd7IRplui+5CtUbcMi
         cfHR3CY0QV1eCtpy1FuDGkOUfL3ndvADMrFZDyZtfblHUuZvLOyl4nqcUNuCRZgD7uqm
         qwb4+NgUuQZf14weFQG0T9hHiYfQiMQ/nWYUKB3Q+ilIeg6fep7LxwKfbPodEsi+n5yY
         Uutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723902745; x=1724507545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhF0RYx6ynDaRd0C4Ob0aLdco1kIfELnk5gy0xZdEL8=;
        b=eyzrNFeUKmdDVLjl8genJKaSriVzUm/Xy/48jPRzdkSEw2TUeOAW5yyxu3Kwn9wHBU
         PoN/cBZfYFkceMURM8Ips84xve6UR4ewXSelxIw7Vn2ROYiFYQowXNaPaHbyi+RF7Mga
         UcKerMVgGnPxRDJ2b0s+QOXMxlLM0C12Us7nE0MZmgnbTjkn3Tfo5wOJUW2tADE4a9yr
         zEojMiFZiPz4OB42FWL1U83oKkURMmDwNAa8lQQHVeJS2rMPIEWb3mypZMLJdIxBalw1
         /y9/Jy57K5hbOeMnyXyk7beSiTvZf/dUMiloP8vwUFOU6k+y3w0mGedSnp2PJYhWP2Yy
         a27w==
X-Forwarded-Encrypted: i=1; AJvYcCVNE3XFwi2aWJjg0LY0zB8qDZ0c3KVOpFC4GWGvmyn9MLKZKMZrYM4aV47dgVVnanU6pjhhpAGriAqeHEWCrpqC56WsZAGM4pUbKuAQPTpqWYgLGEMZNFlUSbDnadAhgSnkXIA06eDZrVsspRXGzNUc/gg4mFlis9x/gdaZFdek4gNZ
X-Gm-Message-State: AOJu0YySD+nrkCJ5xTmqmmep2P9M0y2R6h5c4p5REEoE6isLlJRzRt8v
	n9xcjsRYd2sc6sNWpCItegTGJ/f8mKtgBfb7jVJAvoRoyXy3/ZA9c602zpYnakopYuzAUAnDrnj
	dee4GWJCxjszb5z0+1AO3TPwnldg=
X-Google-Smtp-Source: AGHT+IG2Dte1tcw6sJPWDiyzzIAPURygmYu25hnF/KjN1rpvyHQwHIMX/6EjVWe/64zBi5ru4A7hDqqvSh0hlds/kyM=
X-Received: by 2002:a05:600c:1808:b0:424:71f7:77f2 with SMTP id
 5b1f17b1804b1-429e6f61d47mr59981775e9.16.1723902744330; Sat, 17 Aug 2024
 06:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725132056.9151-1-max.oss.09@gmail.com> <D3I3BTOHN2RW.2DUYSKP3JRT5Z@fairphone.com>
In-Reply-To: <D3I3BTOHN2RW.2DUYSKP3JRT5Z@fairphone.com>
From: Max Krummenacher <max.oss.09@gmail.com>
Date: Sat, 17 Aug 2024 15:52:13 +0200
Message-ID: <CAEHkU3V9L4NKUkwr8Gyo2ZWEVJsjYTqPRduYrHoHyVtdEfFEVQ@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: conmakehash: cope with abs_srctree no longer in env
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca

On Sat, Aug 17, 2024 at 11:48=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.c=
om> wrote:
>
> On Thu Jul 25, 2024 at 3:20 PM CEST, max.oss.09 wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> >
> > conmakehash uses getenv("abs_srctree") from the environment to strip
> > the absolute path from the generated sources.
> > However since commit e2bad142bb3d ("kbuild: unexport abs_srctree and
> > abs_objtree") this environment variable no longer gets set.
> > Instead use basename() to indicate the used file in a comment of the
> > generated source file.
> >
> > Fixes: 3bd85c6c97b2 ("tty: vt: conmakehash: Don't mention the full path=
 of the input in output")
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> >
> > ---
> >
> >  drivers/tty/vt/conmakehash.c | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/tty/vt/conmakehash.c b/drivers/tty/vt/conmakehash.=
c
> > index dc2177fec715..82d9db68b2ce 100644
> > --- a/drivers/tty/vt/conmakehash.c
> > +++ b/drivers/tty/vt/conmakehash.c
> > @@ -11,6 +11,8 @@
> >   * Copyright (C) 1995-1997 H. Peter Anvin
> >   */
> >
> > +#include <libgen.h>
> > +#include <linux/limits.h>
>
> Hi Max,
>
> Not sure this is the best place to ask but this <linux/limits.h> include
> appears to rely on this file already being installed in /usr/include and
> is not taken from the Linux source tree that's being built.
>
> This mostly manifests in building Linux kernel e.g. in Alpine Linux
> package build if 'linux-headers' package is not being explicitly
> installed, failing with
>
>   drivers/tty/vt/conmakehash.c:15:10: fatal error: linux/limits.h: No suc=
h file or directory
>      15 | #include <linux/limits.h>
>         |          ^~~~~~~~~~~~~~~~
>   compilation terminated.
>
> Apparently this is (understandably) also a problem when building on
> macOS:
> https://lore.kernel.org/all/20240807-macos-build-support-v1-11-4cd1ded856=
94@samsung.com/
>
> I did try that linked patch a bit ago, but unfortunately didn't fix it
> for the Alpine Linux build environment.

This is a bug I introduced.

Masahiro Yamada already fixed it with [1].

Sorry about that.

Regards
Max

[1] https://lore.kernel.org/all/20240809160853.1269466-1-masahiroy@kernel.o=
rg/

>
> Any ideas?
>
> Regards
> Luca
>
>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <sysexits.h>
> > @@ -76,8 +78,8 @@ static void addpair(int fp, int un)
> >  int main(int argc, char *argv[])
> >  {
> >    FILE *ctbl;
> > -  const char *tblname, *rel_tblname;
> > -  const char *abs_srctree;
> > +  const char *tblname;
> > +  char base_tblname[PATH_MAX];
> >    char buffer[65536];
> >    int fontlen;
> >    int i, nuni, nent;
> > @@ -102,16 +104,6 @@ int main(int argc, char *argv[])
> >       }
> >      }
> >
> > -  abs_srctree =3D getenv("abs_srctree");
> > -  if (abs_srctree && !strncmp(abs_srctree, tblname, strlen(abs_srctree=
)))
> > -    {
> > -      rel_tblname =3D tblname + strlen(abs_srctree);
> > -      while (*rel_tblname =3D=3D '/')
> > -     ++rel_tblname;
> > -    }
> > -  else
> > -    rel_tblname =3D tblname;
> > -
> >    /* For now we assume the default font is always 256 characters. */
> >    fontlen =3D 256;
> >
> > @@ -253,6 +245,8 @@ int main(int argc, char *argv[])
> >    for ( i =3D 0 ; i < fontlen ; i++ )
> >      nuni +=3D unicount[i];
> >
> > +  strncpy(base_tblname, tblname, PATH_MAX);
> > +  base_tblname[PATH_MAX - 1] =3D 0;
> >    printf("\
> >  /*\n\
> >   * Do not edit this file; it was automatically generated by\n\
> > @@ -264,7 +258,7 @@ int main(int argc, char *argv[])
> >  #include <linux/types.h>\n\
> >  \n\
> >  u8 dfont_unicount[%d] =3D \n\
> > -{\n\t", rel_tblname, fontlen);
> > +{\n\t", basename(base_tblname), fontlen);
> >
> >    for ( i =3D 0 ; i < fontlen ; i++ )
> >      {
>

