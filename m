Return-Path: <stable+bounces-177553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFDCB41098
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 01:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8167F5E765A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 23:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1025427875C;
	Tue,  2 Sep 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5u9bMZe"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B66B21CA14
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854558; cv=none; b=D6wheAqoHEBIvVBq+MsbclEAu7dd3Sj2zc0llPdbMgzzWnNm2HcmvlfoFM3++ms6dZCAQTX1RyRB410XnlRdk0COPdGuTNrxjgk89v1wfWWvuyS113mtyVkXkN1psDpf9lI7qjHQYu+LvRwJR51Ufo7D9emwzzw7/1eaZ+sG9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854558; c=relaxed/simple;
	bh=/Hfq1zGj3CUwWD00dGRfGcAZbooxiSw2BfRusJshfIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UF4idCJB5AiCxyKHgXpevkyjzNWFY/OPBBd33Ucf5Kcjfbhjn8T9hpGzmJUdNNMyUBC81QM7rnYI+1lts8xDnXixhf0oEQApZiEMUDqe37FEvM6xsB+A87/h2wqcPFihwMPVLjXf4vnCyIlQgAs7xfmzYBcM3cgvdKOYE1EJUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5u9bMZe; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-52a8b815a8aso1793958137.3
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 16:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756854555; x=1757459355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok/LzY68t77UKOxDiwSjWGMeBPTcLr/jFtZLJbmSzEE=;
        b=a5u9bMZemx9MYWLRB7BFGcMesdVcAdEVYf5lDX8qDM2QrHv4edI9QawWJ/fcXEx+gM
         12OhQCG/pkOcM0FXq+RfnSn4te2+nC1NJCZhiDgeXkZ17QLo3jGwlNINHXE7FuqylGdd
         G+7I2AeJqx5MBrKOUu/BQdxPNNlG0u0WCxsH/b/A119+fVVWdL2KW3LdJd3+VsxoNu/6
         GgiANf/uwPASlv3iGJz1SWqqbmr1+uRF3OBbceniuTRlCMYgCuYiKtThXq7K7wQ4fXGQ
         O9A7Hy162RzaR7SCsE/oRBkXT4MR935WG7F26DvUC1c/6dTt/m1GFpYoqafuA8qLJocJ
         1mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756854555; x=1757459355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok/LzY68t77UKOxDiwSjWGMeBPTcLr/jFtZLJbmSzEE=;
        b=A6HVZdwgvL+H2CY7GzU6JtkBuSPNYZV4qiNG5408bvPaK4WEyxcwQ8Sgb/Swa3rHIj
         WNEsgut09xLdV7GJgRoIlekWdR7mTtsCl9fMNDQPT1vp07DkTX8sgejlkYCAkb+pwBzS
         WmPzSK49BggPUCpSLXAle4ZZxGGYkJEjwEnSGzOrnLqHzOsk6kVY7mjAFcryYGC+ugcw
         yllkD0vsLUqB4LAqDSmpj/YpBy+BKVp/DYAE4ruqwf2k/C1CDyFm/QYafimxTGvTbSBE
         rCLwjOQRw+zXpmzn+wfzjbmm5548qbhbEfiMTGk5niKcwfqthgJV8x2UwTU5bqqBwYw0
         7rnA==
X-Forwarded-Encrypted: i=1; AJvYcCVmusyjfkgXhi0fONUT8U8ok34PwZLnSFUgv6UGHMdUkUkY9dvTkv8+1Yo2xsuEgqVIC8CHH5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDA/evV1JzfhbDj7Kj/ZjWbGaNORsKOKJQZ0Vg/v62ANWnhUs
	bwNQ1iEcxYC1Mki0Pt0+HMz37VEq5bKk9BAWt4/EoqF7NAdjRSXMsm0uR3qo5x4qPJ+/CbsporW
	X7Xx0svAPaeoP4SdjC4sufJM7QLqOT0Lf/LZRiv2Z
X-Gm-Gg: ASbGnctTot/Y6gKE5V6o4To7v6fKE6M3aSbw7vFgc1luWq2kLsGONyPZmT2eBaG2ODj
	m8HnBsQWxe1PQhujRbdataV9mSTmfs7VinAojIOBjeTPCdirZxB78vmBiWcH+TpquYyHIzlNqgd
	8WYB+dkuecTUbQwErJzWHXoXs7LykzyyrA3BnjDCHcsIwUO6xXDXFFkbrqW0+fCtns923Sk6KIu
	hu8khH7AeG1KyZgJtBWoylFNROvJ5FidZJdk6Lsu1k=
