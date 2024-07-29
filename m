Return-Path: <stable+bounces-62576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1267B93F85B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630B5B2309B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6515533F;
	Mon, 29 Jul 2024 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teux74g4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310B15530C
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263798; cv=none; b=JYM9VC079mKUGlLwN6CUuUfCvDEBJdKPMbhPRxvZ3O/uxGZ4VRMt2NflOo+pX/a6nHgNrkoapGn43/yXktGPl6mPV0ITxlLS63fE68WsLaMLusC8moNN3yMKTGYjr60ogLQ3CDj5zBgj8ZqvapwfCv2m+twnMi6sr0DFmZgT2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263798; c=relaxed/simple;
	bh=89inWTCjdyhVEa2v1wD0lwpZ53o9W2nvSIm7DoV6xx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZrjVKC3C3aOGd8QUkJJiJ1frR0nEQNAXyHSDgG2P3YWohKErxScIh73oc1DiRlRyF5MXxHBQx2+dsXNrcM3BNTXUI1vqMOxFbvBN2eu2RFi2CO2xw6A782EpAoT3aEeig/GPGzZNpcoVoE+HZ6agSrCruSf7KKveJNiO+RHfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teux74g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0ABC32786
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722263798;
	bh=89inWTCjdyhVEa2v1wD0lwpZ53o9W2nvSIm7DoV6xx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=teux74g4fS3sxjvJUMd9vxgO/gu1a8nZtrj7DEfTENrReInNjoO8RZG3uhJ9fo1tG
	 RjsCda8e/Zx7LRXrb/SFIkcxhzK5lesqyIJlebsx9ijSgmuCbwIMJde19RFaWD9Pwl
	 ++KCe4siK9y1i7XMo4ibfhU3VdbxcUX1N0NXHY9OWFO6FgfvXAxZcR/HfjRee0q5O0
	 n/5ElN2nREhKBlsKXDJWrlbawOnnJQwiSoyTxUkyGMQb5GRuJ5qdoD8EmCDJGU+xaf
	 AEfQQ9mtRWe+7a9ACiWTEEj2KbjuCCHKx3lQIfHxZJgWDbPOn3aBBARc1o9EdXLz+z
	 NsH9g/E/yGTog==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso82543a12.0
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:36:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwJpPn2n6x+aLw3F9AGt++03jE4QFWIZFQCl7+kMjFZHM/SlcWF5ZiSPjGV1moq/CPJnkXKkDkqc3qaayXhGYNLeO+z/7R
X-Gm-Message-State: AOJu0YygRCimGC/cPgYo8aYKRd7x+td9QPYovLb7mDMjTU19p34ziyNz
	b/3ka7i93GRcdeKd6DJuLpHRr7YE/WFd9q4aB3ehx3hyD/iL6rwKK/+Fnefh63j7M7bHTxogrqT
	74+VlGKo7xcS6nWu7ADb5XeeUO4s=
X-Google-Smtp-Source: AGHT+IFquSmA5Y41KjI1VquqxmH4s1rMgE5tDyq9GwEugleoDfH3C6uoGfQEgGgQH53xYFxw9P3FEWpII1LjswjA+aE=
X-Received: by 2002:a50:8e50:0:b0:5a1:f680:5470 with SMTP id
 4fb4d7f45d1cf-5b0205d613emr5739297a12.13.1722263796031; Mon, 29 Jul 2024
 07:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024072921-props-yam-bb2b@gregkh>
In-Reply-To: <2024072921-props-yam-bb2b@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 29 Jul 2024 22:36:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6vXEaJf9NO9Lqh0xKoFAehtOOOLQVO4j5v+_tD7oKEXQ@mail.gmail.com>
Message-ID: <CAAhV-H6vXEaJf9NO9Lqh0xKoFAehtOOOLQVO4j5v+_tD7oKEXQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in
 unistd.h" failed to apply to 6.10-stable tree
To: gregkh@linuxfoundation.org
Cc: chenhuacai@loongson.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Greg,

For stable kernels before 6.11 please use this patch, thanks.

