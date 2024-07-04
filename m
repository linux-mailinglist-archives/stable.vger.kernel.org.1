Return-Path: <stable+bounces-58097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC66927E80
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 23:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F32284CCA
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 21:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0407142E86;
	Thu,  4 Jul 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uts4MYtj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495013D246
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720128241; cv=none; b=Zc8WeohmpiD2VHYj6cXFJUE69KZUDDIXNih2/9iTpNM3iUdTypZi1lHWme8amO9OsySt+sMsAPtU3FGW/Unr6m+f9US8thla2bIUJLAKJHoUbQZyskZhJZ5AfFj5L8/iMZc6WjPlM8EXmIj/l+ceKP/FKbzu7TFQiYZfRuEzWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720128241; c=relaxed/simple;
	bh=WkQita1UbMfMen1gzqw2QW7P3OKiOs39bLWHgZY5IA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN3R3HHwxqIH0tGux1L8aC8s+FeKyOgk0oHNPikNfi2ljrpWe8JlKxNjLGxXWIYKqvJlrMcQSCZRGrWpbR5Br3TYPWqKeFMsffeh5jDm3i5kTPa5lJ1LGTM8Vl+GYqG9pgTZUKSRm6BpRQdeX98HDrtnCZLMrJ7coQvcbwAAm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uts4MYtj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so12861a12.1
        for <stable@vger.kernel.org>; Thu, 04 Jul 2024 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720128238; x=1720733038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZUXkSX9WN+AQbdLcHROy2ZT3v7SVR09OPnTWoMgUyo=;
        b=uts4MYtjC7d5FzZMCxiqJi1ecwNjdUyo0Y1YCnDocw8p6frbpdgGxRHMDmy14TQX4c
         xhKU/BySVrCj9ZsW+9LQ9XOplOVMqcLhZetj4m3gc5OtK14IwV8kvubXlqLucaqC3hvR
         MGbWj4qG/pyKuz2/gYr5SgHYWSdYAR3c1mbFLSVN1lYR+qAtSdXADHRZ+WHD/Q3cpTSP
         wdJE0Xng0z1couHV/Rb+PTG6VkvN1QHDTjOJ9IEDdAH+4dNGZl1tG8o8bC5oq+PWg1W8
         VVQAAsdfY82Qu3qt8byKG+EerD2vagxlRnLkwW0rbGgqWrtcp+xZaBOVou4zARlykcDB
         TCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720128238; x=1720733038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZUXkSX9WN+AQbdLcHROy2ZT3v7SVR09OPnTWoMgUyo=;
        b=P/ZW/uZKdlqPCbpXDQiaMnFHZZaknzN++mdO72HQvvOGD50g7GvMc8GCWgi1Ryc4Cq
         6TRFnjK3MDKu1nR57CNpcw18JOpko1empOh8b7UtaFwSoOxlF/gl8Ik9xcBi4FePRlPR
         NuirPP4dtFZQ8DZ7XRRVm3pbV9pazOZau/KUI/491PwaaxXRQqNssUsZ7+wMv5M6uJU8
         EsTuhJ0QDbUCGRsJ4sSMV+x1wTVqnN5bd4/ChaG+kd9SKANu4VisBsovG2Bjx8HDWsdG
         Vgka4G3GlPsgs+4r8JX3PJhzu4B97xRoZuT49jp0gVlu59g/cB8zAnSLb/oMNJtdrc9R
         puxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+kpc6WLlrxz54CbugjvkATurAtlMaidS3JfczMUwdZtz8jd/Zn52yqD/K8ExXFLys3THU2RPhIHwJp5qmxHahDS3BrDT
X-Gm-Message-State: AOJu0Yzr25xVFA28hE1BPsKulXYWjVqkm2VU4+mfv2j3BAAeYWYIDFFX
	41xPOFZijngy0OhUkzVhGe+RV4LoWpWckh6CYi5xRZQDNtc2xeTOe/xRw+zooeDMy7ICnhk9NbF
	1Y9PP0tmFzDIBe69Oz3X2UjMjG7IMpMPydySc
