Return-Path: <stable+bounces-58161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69192904D
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 05:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2BE1C21064
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 03:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BEBE556;
	Sat,  6 Jul 2024 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGaLa2cQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772717E9
	for <stable@vger.kernel.org>; Sat,  6 Jul 2024 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720236253; cv=none; b=gkrSQKPJY+s4iaOAUeKnEpLnZO91y7UwIgxrhooEevJTUY5l+ssKG0O/i2sejDGLHw4THO4OczRQQnLBdzvgNd6Strw8h+0Jz9dW73H6XDaOk87u1KAZEO6aFc8GlvlI0zBPkOMAkz1+o60WQMnFIvZNv+e5JP1Nfw2iN6INRmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720236253; c=relaxed/simple;
	bh=Zf7fegEOz88S+uefNQgGk7kN64iUyK0nqei1SbhANDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lic2oFRjqX4fUJvTmQAXDLIwCZwPuHcf/BDtWIro6kM3YuFqXDXJUFCFstskyz1XGwJrTDfu8/BPlTSYR/z2fFwMl5Nc4kmQmzUYXhOLMZ73SnqtWjormIgBE5MkJUkdJHkv6HAvietAf+nZkD2/JeqU743MBU45slNweEeJPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGaLa2cQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso26779a12.0
        for <stable@vger.kernel.org>; Fri, 05 Jul 2024 20:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720236250; x=1720841050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeOWn8Dcpi/0Zne7XKezGHMzmpPhwxsGnD8ugnUza50=;
        b=BGaLa2cQQFmM0AaO8KvAhvMYAmEgh4weii2RHxAkxKZCO/nia1S1NXm2b6Y+YP0dqO
         bNTwO8aOpWswJf4ZRWgNur5rUUKavfJizyHjQbbK6UBm7AVzlFmbKICyFyYgUP6Evlz2
         EVebT93LKbIUvPPQe4cPekxcdFtRaECUNz/BL1NP6ESKCBn+dBC5cM/TTpprpVo+js9X
         U0v6rHj1FOuWFkaPDhWOi4lM0ZF1IjvOIj9COqSsiuN8E5jOKGhZeags2/dnYtUGgf0W
         rdNcBdLd43+PyA1LhGOkuOUT00Fkz4BTBluGWAVzY75vGzAaV5oBnpUiMoACtv6whMkZ
         rdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720236250; x=1720841050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeOWn8Dcpi/0Zne7XKezGHMzmpPhwxsGnD8ugnUza50=;
        b=sjhezXvV9l/0H1xjnBsmmg6lkHP2O91MCoSRqEG8oZvA8qhGYUqJJHiY3ovgVa0uv9
         Pewtc0UAVnKiVdqPIzGeikjY2wHExwixgle7P+C7RM8x734a/KIoba8sYEP9sYXw7YeI
         Wx35AGyMDeLYYLB9bbbkfbcmfcsUeGDyNq3SZTckzWmwaDhxQzTX/Vw7yVogrLDae0f7
         46RO90e7V0i2My8+oM/J9umTY62/Y3I09T2nGotivbh1mkLHEpQFuL8dNBGSuCHIam8h
         4rYqwkuV9PEnWVU7EyC1zRW9YlDjtEIwd/CcYDXqC0XiUDdUG9mNXlFsuHOJ8JHxW+q3
         wvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaFlhNFoXRBCPD9bfziE5YSrNJszj6hYsjTWTF1MkECESm5vMGeix1MvzNjyCLiYIFBtek342WEZM0ziPJQyRcnygGrxLM
X-Gm-Message-State: AOJu0YwBMLHA1/3FtILTet6VKBVOnIG9ugoRwPtsa2OfvPbccsLzFdpD
	CCD53fAM8InI6qOG1QL5e/GMI7iuDn71Fxb7FVxCfn0ASmkPZFBs8sGhJDCbcumILlGsAPPeMzC
	6N8G0w6MQRLec2MnZilTM88PaGtrckzt1HXJ/
X-Google-Smtp-Source: AGHT+IExJJ+2hSaxJtRHZGJ4Ox4OzW4oFndkiki9VhxYJFTQsxkQqN4Vpb3uXzUPWyQhWCVip8yKpWFGS+CMtG1GfTA=
X-Received: by 2002:a50:8ad3:0:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-58e00933a13mr316161a12.2.1720236249500; Fri, 05 Jul 2024
 20:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704-update-ld-version-for-new-lld-ver-str-v1-1-91bccc020a93@kernel.org>
 <CAFP8O3JUgH-tBJtqO-QS0HmO4mrFBE6Dz+tnrBcse=gw_Q_4vQ@mail.gmail.com> <20240705160007.GA875035@thelio-3990X>
