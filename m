Return-Path: <stable+bounces-126791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF60A71E8A
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9A43B984F
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFAF24EF67;
	Wed, 26 Mar 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5GNfyBu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B924CEEE;
	Wed, 26 Mar 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014417; cv=none; b=KNBlWwxa2DvOB/NeLIQj100iE5R2qrXk1KIhTr7u8xnuSl0c+/9xQtp4dcarz36g76qbCmKFTeVbEACU/TExK6DAMXA2GgAjQiEgPkHVQVj+GqLHXIuOWbSbdWa4iJ2EvjPhFUTmJm4DHCMAc4nkcYns5vHT+sTu7rcAZb68eww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014417; c=relaxed/simple;
	bh=F5Y3RF0ndf8/9azcsuLfDmtYTAz9gCrDPqNMbnYLM/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW1MaRX1lPV3oPCjwNX5o/R5nafaUmqrkDKnEXQAPbjGx/EvsjtOkeuo1ksZHSQjWFHPVOXUx+XAyn2PswCgPRpyndarTISvCRql68426IqEOc2oRPWm5I4l770ezWlDgbEk1T1aeuOUO091AzSAKpe8cITIm3q3YQkbga+O7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5GNfyBu; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so246953a12.1;
        Wed, 26 Mar 2025 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743014414; x=1743619214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOrtiNV+oGhM+385d+TAFbT9mzLoUCEIKut5q82hzIo=;
        b=R5GNfyBus4A7nney46YC6LA4g0kZ5jJauSUQT2USKS0yaqq498/WbbRytLe9U63Y1v
         C5yuP88u1TWK6Yu9GgK/78pq7Z5EoaC0G/0Ckr/tfg799viwijUpzOhFfoJRyATnZNoO
         ft7z857N1nzDfscRqJ3hY5aGJkHDiRD+Z+42JXgQYLZkN1RRYLkPxF2MOI5DKVgdshPb
         nNGUPsdwa+t6ULJcdeNwpJg61S9XhB7vON52aaEjLyBd4/D4xqJ0svJPlNJSxbkmNW8n
         M0b8QDMWQntANFwGqSVLi2bOkyYe/MvVTGmYkLblhIc+BfFPotAPbozKh336vqSwSCEi
         Ak4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743014414; x=1743619214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOrtiNV+oGhM+385d+TAFbT9mzLoUCEIKut5q82hzIo=;
        b=tfJWbQEq+1yeRMp/4jruCcudQQg6KzN+rKO610c3BXJDneV+4Yh/o0f/LBwkYazOuK
         8NLkS3pZuJBLJrQY9k2iNjpgKLEcM3Pqdxl9l9BqVLeIgBc/DSB2rugTVqHwQLggQif8
         qAZifM8b0BNqEn1AK9oyNF1I+jalxIoFxfcmeqUejxDfHoygYGW/oz7Xwx75CbNUFnei
         kNcNSy2NvjlruwbP3vadlz7DyL3Liie7kh+UwUF5V1zTaUXZz4oUdCUQKbQUqQp9VKwR
         I77+HkMD9/Vaor2OeD23D7DTcv401VjoWNkNq4oiRgRUPJxJOJh4URA/hDJjsSElAfqo
         DjSg==
X-Forwarded-Encrypted: i=1; AJvYcCUXlwQcZ7Y1elfHg/qJrx0x6+88M30QCVTnmEMU1VX1iwWhUZSk4XjVnHutdDkt0aesPX0bdrE4@vger.kernel.org, AJvYcCVrjOIt5xe+BQ5rkIU7Xurr1xcLD68JVEffzvndYd3eYsMdjWtSYsB7cCTC7ijEosejKgX5JVSCRGEVWOVL@vger.kernel.org, AJvYcCXTHhknumUFIymQbN6cHXnqlyKmLiH/Y++JKRegDeji6OMsZe2TtijPCAZ0i/VMikrRgCxEdf39c4ceFpg3R5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/tvLWCpMmTfiCXo3kPSjNgEKPSc+i2rQBa4sgZekbHMVBKdB
	jpq8yWoGM1zdaqV4ehGaE5gmSUJZoVCSoc9phpIq676nmUPs8qhWazCnxpaeeBlOzyPHgktWcsP
	0dqRpN8mnpdcBpwP7QG+cBS0LwsM=
