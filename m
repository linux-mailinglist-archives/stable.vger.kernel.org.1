Return-Path: <stable+bounces-87569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B35F9A6B65
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98491F228FA
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A11FCC4D;
	Mon, 21 Oct 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXjKY2iv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C785B1E526;
	Mon, 21 Oct 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519219; cv=none; b=bkRl3y3IO+xSoRuB+pjhDNef/w0lobQ+jGNPGkkn/Hjlb6fUhmG8BM2kEwQgCpVzxVBOxXLx+raTjMtI6SEtgObVUOKE+aoVJwr4VeiZChcX3v9x6QFainHelUMfF/gWgXV99ZWjiru2wvRlL1I96WZKy48v4Nhyw3GDIJKcpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519219; c=relaxed/simple;
	bh=K11LCsKQc2ry+fO2DLHhfmu1ngQ3hcOkF6If1cy54AQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JVuj8RHWVgz1wyfIvBtqw4MDXp865g+lg0Np2umEe793tJC7fwFml3GEk2qByyWwsqzRT/Bv6oEhuKKzyfsg/Nd5iG+mvrSt4PBBc3uRPU43VSVLBiVCKjoc/2LwmX+iJLHr4SKM4KaWn66koPdDhfee1aP2f9tVGFDq24+hQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXjKY2iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48588C4CEC3;
	Mon, 21 Oct 2024 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729519219;
	bh=K11LCsKQc2ry+fO2DLHhfmu1ngQ3hcOkF6If1cy54AQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FXjKY2ivGt3Mpt61YRFUTs3b2GtS1CmR0iRrDHbkKfbCFbxaB1Dqc9jCDNBBZXwRA
	 KH/dRGXLr1QOLq3/tFPYD2PFWA2su8eqDI+cAX8FxifCvPQM+RS462Uu1udKI6hGL4
	 IvumQKTBZH1IsQI2jegzgTWPeCXj6FFYzUnjVQN7AXFn+6HFKBA+PQHV9KvL441E3Z
	 298qDG/R2qWvdWrZv+h8fZB8NkF0vsTOOHR+RSoZggVKAKJlLEyKJx9uIRIDEyZ8BK
	 8I03R2DEpOCWpy2RwZZei9RQw9zM/ueu/PRZNmXE+60OJVr5nF0gmhw1TgXOGZih+I
	 uKTNfhq0LfRWA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, =?utf-8?B?Qmo=?=
 =?utf-8?B?w7ZybiBUw7ZwZWw=?=
 <bjorn@rivosinc.com>, Celeste Liu <coelacanthushex@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, Yao Zi
 <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
In-Reply-To: <20241017-fix-riscv-syscall-nr-v1-1-4edb4ca07f07@gmail.com>
References: <20241017-fix-riscv-syscall-nr-v1-1-4edb4ca07f07@gmail.com>
Date: Mon, 21 Oct 2024 07:00:18 -0700
Message-ID: <87a5exy2rx.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Celeste!

I'll pick up your thread [1] here, since there's code here! :-) Let's
try to clear up/define the possible flow.

The common/generic entry syscall_enter_from_user_mode{,_work}() says
that a return value of -1 means that the syscall should be skipped.

The RISC-V calling convention uses the same register for arg0/retval
(a0). So, when a ptracer (PTRACE_SYSCALL+PTRACE_GETREGS). That means
that the kernel cannot call into the tracer, *after* changing a0.

The interesting flow for a syscall is roughly:
1. The exception/trap function
2. syscall_enter_from_user_mode() which might return -1, meaning that
   the syscall should be skipped. A tracer might have altered the
   regs. More importantly, if it's -1 the kernel cannot change the
   return value, because seccomp filtering might already done that.
3. If it's a valid syscall, perform the syscall.

Now some scenarios:
* A user does a valid syscall.
* A user does an invalid syscall(-1)
* A user does an invalid syscall(!=3D -1)

Then there're the tracing variants of those, and that's where we go get
trouble.

Now the bugs we've seen in RISC-V:

1. strace "tracing": Requires that regs->a0 is not tampered with prior
   ptrace notification

   E.g.:
   | # ./strace /
   | execve("/", ["/"], 0x7ffffaac3890 /* 21 vars */) =3D -1 EACCES (Permis=
sion denied)
   | ./strace: exec: Permission denied
   | +++ exited with 1 +++
   | # ./disable_ptrace_get_syscall_info ./strace /
   | execve(0xffffffffffffffda, ["/"], 0x7fffd893ce10 /* 21 vars */) =3D -1=
 EACCES (Permission denied)
   | ./strace: exec: Permission denied
   | +++ exited with 1 +++

   In the second case, arg0 is prematurely set to -ENOSYS
   (0xffffffffffffffda).

2. strace "syscall tampering": Requires that ENOSYS is returned for
   syscall(-1), and not skipped w/o a proper return value.
=20=20=20
   E.g.:
   | ./strace -a0 -ewrite -einject=3Dwrite:error=3Denospc echo helloject=3D=
write:error=3Denospc echo hello=20=20=20
=20=20=20
   Here, strace expects that injecting -1, would result in a ENOSYS.

3. seccomp filtering: Requires that the a0 is not tampered to

First 3 was broken (tampering with a0 after seccomp), then 2 was
broken (not setting ENOSYS for -1), and finally 1 was broken (and
still is!).

