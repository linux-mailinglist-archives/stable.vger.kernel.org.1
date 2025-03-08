Return-Path: <stable+bounces-121533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB932A57879
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 06:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1527A8394
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 05:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833C01714B3;
	Sat,  8 Mar 2025 05:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfQd84zj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9117A2E6;
	Sat,  8 Mar 2025 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741411726; cv=none; b=a4bbJIEUsKRtYf1bQi/foXyc5HuvRtoK/6vV1aLAEoN+mchk6sRghNF8taNosRQzZQ24GK6EDknlN1RE2DH6GsYMymf53JTuSMBk+8KecPSUlGcEcjUKY4+czH13DsE7XcwjMmZEtvffmdEibSW/8ZagxSgCWgrybtFGsftj0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741411726; c=relaxed/simple;
	bh=bf2oRrLyX61wmm9csWKqaHXp373r0RDGKowQWE05Wm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpvmxWrk4tDG1drHdVJcoN3GOrkeMkMjNliw7vin6dnYWNtN3a6PgkBhNdP2wTNh9aoxTuEsMPJTWFkWvb0Do7bx7v7KZYcbaXVyx6DFzeMRIQSdrWX+P2DEZUzuF/Dwni6FT7JOLyEFomNyo9DFtSynOa/1JjPX6NkcL2dYd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfQd84zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D3FC4AF09;
	Sat,  8 Mar 2025 05:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741411725;
	bh=bf2oRrLyX61wmm9csWKqaHXp373r0RDGKowQWE05Wm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MfQd84zj0WCS3WDjDja96SPDkDKjd+2NE62W1PkAi9bHplgBgO24wU22ENsJHdCuu
	 MBVhGVqgI8uWsjRYVgSvUy6WBr0xkxjMiqpvFn+pJcbH/jHML3848r3ou7EqNHNsnu
	 kU0g/iydv+N0P+cnk5v3eQGBA1WhKIGpVzTEzbgjzrLazl/6jjmRwKIfpiJQ8RWYiy
	 nKN3N8baO3lqajoGQBwgYstjkHU4ZJsef6Vgsf31v9GF8zzFqhsqzBrvLwrCghj8HV
	 PLlHRfFcJFBCyTylpO/iwVdJwXsMDuVzeDBCe/6G8SqWJCgF2cFlGBH5NKsyc4Pjvk
	 7HzN17ZsmLRAw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf64aa2a80so485083566b.0;
        Fri, 07 Mar 2025 21:28:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhWK+PpaF+OsvyuRGLxp9VprGx1LL16WUsEVJ9LMcVp+eL2CxkDMzYeDnF4pG62Zgd9sn0J8KB@vger.kernel.org, AJvYcCXespZ3wGJbPbquy9eJUEJMxXErrw0KR14VjF77GvRb8TrUIpWeHNb2Wglz2Qa3dimptyvauhXA5ZkrR5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKcrdFDtAGgVhMEp9xWccG0woZs9FIdt51XnILNHqdIervIoU
	LPqQsJ8KgUjDyBrCncCyXj9xwAo4Tg62E6L6YHtq+GjNQVDNE+3g4SIy8+d78QXtXRXHCrcrZEm
	u5JIOe9kHjwv1kHjVLKZ7u/EeKKg=
X-Google-Smtp-Source: AGHT+IGmBMWxNTIA9gWOEi+br3asuk6ba+EEBk7sBSjlNNzVHOnOv4RBDYUKXhxSogkNckgvoMcZT2chPBEHY7pKulE=
X-Received: by 2002:a17:907:1b05:b0:abf:74d6:e2b0 with SMTP id
 a640c23a62f3a-ac252747c60mr676960166b.3.1741411724129; Fri, 07 Mar 2025
 21:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025030745-flaxseed-unsubtly-c5e3@gregkh> <20250307214943.372210-1-ojeda@kernel.org>
In-Reply-To: <20250307214943.372210-1-ojeda@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 8 Mar 2025 13:28:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5TZ5ZE1XEQpzDU_o407V6+-q7i8xMFnmKdvyexG8ZG1Q@mail.gmail.com>
X-Gm-Features: AQ5f1JoR79KqQ8X2M9GvSz3UUmv0znvq0FO8VdTeRwCjtfFrzxdZGCv2L-NFnvo
Message-ID: <CAAhV-H5TZ5ZE1XEQpzDU_o407V6+-q7i8xMFnmKdvyexG8ZG1Q@mail.gmail.com>
Subject: Re: Linux 6.12.18
To: Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org, jslaby@suse.cz, 
	linux-kernel@vger.kernel.org, lwn@lwn.net, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, WANG Xuerui <kernel@xen0n.name>, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Miguel,

On Sat, Mar 8, 2025 at 5:50=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> On Fri, 07 Mar 2025 18:52:44 +0100 Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org> wrote:
> >
> > I'm announcing the release of the 6.12.18 kernel.
> >
> > All users of the 6.12 kernel series must upgrade.
>
> While testing another backport, I found an unrelated build failure for
> loongarch in v6.12.18 that I did not see in v6.12.17 -- I cannot find it
> reported from a quick look, so I am doing so here:
>
>        CC      arch/loongarch/kernel/asm-offsets.s - due to target missin=
g
>     In file included from arch/loongarch/kernel/asm-offsets.c:8:
>     In file included from ./include/linux/sched.h:12:
>     In file included from ./arch/loongarch/include/generated/asm/current.=
h:1:
>     In file included from ./include/asm-generic/current.h:6:
>     ./include/linux/thread_info.h:249:6: error: call to undeclared functi=
on 'annotate_reachable'; ISO C99 and later do not support implicit function=
 declarations [-Wimplicit-function-declaration]
>       249 |         if (WARN_ON_ONCE(bytes > INT_MAX))
>           |             ^
>     ./include/asm-generic/bug.h:113:3: note: expanded from macro 'WARN_ON=
_ONCE'
>       113 |                 __WARN_FLAGS(BUGFLAG_ONCE |                  =
   \
>           |                 ^
>     ./arch/loongarch/include/asm/bug.h:47:2: note: expanded from macro '_=
_WARN_FLAGS'
>        47 |         annotate_reachable();                                =
   \
>           |         ^
>
> As well as warnings:
>
>     In file included from arch/loongarch/kernel/asm-offsets.c:9:
>     In file included from ./include/linux/mm.h:1120:
>     In file included from ./include/linux/huge_mm.h:8:
>     In file included from ./include/linux/fs.h:33:
>     In file included from ./include/linux/percpu-rwsem.h:7:
>     In file included from ./include/linux/rcuwait.h:6:
>     In file included from ./include/linux/sched/signal.h:6:
>     ./include/linux/signal.h:114:27: warning: array index 3 is past the e=
nd of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
>       114 |                 return  (set1->sig[3] =3D=3D set2->sig[3]) &&
>           |                                          ^         ~
>     ./include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared =
here
>        62 |         unsigned long sig[_NSIG_WORDS];
>           |         ^
>
> I hope that helps.
This is caused by the backport commit 06e24745985c8dd0da183 ("objtool:
Remove annotate_{,un}reachable()"), but missing the commit
624bde3465f660e54a7cd4c1 ("loongarch: Use ASM_REACHABLE"), I will fix
it later.

In addition, it is better to also backport [1], since similar patches
for x86 have been backported, otherwise there will be build warnings.

[1] https://lore.kernel.org/loongarch/20250211115016.26913-8-yangtiezhu@loo=
ngson.cn/T/#u

Huacai
>
> Cheers,
> Miguel