https://lore.kernel.org/loongarch/20240511100157.2334539-1-chenhuacai@loong=
son.cn/

Huacai

On Mon, Jul 29, 2024 at 8:15=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7697a0fe0154468f5df35c23ebd7aa48994c2cdc
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072921-=
props-yam-bb2b@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..
>
> Possible dependencies:
>
> 7697a0fe0154 ("LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h")
> 26a3b85bac08 ("loongarch: convert to generic syscall table")
> 505d66d1abfb ("clone3: drop __ARCH_WANT_SYS_CLONE3 macro")
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 7697a0fe0154468f5df35c23ebd7aa48994c2cdc Mon Sep 17 00:00:00 2001
> From: Huacai Chen <chenhuacai@kernel.org>
> Date: Sat, 20 Jul 2024 22:40:58 +0800
> Subject: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
>
> Chromium sandbox apparently wants to deny statx [1] so it could properly
> inspect arguments after the sandboxed process later falls back to fstat.
> Because there's currently not a "fd-only" version of statx, so that the
> sandbox has no way to ensure the path argument is empty without being
> able to peek into the sandboxed process's memory. For architectures able
> to do newfstatat though, glibc falls back to newfstatat after getting
> -ENOSYS for statx, then the respective SIGSYS handler [2] takes care of
> inspecting the path argument, transforming allowed newfstatat's into
> fstat instead which is allowed and has the same type of return value.
>
> But, as LoongArch is the first architecture to not have fstat nor
> newfstatat, the LoongArch glibc does not attempt falling back at all
> when it gets -ENOSYS for statx -- and you see the problem there!
>
> Actually, back when the LoongArch port was under review, people were
> aware of the same problem with sandboxing clone3 [3], so clone was
> eventually kept. Unfortunately it seemed at that time no one had noticed
> statx, so besides restoring fstat/newfstatat to LoongArch uapi (and
> postponing the problem further), it seems inevitable that we would need
> to tackle seccomp deep argument inspection.
>
> However, this is obviously a decision that shouldn't be taken lightly,
> so we just restore fstat/newfstatat by defining __ARCH_WANT_NEW_STAT
> in unistd.h. This is the simplest solution for now, and so we hope the
> community will tackle the long-standing problem of seccomp deep argument
> inspection in the future [4][5].
>
> Also add "newstat" to syscall_abis_64 in Makefile.syscalls due to
> upstream asm-generic changes.
>
> More infomation please reading this thread [6].
>
> [1] https://chromium-review.googlesource.com/c/chromium/src/+/2823150
> [2] https://chromium.googlesource.com/chromium/src/sandbox/+/c085b51940bd=
/linux/seccomp-bpf-helpers/sigsys_handlers.cc#355
> [3] https://lore.kernel.org/linux-arch/20220511211231.GG7074@brightrain.a=
erifal.cx/
> [4] https://lwn.net/Articles/799557/
> [5] https://lpc.events/event/4/contributions/560/attachments/397/640/deep=
-arg-inspection.pdf
> [6] https://lore.kernel.org/loongarch/20240226-granit-seilschaft-eccc2433=
014d@brauner/T/#t
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> diff --git a/arch/loongarch/include/asm/unistd.h b/arch/loongarch/include=
/asm/unistd.h
> index fc0a481a7416..e2c0f3d86c7b 100644
> --- a/arch/loongarch/include/asm/unistd.h
> +++ b/arch/loongarch/include/asm/unistd.h
> @@ -8,6 +8,7 @@
>
>  #include <uapi/asm/unistd.h>
>
> +#define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_SYS_CLONE
>
>  #define NR_syscalls (__NR_syscalls)
> diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/ker=
nel/Makefile.syscalls
> index ab7d9baa2915..523bb411a3bc 100644
> --- a/arch/loongarch/kernel/Makefile.syscalls
> +++ b/arch/loongarch/kernel/Makefile.syscalls
> @@ -1,4 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -# No special ABIs on loongarch so far
> -syscall_abis_64 +=3D
> +syscall_abis_64 +=3D newstat
>

