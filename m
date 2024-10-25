Return-Path: <stable+bounces-88168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF99B05DD
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 16:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D67A1C22A2B
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B520BB2E;
	Fri, 25 Oct 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of9KxQSZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863720BB25;
	Fri, 25 Oct 2024 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866655; cv=none; b=tc02LViu5nHRL6AHtCOqsOa2FboGMX8V8azgt5mibV0kn9vbgGPbC/sZ7deSNZvV+oPFmfXOFIsabdMR2usD937KO9lu/lA3GaWafvyH6W6Zg8CB/QoYAbaytwxvdQv//iY1w/SUDhbgtuTwnp2DE9fxpafqwRYAOpAqC6r6LRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866655; c=relaxed/simple;
	bh=OF/70o8NlOOAbbvPS34QecnaUEGCvVzevoHviGTWZO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BTvzKC3/P1CbtbZggBiYQEQnngmR1mVQqwLlATObvH5lqzAcofQ5wuVbxg1WMOI6hgPsFW7CA3nY/dXw2Yc0stJYTYdTgYKK+SMXpncvbcpBCj57zxxVC/lfelveqZpy6kEMBTuw2gz42nBuwRFXHpxYBKWLVkm4uvIlvHEDDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of9KxQSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADA7C4CEE9;
	Fri, 25 Oct 2024 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729866654;
	bh=OF/70o8NlOOAbbvPS34QecnaUEGCvVzevoHviGTWZO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=of9KxQSZRl6hvInqEi5ITtFSy38Asc/iopeslC1Yl6LdQQyfnMOk5spZtwhIZgUE0
	 Y06VQ0lw2gUWFK+TzjA0NugCOpDJhG8Wf9bF04gCKNSNamfic7xDZpYlYuOpwbnphp
	 nHDrvZignvu1A13IoUA+sEK+SBZFkaM6hjSyDvX45MH2dmloHj1ZH5JdP/sbl0/w86
	 0arzE5KY9GblP9BgMMOdmoqK9zKJHKkyePWkXSB5CywvKqqHC0Dh8prcks6IECRMcO
	 rlvPTQQPw+DG6MT/FGNbzOMjpxgXEAhFzBY5rlqYzur/Zo527ZsBCQ9sAKaVhMpJUv
	 zVmi9CDERBkNA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Celeste Liu
 <coelacanthushex@gmail.com>, Celeste Liu via B4 Relay
 <devnull+CoelacanthusHex.gmail.com@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, Yao Zi
 <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
In-Reply-To: <871q045ntd.ffs@tglx>
References: <20241017-fix-riscv-syscall-nr-v1-1-4edb4ca07f07@gmail.com>
 <87a5exy2rx.fsf@all.your.base.are.belong.to.us>
 <b72e3d2b-d540-47bf-adec-0ab6eda135d8@gmail.com>
 <8734kpqu8k.fsf@all.your.base.are.belong.to.us> <871q045ntd.ffs@tglx>
Date: Fri, 25 Oct 2024 07:30:53 -0700
Message-ID: <87ldycjluq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> writes:

> On Mon, Oct 21 2024 at 09:46, Bj=C3=B6rn T=C3=B6pel wrote:
>> Celeste Liu <coelacanthushex@gmail.com> writes:
>>> 1. syscall_enter_from_user_mode() will do two things:
>>>    1) the return value is only to inform whether the syscall should be =
skipped.
>>>    2) regs will be modified by filters (seccomp or ptrace and so on).
>>> 2. for common entry user, there is two informations: syscall number and
>>>    the return value of syscall_enter_from_user_mode() (called is_skippe=
d below).
>>>    so there is three situations:
>>>    1) if syscall number is invalid, the syscall should not be performed=
, and
>>>       we set a0 to -ENOSYS to inform userspace the syscall doesn't exis=
t.
>>>    2) if syscall number is valid, is_skipped will be used:
>>>       a) if is_skipped is -1, which means there are some filters reject=
 this syscall,
>>>          so the syscall should not performed. (Of course, we can use bo=
ol instead to
>>>          get better semantic)
>>>       b) if is_skipped !=3D -1, which means the filters approved this s=
yscall,
>>>          so we invoke syscall handler with modified regs.
>>>
>>> In your design, the logical condition is not obvious. Why syscall_enter=
_from_user_mode()
>>> informed the syscall will be skipped but the syscall handler will be ca=
lled
>>> when syscall number is invalid? The users need to think two things to g=
et result:
>>> a) -1 means skip
>>> b) -1 < 0 in signed integer, so the skip condition is always a invalid =
syscall number.
>>>
>>> In may way, the users only need to think one thing: The syscall_enter_f=
rom_user_mode()
>>> said -1 means the syscall should not be performed, so use it as a condi=
tion of reject
>>> directly. They just need to combine the informations that they get from=
 API as the
>>> condition of control flow.
>>
>> I'm all-in for simpler API usage! Maybe massage the
>> syscall_enter_from_user_mode() (or a new one), so that additional
>> syscall_get_nr() call is not needed?
>
> It's completely unclear to me what the actual problem is. The flow how
> this works on all architectures is:
>
>        regs->orig_a0  =3D regs->a0
>        regs->a0 =3D -ENOSYS;
>
>        nr =3D syscall_enter_from_user_mode(....);
>
>        if (nr >=3D 0)
>           regs->a0 =3D nr < MAX_SYSCALL ? syscall(nr) : -ENOSYS;
>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> If syscall_trace_enter() returns -1 to skip the syscall, then regs->a0
> is unmodified, unless one of the magic operations modified it.
>
> If syscall_trace_enter() was not active (no tracer, no seccomp ...) then
> regs->a0 already contains -ENOSYS.
>
> So what's the exact problem?

It's a mix of calling convention, and UAPI:
  * RISC-V uses a0 for arg0 *and* return value (like arm64).
  * RISC-V does not expose orig_a0 to userland, and cannot easily start
    doing that w/o breaking UAPI.

Now, when setting a0 to -ENOSYS, it's clobbering arg0, and the ptracer
will have an incorrect arg0 (-ENOSYS).