X-Google-Smtp-Source: AGHT+IFhdKhg4nEAeTuWh9UpE13dsM2opfmDBOIVuHeu39wqwcvL97R0YcUTOoAodJqlRurDkGUAODCGGTs6GPLWBMk=
X-Received: by 2002:a05:6102:3053:b0:4fd:35ca:6df5 with SMTP id
 ada2fe7eead31-52b1974e50amr4309938137.7.1756854554786; Tue, 02 Sep 2025
 16:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-clang-update-sanitize-defines-v1-1-cf3702ca3d92@kernel.org>
In-Reply-To: <20250902-clang-update-sanitize-defines-v1-1-cf3702ca3d92@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 2 Sep 2025 16:09:04 -0700
X-Gm-Features: Ac12FXywF_5PF4EJJMAvgc55AUTlDfNYbymSWMWfPLD0aBiRhuuGXQUjDtVsZ0g
Message-ID: <CAFhGd8qku6wkpqNCq+KpM4TMh-djVQW4UEdXON1Tk1BRtN8V6g@mail.gmail.com>
Subject: Re: [PATCH] compiler-clang.h: Define __SANITIZE_*__ macros only when undefined
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:49=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> Clang 22 recently added support for defining __SANITIZE__ macros similar
> to GCC [1], which causes warnings (or errors with CONFIG_WERROR=3Dy or
> W=3De) with the existing defines that the kernel creates to emulate this
> behavior with existing clang versions.
>
>   In file included from <built-in>:3:
>   In file included from include/linux/compiler_types.h:171:
>   include/linux/compiler-clang.h:37:9: error: '__SANITIZE_THREAD__' macro=
 redefined [-Werror,-Wmacro-redefined]
>      37 | #define __SANITIZE_THREAD__
>         |         ^
>   <built-in>:352:9: note: previous definition is here
>     352 | #define __SANITIZE_THREAD__ 1
>         |         ^
>
> Refactor compiler-clang.h to only define the sanitizer macros when they
> are undefined and adjust the rest of the code to use these macros for
> checking if the sanitizers are enabled, clearing up the warnings and
> allowing the kernel to easily drop these defines when the minimum
> supported version of LLVM for building the kernel becomes 22.0.0 or
> newer.
>
> Cc: stable@vger.kernel.org
> Link: https://github.com/llvm/llvm-project/commit/568c23bbd3303518c5056d7=
f03444dae4fdc8a9c [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
> Andrew, would it be possible to take this via mm-hotfixes?
> ---
>  include/linux/compiler-clang.h | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clan=
g.h
> index fa4ffe037bc7..8720a0705900 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -18,23 +18,42 @@
>  #define KASAN_ABI_VERSION 5
>
>  /*
> + * Clang 22 added preprocessor macros to match GCC, in hopes of eventual=
ly
> + * dropping __has_feature support for sanitizers:
> + * https://github.com/llvm/llvm-project/commit/568c23bbd3303518c5056d7f0=
3444dae4fdc8a9c
> + * Create these macros for older versions of clang so that it is easy to=
 clean
> + * up once the minimum supported version of LLVM for building the kernel=
 always
> + * creates these macros.
> + *
>   * Note: Checking __has_feature(*_sanitizer) is only true if the feature=
 is
>   * enabled. Therefore it is not required to additionally check defined(C=
ONFIG_*)
>   * to avoid adding redundant attributes in other configurations.
>   */
> +#if __has_feature(address_sanitizer) && !defined(__SANITIZE_ADDRESS__)
> +#define __SANITIZE_ADDRESS__
> +#endif
> +#if __has_feature(hwaddress_sanitizer) && !defined(__SANITIZE_HWADDRESS_=
_)
> +#define __SANITIZE_HWADDRESS__
> +#endif
> +#if __has_feature(thread_sanitizer) && !defined(__SANITIZE_THREAD__)
> +#define __SANITIZE_THREAD__
> +#endif
>
> -#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitize=
r)
> -/* Emulate GCC's __SANITIZE_ADDRESS__ flag */
> +/*
> + * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the =
kernel.
> + */
> +#ifdef __SANITIZE_HWADDRESS__
>  #define __SANITIZE_ADDRESS__
> +#endif
> +
> +#ifdef __SANITIZE_ADDRESS__
>  #define __no_sanitize_address \
>                 __attribute__((no_sanitize("address", "hwaddress")))
>  #else
>  #define __no_sanitize_address
>  #endif
>
> -#if __has_feature(thread_sanitizer)
> -/* emulate gcc's __SANITIZE_THREAD__ flag */
> -#define __SANITIZE_THREAD__
> +#ifdef __SANITIZE_THREAD__
>  #define __no_sanitize_thread \
>                 __attribute__((no_sanitize("thread")))
>  #else
>
> ---
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> change-id: 20250902-clang-update-sanitize-defines-845000c29d2c
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

