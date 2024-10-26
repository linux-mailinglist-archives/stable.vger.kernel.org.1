Return-Path: <stable+bounces-88220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BBE9B1AB8
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 22:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B31F21CD2
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 20:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D702187850;
	Sat, 26 Oct 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yuTgQOiV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sa6ZCPHI"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315DF9CF;
	Sat, 26 Oct 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729974078; cv=none; b=QOVKCa7DWhq726SAH/SHh4PWmMql5uUtS7p8zrnjgYmIxbkv3/sTiQISyAesYKgfjVfdxWxkz5LeIAwrLDSO/kksQKZ6U5cd0Ev8wXUynIedXbua3+RQpAJ7+ST3Ee6+0YkKhdXyDuywNk6v3DG41Zj1jcFDbp+mKyouX/Agd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729974078; c=relaxed/simple;
	bh=4RO+I45ZMTd84+0w9a/hMQQ8nCEPZF58XMe7CBLRXWA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=NwDYiZ0Dk82WkQ0AszRWVkBnci0hCLchOy+29PAGI53YylT9aZYqeOtK/S7VsUrLkz8UOnV9A3NgHyQqmByjw+E6uLYCUA/6ZgZLUZR1srDeVvmvORdSIqfxXfSDxI9sjNggwfXzQ9hWmYQSHP8U68il/MRe3SSoIsYo24T9U+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yuTgQOiV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sa6ZCPHI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729974068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=UVBjNciPaT9E3/C35g4TcCJ4q9NvcZt7yT82yg5lifo=;
	b=yuTgQOiVrC6YqmdaazV/76roMK9/6pPIX11AwxpNcefs6yBRJrT40Kz/ph35Fs/0rlDXfS
	HLx+afW3lXBxobzfZrLsT/D1wZZ7UPBL5GYzAIAaT2Fx8GLPs3W4Lq+wbnCgMX1dN7OPRF
	bJxeArvFOkcagJXOOI5XsPdIQ24hE4kgbzRNprnMUCJmG8TyylfgZSN7tlrk3ffDLE/ziT
	DccGekjNYS5xeqlHz2mN+PZ5YhjhJsBOLwN0mb1B7hgtjNRfrD+tD4yaVYLe1XFzL8rgcO
	TNWzgNSRAnv6HqiCLHXzO9uvKlIH6eQVj9cvqY7H139nEFCnP4k9my6BLdbpJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729974068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=UVBjNciPaT9E3/C35g4TcCJ4q9NvcZt7yT82yg5lifo=;
	b=Sa6ZCPHIASFMTbZNN3AyFVpS+Y/Kgi9RYHbv8Afr5k+F8gwTtD6/kb8Ju/Yds4Py8n8Lmt
	qdf1h93fBB9ukSCA==
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Celeste Liu
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
In-Reply-To: <87ldycjluq.fsf@all.your.base.are.belong.to.us>
Date: Sat, 26 Oct 2024 22:21:07 +0200
Message-ID: <87ldya4nv0.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25 2024 at 07:30, Bj=C3=B6rn T=C3=B6pel wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> It's completely unclear to me what the actual problem is. The flow how
>> this works on all architectures is:
>>
>>        regs->orig_a0  =3D regs->a0
>>        regs->a0 =3D -ENOSYS;
>>
>>        nr =3D syscall_enter_from_user_mode(....);
>>
>>        if (nr >=3D 0)
>>           regs->a0 =3D nr < MAX_SYSCALL ? syscall(nr) : -ENOSYS;
>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>> If syscall_trace_enter() returns -1 to skip the syscall, then regs->a0
>> is unmodified, unless one of the magic operations modified it.
>>
>> If syscall_trace_enter() was not active (no tracer, no seccomp ...) then
>> regs->a0 already contains -ENOSYS.
>>
>> So what's the exact problem?
>
> It's a mix of calling convention, and UAPI:
>   * RISC-V uses a0 for arg0 *and* return value (like arm64).
>   * RISC-V does not expose orig_a0 to userland, and cannot easily start
>     doing that w/o breaking UAPI.
>
> Now, when setting a0 to -ENOSYS, it's clobbering arg0, and the ptracer
> will have an incorrect arg0 (-ENOSYS).

Oh I see. I was looking at it from the x86 POV...=20

Looking deeper into this, this is all completely inconsistent across
architectures. All of them copied either from x86 or from some other
close enough existing copy and changed stuff on top.

So we have two different scenarios AFAICT (I did not look really
deeply):

   1) The register which holds the syscall number is used for the
      return value

   2) An argument register is used for the return value

