Return-Path: <stable+bounces-69453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1694C9563D9
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 08:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9BBB2100F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6A155741;
	Mon, 19 Aug 2024 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="PAXfImeh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFEA14AD0E
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050054; cv=none; b=gU5lj6vPjPsq+2MaqOlRzMIb0ko1eNwhy/c08d6lt1t2jrsYDSYUUzl5KwpDwMPqZKeS/QAgcABv487zet0umE39w8soLZkiMRIs6RPdumgPNWyjoLT2MfPF95np2kqI1xlN35PghrpkuhJtoWR9zePS762INkQnLoVKsRCSYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050054; c=relaxed/simple;
	bh=7wP86Da9Obl8V+FdIpHpFY6+BBI77NaHDM8n8YRt94Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mvhlvEW+V3nK4mGJjMq5c3P/IpIY4OBWAFBmT5sMPBGnD6d99zmnKPpa2cphb99E8xEx90MU5NAswIXZx+ymvzvMoYGH/eRbA7OlM1rsEiabo2Rr4X5iqVMFUu37FOYi8cPCt6QQRDtNBzqvYvVuBQbEHvBFLrFUl0Ml0PkFPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=PAXfImeh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa086b077so395582366b.0
        for <stable@vger.kernel.org>; Sun, 18 Aug 2024 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1724050050; x=1724654850; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LND9mIrFerHkVrQTnyq4VdOw05+VpKfEai3OB71/UB8=;
        b=PAXfImeh0XS+Fe2V0wvArF6PSsoSezl6pGuNIpp27vNIxQHpsThriQ2FJ0RIRYxZDo
         zFJEQFy9nZVqaBEoUHV6h+gQ3jHXIDZa9iPeAhY/NyEmqKj1YBeq2rGD1DB9bfjXV6Ie
         9Tppb3Kf3LAZqoZHKfxw0Ll7Qpsig77vFtMUFqjAFx1PVhcYIlpmD+EfNiVM1DGNFrqo
         sJPJu7USRuEEA1lMcUzkgMq2d1GU+8CQtnNRTU8XQzWMVTNm9IPgJknSmhteOpaIzCrq
         i2rJXDi1v1xoiId3yOk0zBmULOEtWjtX85IT463OlE0PlhN2yPSler1+7uBywTuIHAvz
         Kv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724050050; x=1724654850;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LND9mIrFerHkVrQTnyq4VdOw05+VpKfEai3OB71/UB8=;
        b=nUOzcqJPZLS9HbhqTkxFJHQ4VX26o+9AokZUnqTLDxoM47n/OVLzmuVq/lrn0IBpgj
         4AW8x3FcPwFH8p96C8/PyeIf1IPOMvwzroowiWYtIZSw/1sNJr3JlBABdavToJILcMs8
         tLl46pQy9AK5bj1hSyY4ScJSEkQtD7NBQSUMaxq0wom308ui4atK8SIqjCLr+pNHvmvn
         cdayBbgbYR6pzHegpEUgEILwepHTBMU87TzLdAPLM3mk+mKx8EoKJxxuvmnzjJ3BgUuu
         3FAbt+ENTIzJxRVLSndQ5hcnoOv5y3tNAaT4ZgvON2IDMnnF7NyadOllkGW4ScxE/v12
         rjAw==
X-Forwarded-Encrypted: i=1; AJvYcCVPGciN8qQHepCgiOD70B7tN0dKtA0E/IkLCLx/Zigy757FWfZnYqyYwyVBwuhxumkcwRKoIgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACoYCWqQzgIBO4GsY/Rly1eYC/kRmEsvqlOEziTyzN3ikLAcf
	iIXcE/9ZBgSEwFrpQa6GHOaWhwIrFbKdO3m7WLqDq0NBy4R/QrDfR8xPHG9UsPg=
X-Google-Smtp-Source: AGHT+IG/LOAv6VXcb2ahcaNnLPc8Zo+lzLm+8FzIpuANSmibKvOSrYbcPxeSEN4xbkWJ163zpJ8cMQ==
X-Received: by 2002:a17:906:f5a2:b0:a72:8d40:52b8 with SMTP id a640c23a62f3a-a83a9fb9491mr456337366b.3.1724050049983;
        Sun, 18 Aug 2024 23:47:29 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839344fdsm595276766b.100.2024.08.18.23.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 23:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Aug 2024 08:47:29 +0200
Message-Id: <D3JOQILHYKG7.1RRC5IF2RZJ4V@fairphone.com>
Cc: "Max Krummenacher" <max.krummenacher@toradex.com>,
 <stable@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: vt: conmakehash: cope with abs_srctree no longer
 in env
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Max Krummenacher" <max.oss.09@gmail.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240725132056.9151-1-max.oss.09@gmail.com>
 <D3I3BTOHN2RW.2DUYSKP3JRT5Z@fairphone.com>
 <CAEHkU3V9L4NKUkwr8Gyo2ZWEVJsjYTqPRduYrHoHyVtdEfFEVQ@mail.gmail.com>
In-Reply-To: <CAEHkU3V9L4NKUkwr8Gyo2ZWEVJsjYTqPRduYrHoHyVtdEfFEVQ@mail.gmail.com>

