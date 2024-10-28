Return-Path: <stable+bounces-88980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 762A09B2BC0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CD4B20BA6
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0F1CC16C;
	Mon, 28 Oct 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3wIy3ym"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19437A59;
	Mon, 28 Oct 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108711; cv=none; b=gHFRd8ev59KTV8eQRJNAvRGNwGQsEkuHMBVNkVh6O8Umgk5WuzuLtrr+DNGp+wBMsmrtj+ZXzJVfBf6jfusZByr0w6TGD7qwzlWTsr4A4pchZcprUZ5ge2VNRQmZAQrfZ9UkdvusNNbFkRH/scTnjwly0gq2hwdk4tx5citYm/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108711; c=relaxed/simple;
	bh=CZVjrLe6GkPeTjP9p6IM60BaHFbsS+yZRoS0y2bNcZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sq9gLcgFcatCvfv1EdDFMdBxVCPQBMPdV3oOQppMxrOZKU7gUmvkq46GjCyAUsDbIcSygaXqamRzsVVGZqihqIMHfilEsfFQtBS5JV2HgoO2LclXBzVSCT5xFxxCYCV7hHjPPm1IVadX5CZNher2jB3g7+I7r1OLBxavifEuHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3wIy3ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313F1C4CEC3;
	Mon, 28 Oct 2024 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730108710;
	bh=CZVjrLe6GkPeTjP9p6IM60BaHFbsS+yZRoS0y2bNcZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u3wIy3ymToY+1PiSdOFhjUpnlDSk7OhjkPU07qdOpvfzCg9V4oTM07nQp5sIsHpyz
	 wgauHD8AvPi4SeXkZyzIkl1yikG/728W+gDYMNPeNnLe1njNcayN61O5aF6g8yCsXL
	 iLoWEAkjEr43JmExmPbIBRxMm96He24ZdinR83Dkif9mGfgI1BmYPhpLsQadHHt7zO
	 qZ5JYt8o/cNSnjHKlbWNzLz5C4majC3wTtUkcqhSISBY2z74iPX5CiZuVwdl743GWG
	 JzVxR81e5/osrPeW/g5u0y8drD+cz/VEy2zbvBSTmO4Zv0n+CnifxxoVL4eW4xagBW
	 TfdhTgpI/h4kw==
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
In-Reply-To: <87ldya4nv0.ffs@tglx>
References: <87ldya4nv0.ffs@tglx>
Date: Mon, 28 Oct 2024 02:45:07 -0700
Message-ID: <87sesgftng.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks for helping out to dissect this! Much appreciated!

Thomas Gleixner <tglx@linutronix.de> writes:

> Let me look at your failure analysis from your first reply:
>
>>  1. strace "tracing": Requires that regs->a0 is not tampered with prior
>>     ptrace notification
>> 
>>     E.g.:
>>     | # ./strace /
>>     | execve("/", ["/"], 0x7ffffaac3890 /* 21 vars */) = -1 EACCES (Permission denied)
>>     | ./strace: exec: Permission denied
>>     | +++ exited with 1 +++
>>     | # ./disable_ptrace_get_syscall_info ./strace /
>>     | execve(0xffffffffffffffda, ["/"], 0x7fffd893ce10 /* 21 vars */) = -1 EACCES (Permission denied)
>>     | ./strace: exec: Permission denied
>>     | +++ exited with 1 +++
>> 
>>     In the second case, arg0 is prematurely set to -ENOSYS
>>     (0xffffffffffffffda).
>
> That's expected if ptrace_get_syscall_info() is not used. Plain dumping
> registers will give you the current value on all architectures.
> ptrace_get_syscall_info() exist exactly for that reason.

Noted! So this shouldn't be considered as a regression. IOW, the
existing upstream code is OK for this scenario.

>>  2. strace "syscall tampering": Requires that ENOSYS is returned for
>>     syscall(-1), and not skipped w/o a proper return value.
>> 
>>     E.g.:
>>     | ./strace -a0 -ewrite -einject=write:error=enospc echo helloject=write:error=enospc echo hello   
>> 
>>     Here, strace expects that injecting -1, would result in a ENOSYS.
>
> No. It expects ENOSPC with the above command line. man strace:
>
>        If :error=errno option is specified, a fault is injected into a
>        syscall invocation: the syscall number is replaced by -1 which
>        corresponds to an invalid syscall (unless a syscall is specified
>        with :syscall= option), and the error code is specified using a
>        symbolic errno value like ENOSYS or a numeric value within
>        1..4095 range.
>
> Similar for -einject:retval=$N
>
> So you cannot overwrite a0 with ENOSYS if the syscall needs to be
> skipped.

ACK!