X-Gm-Gg: ASbGncuhW4he5pmh6VLHD65R2pDnBsmyY5ww+MHnXpWdtH6n69s/J+rakpjmhLth9Jv
	kyjiM9MKjBd3nBsrJJHhAcsi1suSgeACjqKr4CCjY3tF4HpchoI+pp+MZ+WEv6kn0IlIzHSbV4+
	B4HllRvGSNvbByRRblxahTGX59tw==
X-Google-Smtp-Source: AGHT+IG/c8A09fmH4Hvi2r2iNvibbo0gF+QCVgYY3qZ1UUFDvGnHQ5yFC2x9sm4XWN8Ulm3xGBe6lcMopbawOHcqDlo=
X-Received: by 2002:a17:907:3da1:b0:ac2:6bb5:413c with SMTP id
 a640c23a62f3a-ac6faf45fbcmr48841566b.31.1743014413852; Wed, 26 Mar 2025
 11:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org>
 <20250326-string-add-wcslen-for-llvm-opt-v2-2-d864ab2cbfe4@kernel.org>
In-Reply-To: <20250326-string-add-wcslen-for-llvm-opt-v2-2-d864ab2cbfe4@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Mar 2025 20:39:37 +0200
X-Gm-Features: AQ5f1JqlCAtx3V-rK5Wv2QTv2YVgCmrK0MvTDzYhi8EajWnLgB-2pLN4PzLaYE0
Message-ID: <CAHp75Vd_mJggRRLfziWUf0tgr3K125uVBNh9VdSo9LHVJz2r_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/string.c: Add wcslen()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 7:19=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> A recent optimization change in LLVM [1] aims to transform certain loop
> idioms into calls to strlen() or wcslen(). This change transforms the
> first while loop in UniStrcat() into a call to wcslen(), breaking the
> build when UniStrcat() gets inlined into alloc_path_with_tree_prefix():
>
>   ld.lld: error: undefined symbol: wcslen
>   >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2=
_utils.h:54)
>   >>>               vmlinux.o:(alloc_path_with_tree_prefix)
>   >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2=
_utils.h:54)
>   >>>               vmlinux.o:(alloc_path_with_tree_prefix)
>
> The kernel does not build with '-ffreestanding' (which would avoid this
> transformation) because it does want libcall optimizations in general
> and turning on '-ffreestanding' disables the majority of them. While
> '-fno-builtin-wcslen' would be more targeted at the problem, it does not
> work with LTO.
>
> Add a basic wcslen() to avoid this linkage failure. While no
> architecture or FORTIFY_SOURCE overrides this, add it to string.c
> instead of string_helpers.c so that it is built with '-ffreestanding',
> otherwise the compiler might transform it into a call to itself.

...

> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -7,6 +7,7 @@
>  #include <linux/cleanup.h>     /* for DEFINE_FREE() */
>  #include <linux/compiler.h>    /* for inline */
>  #include <linux/types.h>       /* for size_t */

> +#include <linux/nls_types.h>   /* for wchar_t */

I know it's not ordered, but can we at least not make it worse, i.e.
squeeze this to be after the compiler.h? Or even somewhere after below
the err*.h? Whatever gives a better (sparsely) ordered overall
result...

>  #include <linux/stddef.h>      /* for NULL */
>  #include <linux/err.h>         /* for ERR_PTR() */

...

>  #ifndef __HAVE_ARCH_STRNLEN
>  extern __kernel_size_t strnlen(const char *,__kernel_size_t);
>  #endif
> +extern __kernel_size_t wcslen(const wchar_t *s);

I'm wondering why we still continue putting this 'extern' keyword.
Yes, I see that the rest is like this, but for new code do we really
need it?

>  #ifndef __HAVE_ARCH_STRPBRK
>  extern char * strpbrk(const char *,const char *);
>  #endif


--=20
With Best Regards,
Andy Shevchenko

