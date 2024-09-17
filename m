Return-Path: <stable+bounces-76624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BA397B5D1
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 00:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093D51F25F7A
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 22:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1DE193425;
	Tue, 17 Sep 2024 22:32:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3787F178363;
	Tue, 17 Sep 2024 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612324; cv=none; b=lKJEkaM//ooJG7QS/vWXW+p2TJyq4J1NFxmjUPaWefLC2K/GOhB8SZYkjYJEX7T0rudM8MY5s2oerhnrcxs36u1K8gXGR1hKGNznPR4bnzTc3cSLz8cdlaIeB6+L2NK2ajd7wMX/aCDzKADiFUMtHzXAivrP6CMEiqJYe0D6WPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612324; c=relaxed/simple;
	bh=IMndr9K3NQ2VfXAd4kjGDI4l5XyHnbEZiBW+Havw5p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWnuEwShAP8Pa5JXYdMg8mVQClqC4qInTgfIEnal5QetWbZ+rryEG+WbDdMpHxasrAjx4jwciw3nvMFK795XQ/G/k7S+xzx6N6B/RJ5DN0DAclIP52CGaPK23uRlWo7BTM6BO+gFoIgKXPt8+X/DQCmkdnieazHy49iSwtwEUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id EE57A72C8CC;
	Wed, 18 Sep 2024 01:22:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id D77587CCB3C; Wed, 18 Sep 2024 01:22:26 +0300 (IDT)
Date: Wed, 18 Sep 2024 01:22:26 +0300
From: "Dmitry V . Levin" <ldv@strace.io>
To: Celeste Liu <coelacanthushex@gmail.com>,
	Andrea Bolognani <abologna@redhat.com>
Cc: linux-riscv@lists.infradead.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: entry: always initialize regs->a0 to -ENOSYS
Message-ID: <20240917222226.GA25527@altlinux.org>
References: <20240627142338.5114-2-CoelacanthusHex@gmail.com>
 <CABJz62PRAv0QqszOTHDUdrrgY-Za9y9Vq6mYke=FqP=N5qXvbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABJz62PRAv0QqszOTHDUdrrgY-Za9y9Vq6mYke=FqP=N5qXvbw@mail.gmail.com>

On Tue, Sep 17, 2024 at 01:49:52AM +0900, Andrea Bolognani wrote:
> On Thu, Jun 27, 2024 at 10:23:39PM GMT, Celeste Liu wrote:
> > Otherwise when the tracer changes syscall number to -1, the kernel fails
> > to initialize a0 with -ENOSYS and subsequently fails to return the error
> > code of the failed syscall to userspace. For example, it will break
> > strace syscall tampering.
> >
> > Fixes: 52449c17bdd1 ("riscv: entry: set a0 = -ENOSYS only when syscall != -1")
> > Reported-by: "Dmitry V. Levin" <ldv@strace.io>
> > Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> > ---
> >  arch/riscv/kernel/traps.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 05a16b1f0aee..51ebfd23e007 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -319,6 +319,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
> >
> >  		regs->epc += 4;
> >  		regs->orig_a0 = regs->a0;
> > +		regs->a0 = -ENOSYS;
> >
> >  		riscv_v_vstate_discard(regs);
> >
> > @@ -328,8 +329,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
> >
> >  		if (syscall >= 0 && syscall < NR_syscalls)
> >  			syscall_handler(regs, syscall);
> > -		else if (syscall != -1)
> > -			regs->a0 = -ENOSYS;
> > +
> >  		/*
> >  		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> >  		 * so the maximum stack offset is 1k bytes (10 bits).
> 
> Hi,
> 
> this change seems to have broken strace's test suite.
> 
> In particular, the "legacy_syscall_info" test, which is meant to
> verify that strace behaves correctly when PTRACE_GET_SYSCALL_INFO is
> not available, reports a bogus value for the first argument of the
> syscall (the one passed via a0).
> 
> The bogus value comes directly from the ptrace() call, before strace
> has a chance to meddle with it, hence why the maintainer suggested
> that the issue would likely be traced back to the kernel.
> 
> I have built a kernel with this change reverted and, as expected, the
> strace test suite passes. Admittedly I've used the 6.11-rc7 Fedora
> kernel as the baseline for this test, but none of the Fedora patches
> touch the RISC-V code at all and the file itself hasn't been touched
> since rc7, so I'm fairly confident the same behavior is present in
> vanilla 6.11 too.
> 
> See
> 
>   https://github.com/strace/strace/issues/315
> 
> for the original report. Please let me know if I need to provide
> additional information, report this anywhere else (bugzilla?), and so
> on...

By the way, in strace we had to apply a workaround [1] for the riscv ptrace
regression caused by commit 52449c17bdd1540940e21511612b58acebc49c06.

As result, reverting commit 61119394631f219e23ce98bcc3eb993a64a8ea64 that
fixed the regression but introduced a PTRACE_GETREGSET syscall argument
clobbering which is more serious regression seems to be the least of two
evils.

This essentially means strace would have to keep the workaround
indefinitely, but we can live with that.

[1] https://github.com/strace/strace/commit/c3ae2b27732952663a3600269884e363cb77a024


-- 
ldv