On Sat Aug 17, 2024 at 3:52 PM CEST, Max Krummenacher wrote:
> Hi Luca
>
> On Sat, Aug 17, 2024 at 11:48=E2=80=AFAM Luca Weiss <luca.weiss@fairphone=
.com> wrote:
> >
> > On Thu Jul 25, 2024 at 3:20 PM CEST, max.oss.09 wrote:
> > > From: Max Krummenacher <max.krummenacher@toradex.com>
> > >
> > > conmakehash uses getenv("abs_srctree") from the environment to strip
> > > the absolute path from the generated sources.
> > > However since commit e2bad142bb3d ("kbuild: unexport abs_srctree and
> > > abs_objtree") this environment variable no longer gets set.
> > > Instead use basename() to indicate the used file in a comment of the
> > > generated source file.
> > >
> > > Fixes: 3bd85c6c97b2 ("tty: vt: conmakehash: Don't mention the full pa=
th of the input in output")
> > > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > >
> > > ---
> > >
> > >  drivers/tty/vt/conmakehash.c | 20 +++++++-------------
> > >  1 file changed, 7 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/tty/vt/conmakehash.c b/drivers/tty/vt/conmakehas=
h.c
> > > index dc2177fec715..82d9db68b2ce 100644
> > > --- a/drivers/tty/vt/conmakehash.c
> > > +++ b/drivers/tty/vt/conmakehash.c
> > > @@ -11,6 +11,8 @@
> > >   * Copyright (C) 1995-1997 H. Peter Anvin
> > >   */
> > >
> > > +#include <libgen.h>
> > > +#include <linux/limits.h>
> >
> > Hi Max,
> >
> > Not sure this is the best place to ask but this <linux/limits.h> includ=
e
> > appears to rely on this file already being installed in /usr/include an=
d
> > is not taken from the Linux source tree that's being built.
> >
> > This mostly manifests in building Linux kernel e.g. in Alpine Linux
> > package build if 'linux-headers' package is not being explicitly
> > installed, failing with
> >
> >   drivers/tty/vt/conmakehash.c:15:10: fatal error: linux/limits.h: No s=
uch file or directory
> >      15 | #include <linux/limits.h>
> >         |          ^~~~~~~~~~~~~~~~
> >   compilation terminated.
> >
> > Apparently this is (understandably) also a problem when building on
> > macOS:
> > https://lore.kernel.org/all/20240807-macos-build-support-v1-11-4cd1ded8=
5694@samsung.com/
> >
> > I did try that linked patch a bit ago, but unfortunately didn't fix it
> > for the Alpine Linux build environment.
>
> This is a bug I introduced.
>
> Masahiro Yamada already fixed it with [1].

Great, I see it's also in torvalds' tree already, so I assume it'll hit
stable soon as well.

Thanks!

>
> Sorry about that.
>
> Regards
> Max
>
> [1] https://lore.kernel.org/all/20240809160853.1269466-1-masahiroy@kernel=
.org/
>
> >
> > Any ideas?
> >
> > Regards
> > Luca
> >
> >
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > >  #include <sysexits.h>
> > > @@ -76,8 +78,8 @@ static void addpair(int fp, int un)
> > >  int main(int argc, char *argv[])
> > >  {
> > >    FILE *ctbl;
> > > -  const char *tblname, *rel_tblname;
> > > -  const char *abs_srctree;
> > > +  const char *tblname;
> > > +  char base_tblname[PATH_MAX];
> > >    char buffer[65536];
> > >    int fontlen;
> > >    int i, nuni, nent;
> > > @@ -102,16 +104,6 @@ int main(int argc, char *argv[])
> > >       }
> > >      }
> > >
> > > -  abs_srctree =3D getenv("abs_srctree");
> > > -  if (abs_srctree && !strncmp(abs_srctree, tblname, strlen(abs_srctr=
ee)))
> > > -    {
> > > -      rel_tblname =3D tblname + strlen(abs_srctree);
> > > -      while (*rel_tblname =3D=3D '/')
> > > -     ++rel_tblname;
> > > -    }
> > > -  else
> > > -    rel_tblname =3D tblname;
> > > -
> > >    /* For now we assume the default font is always 256 characters. */
> > >    fontlen =3D 256;
> > >
> > > @@ -253,6 +245,8 @@ int main(int argc, char *argv[])
> > >    for ( i =3D 0 ; i < fontlen ; i++ )
> > >      nuni +=3D unicount[i];
> > >
> > > +  strncpy(base_tblname, tblname, PATH_MAX);
> > > +  base_tblname[PATH_MAX - 1] =3D 0;
> > >    printf("\
> > >  /*\n\
> > >   * Do not edit this file; it was automatically generated by\n\
> > > @@ -264,7 +258,7 @@ int main(int argc, char *argv[])
> > >  #include <linux/types.h>\n\
> > >  \n\
> > >  u8 dfont_unicount[%d] =3D \n\
> > > -{\n\t", rel_tblname, fontlen);
> > > +{\n\t", basename(base_tblname), fontlen);
> > >
> > >    for ( i =3D 0 ; i < fontlen ; i++ )
> > >      {
> >