X-Google-Smtp-Source: AGHT+IFNiC12ACDfwoCP+FCXjiKRvFZtf6R72oNOV5+4tIR6dsRZUTSkQftvcnrUomvX2XqiYI70nEOpdD0FSz54nrc=
X-Received: by 2002:a50:9fa1:0:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-58e02735e86mr205813a12.4.1720128237990; Thu, 04 Jul 2024
 14:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704-update-ld-version-for-new-lld-ver-str-v1-1-91bccc020a93@kernel.org>
In-Reply-To: <20240704-update-ld-version-for-new-lld-ver-str-v1-1-91bccc020a93@kernel.org>
From: Fangrui Song <maskray@google.com>
Date: Thu, 4 Jul 2024 14:23:46 -0700
Message-ID: <CAFP8O3JUgH-tBJtqO-QS0HmO4mrFBE6Dz+tnrBcse=gw_Q_4vQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Update ld-version.sh for change in LLD version output
To: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 9:19=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> After [1] in upstream LLVM, ld.lld's version output is slightly
> different when the cmake configuration option LLVM_APPEND_VC_REV is
> disabled.
>
> Before:
>
>   Debian LLD 19.0.0 (compatible with GNU linkers)
>
> After:
>
>   Debian LLD 19.0.0, compatible with GNU linkers
>
> This results in ld-version.sh failing with
>
>   scripts/ld-version.sh: 19: arithmetic expression: expecting EOF: "10000=
 * 19 + 100 * 0 + 0,"
>
> because the trailing comma is included in the patch level part of the
> expression. Remove the trailing comma when assigning the version
> variable in the LLD block to resolve the error, resulting in the proper
> output:
>
>   LLD 190000
>
> With LLVM_APPEND_VC_REV enabled, there is no issue with the new output
> because it is treated the same as the prior LLVM_APPEND_VC_REV=3DOFF
> version string was.
>
>   ClangBuiltLinux LLD 19.0.0 (https://github.com/llvm/llvm-project a3c5c8=
3273358a85a4e02f5f76379b1a276e7714), compatible with GNU linkers
>
> Cc: stable@vger.kernel.org
> Fixes: 02aff8592204 ("kbuild: check the minimum linker version in Kconfig=
")
> Link: https://github.com/llvm/llvm-project/commit/0f9fbbb63cfcd2069441aa2=
ebef622c9716f8dbb [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  scripts/ld-version.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
> index a78b804b680c..f2f425322524 100755
> --- a/scripts/ld-version.sh
> +++ b/scripts/ld-version.sh
> @@ -47,7 +47,9 @@ else
>         done
>
>         if [ "$1" =3D LLD ]; then
> -               version=3D$2
> +               # LLD after https://github.com/llvm/llvm-project/commit/0=
f9fbbb63cfcd2069441aa2ebef622c9716f8dbb
> +               # may have a trailing comma on the patch version with LLV=
M_APPEND_VC_REV=3Doff.
> +               version=3D${2%,}
>                 min_version=3D$($min_tool_version llvm)
>                 name=3DLLD
>                 disp_name=3DLLD
>
> ---
> base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
> change-id: 20240704-update-ld-version-for-new-lld-ver-str-b7a4afbbd5f1
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

Thanks for catching the issue.
If we want to minimize the number of special cases, perhaps we can
adjust `version=3D${version%-*}` below to

version=3D${version%%[^0-9.]*}

(POSIX shell doc:
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#:=
~:text=3DRemove%20Largest)

${version%%[^0-9.]*} is a simpler form than what glibc uses:

  "LLD"*)
  # Accept LLD 13.0.0 or higher
    AC_CHECK_PROG_VER(LD, $LD, --version,
                    [LLD.* \([0-9][0-9]*\.[0-9.]*\)],
                    [1[3-9].*|[2-9][0-9].*],



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