In-Reply-To: <20240705160007.GA875035@thelio-3990X>
From: Fangrui Song <maskray@google.com>
Date: Fri, 5 Jul 2024 20:23:58 -0700
Message-ID: <CAFP8O3+X4iT1OPoMdTTa_Y1WKjK4f6ownE0tBYZD_a-ngSNufg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Update ld-version.sh for change in LLD version output
To: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 9:00=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Thu, Jul 04, 2024 at 02:23:46PM -0700, Fangrui Song wrote:
> > On Thu, Jul 4, 2024 at 9:19=E2=80=AFAM Nathan Chancellor <nathan@kernel=
.org> wrote:
> > >
> > > After [1] in upstream LLVM, ld.lld's version output is slightly
> > > different when the cmake configuration option LLVM_APPEND_VC_REV is
> > > disabled.
> > >
> > > Before:
> > >
> > >   Debian LLD 19.0.0 (compatible with GNU linkers)
> > >
> > > After:
> > >
> > >   Debian LLD 19.0.0, compatible with GNU linkers
> > >
> > > This results in ld-version.sh failing with
> > >
> > >   scripts/ld-version.sh: 19: arithmetic expression: expecting EOF: "1=
0000 * 19 + 100 * 0 + 0,"
> > >
> > > because the trailing comma is included in the patch level part of the
> > > expression. Remove the trailing comma when assigning the version
> > > variable in the LLD block to resolve the error, resulting in the prop=
er
> > > output:
> > >
> > >   LLD 190000
> > >
> > > With LLVM_APPEND_VC_REV enabled, there is no issue with the new outpu=
t
> > > because it is treated the same as the prior LLVM_APPEND_VC_REV=3DOFF
> > > version string was.
> > >
> > >   ClangBuiltLinux LLD 19.0.0 (https://github.com/llvm/llvm-project a3=
c5c83273358a85a4e02f5f76379b1a276e7714), compatible with GNU linkers
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 02aff8592204 ("kbuild: check the minimum linker version in Kco=
nfig")
> > > Link: https://github.com/llvm/llvm-project/commit/0f9fbbb63cfcd206944=
1aa2ebef622c9716f8dbb [1]
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > >  scripts/ld-version.sh | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
> > > index a78b804b680c..f2f425322524 100755
> > > --- a/scripts/ld-version.sh
> > > +++ b/scripts/ld-version.sh
> > > @@ -47,7 +47,9 @@ else
> > >         done
> > >
> > >         if [ "$1" =3D LLD ]; then
> > > -               version=3D$2
> > > +               # LLD after https://github.com/llvm/llvm-project/comm=
it/0f9fbbb63cfcd2069441aa2ebef622c9716f8dbb
> > > +               # may have a trailing comma on the patch version with=
 LLVM_APPEND_VC_REV=3Doff.
> > > +               version=3D${2%,}
> > >                 min_version=3D$($min_tool_version llvm)
> > >                 name=3DLLD
> > >                 disp_name=3DLLD
> > >
> > > ---
> > > base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
> > > change-id: 20240704-update-ld-version-for-new-lld-ver-str-b7a4afbbd5f=
1
> > >
> > > Best regards,
> > > --
> > > Nathan Chancellor <nathan@kernel.org>
> > >
> >
> > Thanks for catching the issue.
> > If we want to minimize the number of special cases, perhaps we can
> > adjust `version=3D${version%-*}` below to
> >
> > version=3D${version%%[^0-9.]*}
>
> Thanks for the suggestion! I think this wants to be
>
>   version=3D${version%%[!0-9.]*}
>
> because of "If an open bracket introduces a bracket expression as in XBD
> RE Bracket Expression, except that the <exclamation-mark> character
> ('!') shall replace the <circumflex> character ('^') in its role in a
> non-matching list in the regular expression notation, it shall introduce
> a pattern bracket expression." from the link that you have below.

Yes! ! should be used instead.

> That does work for me with all the different linker versions that I can
> easily access (Arch, Debian, Fedora) along with my own self built
> toolchains, so it seems like it should be pretty robust.
>
> Masahiro, would you be okay with me sending a v2 with that change or do
> you foresee any issues where it would not be sufficient? I would
> probably change the comment to:
>
>   # There may be something after the version, such as a distribution's
>   # package release number (2.34-4.fc32) or a comma (like LLD adds
>   # before the "compatible with GNU linkers" string), so remove anything
>   # that is not a number or a period.

The v2 change LGTM :)

Reviewed-by: Fangrui Song <maskray@google.com>

> > (POSIX shell doc:
> > https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.ht=
ml#:~:text=3DRemove%20Largest)
> >
> > ${version%%[^0-9.]*} is a simpler form than what glibc uses:
> >
> >   "LLD"*)
> >   # Accept LLD 13.0.0 or higher
> >     AC_CHECK_PROG_VER(LD, $LD, --version,
> >                     [LLD.* \([0-9][0-9]*\.[0-9.]*\)],
> >                     [1[3-9].*|[2-9][0-9].*],
>
> Cheers,
> Nathan
>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