Now for your patch:

Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>
writes:

> From: Celeste Liu <CoelacanthusHex@gmail.com>
>
> The return value of syscall_enter_from_user_mode() is always -1 when the
> syscall was filtered. We can't know whether syscall_nr is -1 when we get =
-1
> from syscall_enter_from_user_mode(). And the old syscall variable is
> unusable because syscall_enter_from_user_mode() may change a7 register.
> So get correct syscall number from syscall_get_nr().
>
> So syscall number part of return value of syscall_enter_from_user_mode()
> is completely useless. We can remove it from API and require caller to
> get syscall number from syscall_get_nr(). But this change affect more
> architectures and will block more time. So we split it into another
> patchset to avoid block this fix. (Other architectures can works
> without this change but riscv need it, see Link: tag below)
>
> Fixes: 61119394631f ("riscv: entry: always initialize regs->a0 to -ENOSYS=
")
> Reported-by: Andrea Bolognani <abologna@redhat.com>
> Closes: https://github.com/strace/strace/issues/315
> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gm=
ail.com/
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
>  arch/riscv/kernel/traps.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 51ebfd23e0076447518081d137102a9a11ff2e45..3125fab8ee4af468ace9f692d=
d34e1797555cce3 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -316,18 +316,25 @@ void do_trap_ecall_u(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
>  		long syscall =3D regs->a7;
> +		long res;
>=20=20
>  		regs->epc +=3D 4;
>  		regs->orig_a0 =3D regs->a0;
> -		regs->a0 =3D -ENOSYS;
>=20=20
>  		riscv_v_vstate_discard(regs);
>=20=20
> -		syscall =3D syscall_enter_from_user_mode(regs, syscall);
> +		res =3D syscall_enter_from_user_mode(regs, syscall);
> +		/*
> +		 * Call syscall_get_nr() again because syscall_enter_from_user_mode()
> +		 * may change a7 register.
> +		 */
> +		syscall =3D syscall_get_nr(current, regs);
>=20=20
>  		add_random_kstack_offset();
>=20=20
> -		if (syscall >=3D 0 && syscall < NR_syscalls)
> +		if (syscall < 0 || syscall >=3D NR_syscalls)
> +			regs->a0 =3D -ENOSYS;
> +		else if (res !=3D -1)
>  			syscall_handler(regs, syscall);

Here we can perform the syscall, even if res is -1. E.g., if this path
[2] is taken, we might have a valid syscall number in a7, but the
syscall should not be performed.

Also, one reason for the generic entry is so that it should be less
work. Here, you pull (IMO) details that belong to the common entry
implementation/API up the common entry user. Wdyt about pushing it down
to common entry? Something like:

--8<--
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 51ebfd23e007..66fded8e4b60 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -319,7 +319,6 @@ void do_trap_ecall_u(struct pt_regs *regs)
=20
 		regs->epc +=3D 4;
 		regs->orig_a0 =3D regs->a0;
-		regs->a0 =3D -ENOSYS;
=20
 		riscv_v_vstate_discard(regs);
=20
@@ -329,6 +328,8 @@ void do_trap_ecall_u(struct pt_regs *regs)
=20
 		if (syscall >=3D 0 && syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
+		else if (syscall !=3D -1)
+			regs->a0 =3D -ENOSYS;
=20
 		/*
 		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 1e50cdb83ae5..9b69c2ad4f12 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -14,6 +14,7 @@
 #include <linux/kmsan.h>
=20
 #include <asm/entry-common.h>
+#include <asm/syscall.h>
=20
 /*
  * Define dummy _TIF work flags if not defined by the architecture or for
@@ -166,6 +167,8 @@ static __always_inline long syscall_enter_from_user_mod=
e_work(struct pt_regs *re
=20
 	if (work & SYSCALL_WORK_ENTER)
 		syscall =3D syscall_trace_enter(regs, syscall, work);
+	else if (syscall =3D=3D -1L)
+		syscall_set_return_value(current, regs, -ENOSYS, 0);
=20
 	return syscall;
 }
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 5b6934e23c21..99742aee5002 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -43,8 +43,10 @@ long syscall_trace_enter(struct pt_regs *regs, long sysc=
all,
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		ret =3D ptrace_report_syscall_entry(regs);
-		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
+		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU)) {
+			syscall_set_return_value(current, regs, -ENOSYS, 0);
 			return -1L;
+		}
 	}
=20
 	/* Do seccomp after ptrace, to catch any tracer changes. */
@@ -66,6 +68,14 @@ long syscall_trace_enter(struct pt_regs *regs, long sysc=
all,
 		syscall =3D syscall_get_nr(current, regs);
 	}
=20
+	/*
+	 * If we're not setting the return value here, the context is
+	 * gone; For higher callers, -1 means that the syscall should
+	 * be skipped.
+	 */
+	if (syscall =3D=3D -1L)
+		syscall_set_return_value(current, regs, -ENOSYS, 0);
+
 	syscall_enter_audit(regs, syscall);
=20
 	return ret ? : syscall;
--8<--

I did a quick test of the above, and it seems to cover all the previous
bugs -- but who knows! ;-)


Bj=C3=B6rn

[1] https://lore.kernel.org/linux-riscv/59505464-c84a-403d-972f-d4b2055eeaa=
c@gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/kernel/entry/common.c#n47

