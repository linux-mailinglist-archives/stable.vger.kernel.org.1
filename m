Return-Path: <stable+bounces-19333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F884EAD6
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 22:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC277B26FBA
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 21:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC544F21F;
	Thu,  8 Feb 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyXd0Q2v"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B164F5ED
	for <stable@vger.kernel.org>; Thu,  8 Feb 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429045; cv=none; b=ixYIzp53KP4BKLh3GwIYATMorRXAFpkAQJimmI+mYuWsqw5uziFkaKAS0JuuAeCUrOhZBRtXnUj0kKycFLWVwsVbmA9zwhLk9EDJOpby6So9KV0O2iVRlQ1dSqLU9eaHchPCD0yIx2ysDJyJOuYRx87NigU1pzs91qoxxJYxljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429045; c=relaxed/simple;
	bh=kUygteJBS6KCH//gRa+4ItB8/T9NYxGBC59L0JWpVSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHLw0s8XAUQBU/gRXOs0VxZam69w4DI4PEIA/C6S269UkYbRj2GsRai13xltR2E8jz0SHBeiBCHvykFxd9TXGLS3fgP9PrBYldqtOnX6V/kdskOFc364U+5z9U4yR9+dEwVv/+0NuIXuFtL7wZS7G0lJqkn5DdgNW9Oqsv/ON0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyXd0Q2v; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so40504766b.0
        for <stable@vger.kernel.org>; Thu, 08 Feb 2024 13:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707429042; x=1708033842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk2Mf+CYgNj0rrQ4AtP2FsCs3Z7W5vLJ8AK+GUlsuys=;
        b=WyXd0Q2vVI3up9xny/h7wHXd+hutHmY/PqjLQKhMXoOtXxu78K7WC6ZJyllrbHUCbA
         lKbETycZzjHnKIPtsAxlvylGJDB9VEYu1EfiAbTy9xNgafzgvpMWrujbN/AQCRFGqEv/
         uT214YQXfL9d8jbeq5OwioI+N9Qp16szXGDYSp4OdLnJcr8k9066h9OWI8bmMEMvtD/q
         u09UL6KFoK29UuYN8G3K5+pruDZ83pAEeMcHVH+rF3CPqKlrIyHbvPngtN6J2GfGNgGf
         Emqu/P5826ry+2awo19cEOLjxCSVJQYsUDBgbbRtVjvc58wTpU4vlL4VKl1cdzNyaXGK
         9DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429042; x=1708033842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rk2Mf+CYgNj0rrQ4AtP2FsCs3Z7W5vLJ8AK+GUlsuys=;
        b=ks8y1AAMcMhYkIczz/y5fvQHoOoY/QeXeBnZbesYRxbWvYsvUFVSqtF/ViBQ3y6W7i
         qSPwGaef5Z2iyhSdCQ2hZdZJJ537upSxrT6BazdMOkRvEbMzQwd1Wpss0QWzWyVpirnu
         gfurabOMpZg3ZY/gIWicrNzolECgEcJ1oVGDCy8GrSGSPzEOjkPDtOXXk8PeQNGGRupN
         eHoSjuDIj1VkUz2VDC5SzOT/zBzK25xBzxC2bdtepUkLah5lLwxgKPHP13vt53k/Gwf+
         3bgyyfs1OU4ykOu5UpDTWHZX9a4eRcB6k0GeFsSoQHfMJLenOR/8RThh4aiGLj5jiJsb
         GMVw==
X-Gm-Message-State: AOJu0YyvMU7YmSccPZcia5U+kdV1dVr9yqK3+P8+JZ0QM2/YU/iQsuw6
	6ziz++HV3OBIJ7eBEuXY6bafi/YWoRSG+clnJHmNzqRe6cDyTB+IJj1+yTUAK7PgqZs3TAwQvmh
	cAUURIhUNl8M+2zFiqLcY82A8tCNc5Jgem8YC
X-Google-Smtp-Source: AGHT+IHJV6Lqt0M69QP75rhTnc4EGw8bgsYHixzIOWzmQ/W0T5fBOc4OYsmaq0/5BaxifVnY2kb+0zD0SFv1RUA+6eM=
X-Received: by 2002:a17:907:39a:b0:a38:5302:89ec with SMTP id
 ss26-20020a170907039a00b00a38530289ecmr380516ejb.42.1707429041842; Thu, 08
 Feb 2024 13:50:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org>
In-Reply-To: <20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 8 Feb 2024 13:50:29 -0800
Message-ID: <CAFhGd8pfMjkdTWx3HnVRpZNgbOy7KkvuD5vytP0G+0ByY_++9w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix changing ELF file type for output of gen_btf
 for big endian
To: Nathan Chancellor <nathan@kernel.org>
Cc: masahiroy@kernel.org, nicolas@fjasle.eu, ndesaulniers@google.com, 
	morbo@google.com, keescook@chromium.org, maskray@google.com, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 12:21=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Commit 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> changed the ELF type of .btf.vmlinux.bin.o from ET_EXEC to ET_REL via
> dd, which works fine for little endian platforms:
>
>    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF.....=
.......|
>   -00000010  03 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |.........=
.......|
>   +00000010  01 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |.........=
.......|
>
> However, for big endian platforms, it changes the wrong byte, resulting
> in an invalid ELF file type, which ld.lld rejects:
>
>    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF.....=
.......|
>   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
.......|
>   +00000010  01 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
.......|
>
>   Type:                              <unknown>: 103
>
>   ld.lld: error: .btf.vmlinux.bin.o: unknown file type
>
> Fix this by using a different seek value for dd when targeting big
> endian, so that the correct byte gets changed and everything works
> correctly for all linkers.
>
>    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF.....=
.......|
>   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
.......|
>   +00000010  00 01 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
.......|
>
>   Type:                              REL (Relocatable file)
>
> Cc: stable@vger.kernel.org
> Fixes: 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> Link: https://github.com/llvm/llvm-project/pull/75643
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Justin Stitt <justinstitt@google.com>

> ---
>  scripts/link-vmlinux.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a432b171be82..8a9f48b3cb32 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -135,8 +135,15 @@ gen_btf()
>         ${OBJCOPY} --only-section=3D.BTF --set-section-flags .BTF=3Dalloc=
,readonly \
>                 --strip-all ${1} ${2} 2>/dev/null
>         # Change e_type to ET_REL so that it can be used to link final vm=
linux.
> -       # Unlike GNU ld, lld does not allow an ET_EXEC input.
> -       printf '\1' | dd of=3D${2} conv=3Dnotrunc bs=3D1 seek=3D16 status=
=3Dnone
> +       # Unlike GNU ld, lld does not allow an ET_EXEC input. Make sure t=
he correct
> +       # byte gets changed with big endian platforms, otherwise e_type m=
ay be an
> +       # invalid value.
> +       if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> +               seek=3D17
> +       else
> +               seek=3D16
> +       fi
> +       printf '\1' | dd of=3D${2} conv=3Dnotrunc bs=3D1 seek=3D${seek} s=
tatus=3Dnone
>  }
>
>  # Create ${2} .S file with all symbols from the ${1} object file
>
> ---
> base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
> change-id: 20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-dbc55a1e129=
6
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