#1 is the easy case and just "works"

   because orig_$REG holds the original syscall number and everything
   falls into place.

#2 needs some thought, but we are not going to add this:

>	 if (work & SYSCALL_WORK_ENTER)
>		 syscall =3D syscall_trace_enter(regs, syscall, work);
> +	else if (syscall =3D=3D -1L)
> +		syscall_set_return_value(current, regs, -ENOSYS, 0);
>

into the syscall path just to make #2 work. That's hotpath and affects
all other architectures too.

So the problem for the #2 case is that there is no distinction between a
user space issued syscall(@nr =3D -1) and the return value of (-1) of
various functions involved in the syscall 'tracer' processing.

So what the issue with Celeste's change is:

	res =3D syscall_enter_from_user_mode(regs, syscall);
	syscall =3D syscall_get_nr(current, regs);

	add_random_kstack_offset();

	if (syscall < 0 || syscall >=3D NR_syscalls)
        	regs->a0 =3D -ENOSYS;

As the tracer can invalidate the syscall number along with regs->a0,
this overwrites the error code set by the tracer. Your solution has a
similar problem.

There is another issue vs. regs->a0. Assume a ptracer modified regs->a0
(arg0) and lets the task continue (no fatal signal pending).

Then the following seccomp() invocation will get regs->orig_a0 from
syscall_get_arguments(), which is not what the ptracer set, right?

Let me look at your failure analysis from your first reply:

>  1. strace "tracing": Requires that regs->a0 is not tampered with prior
>     ptrace notification
>=20
>     E.g.:
>     | # ./strace /
>     | execve("/", ["/"], 0x7ffffaac3890 /* 21 vars */) =3D -1 EACCES (Per=
mission denied)
>     | ./strace: exec: Permission denied
>     | +++ exited with 1 +++
>     | # ./disable_ptrace_get_syscall_info ./strace /
>     | execve(0xffffffffffffffda, ["/"], 0x7fffd893ce10 /* 21 vars */) =3D=
 -1 EACCES (Permission denied)
>     | ./strace: exec: Permission denied
>     | +++ exited with 1 +++
>=20
>     In the second case, arg0 is prematurely set to -ENOSYS
>     (0xffffffffffffffda).

That's expected if ptrace_get_syscall_info() is not used. Plain dumping
registers will give you the current value on all architectures.
ptrace_get_syscall_info() exist exactly for that reason.

>  2. strace "syscall tampering": Requires that ENOSYS is returned for
>     syscall(-1), and not skipped w/o a proper return value.
>=20
>     E.g.:
>     | ./strace -a0 -ewrite -einject=3Dwrite:error=3Denospc echo helloject=
=3Dwrite:error=3Denospc echo hello=20=20=20
>=20
>     Here, strace expects that injecting -1, would result in a ENOSYS.

No. It expects ENOSPC with the above command line. man strace:

       If :error=3Derrno option is specified, a fault is injected into a
       syscall invocation: the syscall number is replaced by -1 which
       corresponds to an invalid syscall (unless a syscall is specified
       with :syscall=3D option), and the error code is specified using a
       symbolic errno value like ENOSYS or a numeric value within
       1..4095 range.

Similar for -einject:retval=3D$N

So you cannot overwrite a0 with ENOSYS if the syscall needs to be
skipped.

>  3. seccomp filtering: Requires that the a0 is not tampered to

No. seccomp uses syscall_get_arguments() which sets a0 to orig_a0 for
inspection. As I said before that fails when the ptracer changed
argument 0 before the seccomp invocation. seccomp will see the original
argument and waves it through.

Looking at Celeste's analysis again:

> We can't know whether syscall_nr is -1 when we get -1
> from syscall_enter_from_user_mode(). And the old syscall variable is
> unusable because syscall_enter_from_user_mode() may change a7 register.

You obviously can save the user space supplied value away
in do_trap_ecall_u() by simply doing

       long orig_nr =3D regs->a7;

No? But I'm not sure that it solves all problems. It cannot solve the
ptrace/seccomp interaction.

The rest of the changelog is simply bogus. Just because riscv made a
mistake with the UABI design does not mean that it's useless for
everyone else.

And no, I'm not going to change x86 for that just to have a pointless
load in the syscall hotpath, when the normal operation just keeps the
syscall number in the same register.

The real problem is that orig_a0 is not exposed in the user view of the
registers. Changing that struct breaks the existing applications
obviously.

But you can expose it without changing the struct by exposing a regset
for orig_a0 which allows you to read and write it similar to what ARM64
does for the syscall number.

That of course requires updated user space, but existing user space will
continue to work with the current limitations.

Thanks,

        tglx

