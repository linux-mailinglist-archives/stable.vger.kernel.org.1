Return-Path: <stable+bounces-88153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C4D9B037C
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EF12867B7
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939BE20BB31;
	Fri, 25 Oct 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3opULSf5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZqBU12QT"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AA1D515A;
	Fri, 25 Oct 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861939; cv=none; b=M1ZoAR7ZPWFAmVrwVJAUoCVe9vtpZPtIyHrZ8Pgtt2Dkseb1Ya3gt2WJdmFO3LloD5LMvw3PqMbwh6netCjzWVVzjp52MW+tjPktMA4gx9xS0Mag1lxbrxaMczM58QVJNMJNwFV/INv7K0afw5bevcgzjL2ou3Skw8h5Sdho7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861939; c=relaxed/simple;
	bh=LMcKy13HKOHUiARSCOxTXaBgVFPbmKvqll5xpfPJqO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lcbb+B0jsvQ8OypO3q/BKvSI7eyx5zLjIBmVxfHlJl17J/Wo6e7oFU0h8PFfiNHArXODYhaqT+kVEJ0bxO54LVczCZMJvnDx0OKN1K8x9eLuf28oI+kYIZznB5fThth3wqshRX0pyDbj35a0V9al8elawX+h1vin5beSSyEKSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3opULSf5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZqBU12QT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729861935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CCakkuEsajugg/PgpFQNY8pqc/CyoUnL2IGo8dHuAo=;
	b=3opULSf5YcYafX2XXc3JliiHlbCwCqGdZGKObFcdRQ+rSX+pTwuA8cytrXvHhUK5gErFKF
	RPhku62wfhLz+/0lUSYssEBAnaVbQ9zieb8p/caBk6VTn9CdAwmeSxwnuxxpdef5iYcRZ2
	6SVpCRRXVjZrTYvTXIJKF7QMFvWYPfc6qIxatrbQE6/nzHjbmG2D7niPCHPufjBEvCHEIs
	gE+WJDOMpNDyk07d4o9V08fus2sT8o8XEk2rFARLveFa3wr24rq8dAvO1+p9B9m3n3Oy9D
	ZITyYzhRsgv97EOdFhMuAhfsVhPd2UtfNtXXZlwmAsiK8N94EtApTWacal+aMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729861935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CCakkuEsajugg/PgpFQNY8pqc/CyoUnL2IGo8dHuAo=;
	b=ZqBU12QTzxdqkbQWnwL3tA/lmm+1CqOFPszaVKX++FHjHGFaYBmDVW7LFFl3wbDA369YLZ
	or7ODo+dQRGnnfAQ==
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Celeste Liu
 <coelacanthushex@gmail.com>,
 Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, =?utf-8?B?Qmo=?=
 =?utf-8?B?w7ZybiBUw7ZwZWw=?=
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
In-Reply-To: <8734kpqu8k.fsf@all.your.base.are.belong.to.us>
References: <20241017-fix-riscv-syscall-nr-v1-1-4edb4ca07f07@gmail.com>
 <87a5exy2rx.fsf@all.your.base.are.belong.to.us>
 <b72e3d2b-d540-47bf-adec-0ab6eda135d8@gmail.com>
 <8734kpqu8k.fsf@all.your.base.are.belong.to.us>
Date: Fri, 25 Oct 2024 15:12:14 +0200
Message-ID: <871q045ntd.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21 2024 at 09:46, Bj=C3=B6rn T=C3=B6pel wrote:
> Celeste Liu <coelacanthushex@gmail.com> writes:
>> 1. syscall_enter_from_user_mode() will do two things:
>>    1) the return value is only to inform whether the syscall should be s=
kipped.
>>    2) regs will be modified by filters (seccomp or ptrace and so on).
>> 2. for common entry user, there is two informations: syscall number and
>>    the return value of syscall_enter_from_user_mode() (called is_skipped=
 below).
>>    so there is three situations:
>>    1) if syscall number is invalid, the syscall should not be performed,=
 and
>>       we set a0 to -ENOSYS to inform userspace the syscall doesn't exist.
>>    2) if syscall number is valid, is_skipped will be used:
>>       a) if is_skipped is -1, which means there are some filters reject =
this syscall,
>>          so the syscall should not performed. (Of course, we can use boo=
l instead to
>>          get better semantic)
>>       b) if is_skipped !=3D -1, which means the filters approved this sy=
scall,
>>          so we invoke syscall handler with modified regs.
>>
>> In your design, the logical condition is not obvious. Why syscall_enter_=
from_user_mode()
>> informed the syscall will be skipped but the syscall handler will be cal=
led
>> when syscall number is invalid? The users need to think two things to ge=
t result:
>> a) -1 means skip
>> b) -1 < 0 in signed integer, so the skip condition is always a invalid s=
yscall number.
>>
>> In may way, the users only need to think one thing: The syscall_enter_fr=
om_user_mode()
>> said -1 means the syscall should not be performed, so use it as a condit=
ion of reject
>> directly. They just need to combine the informations that they get from =
API as the
>> condition of control flow.
>
> I'm all-in for simpler API usage! Maybe massage the
> syscall_enter_from_user_mode() (or a new one), so that additional
> syscall_get_nr() call is not needed?

It's completely unclear to me what the actual problem is. The flow how
this works on all architectures is:

       regs->orig_a0  =3D regs->a0
       regs->a0 =3D -ENOSYS;

       nr =3D syscall_enter_from_user_mode(....);

       if (nr >=3D 0)
          regs->a0 =3D nr < MAX_SYSCALL ? syscall(nr) : -ENOSYS;
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
If syscall_trace_enter() returns -1 to skip the syscall, then regs->a0
is unmodified, unless one of the magic operations modified it.

If syscall_trace_enter() was not active (no tracer, no seccomp ...) then
regs->a0 already contains -ENOSYS.

So what's the exact problem?

Thanks,

        tglx

