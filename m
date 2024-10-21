Return-Path: <stable+bounces-87596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF569A6FFD
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B94B211C6
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326BA1CF5EC;
	Mon, 21 Oct 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD+rLbws"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F0547A73;
	Mon, 21 Oct 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529197; cv=none; b=tdlCbl9okBccslgldPqt1QJu4AI2O+0nJNLnsDfq7KckPXZXLEHXiknFEgE2I6l9e/XbYM/syUo6cPDpuHCbdD9GuAM1alyKr+vkTKMvmrcl9aF+p8TTrtQXDssoki+AUg4XdhEs3jwGS9/pN3140RyCtq97HTMbav4dRqO6FB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529197; c=relaxed/simple;
	bh=A0FkUr4PZGC3BJ8Tf522Ac9/Uph3gtwc+TMsH4zYyVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W47+OSksDWYzwyLpkJOWj6n/MX3UBOb3SzEpbkPeSugiSuRKnl9ItLXC0qx1LhtKUM6yGCPWb7fO1zHXvfO6y7zL3vJLD2DdIFTC9G5fHiMdHgOHubplaIaE7Br/qUcHEcap+EqFKtLLea9U+RHWZY/hvl/9d9KzDJucquJaZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DD+rLbws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F7FC4CEC3;
	Mon, 21 Oct 2024 16:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729529196;
	bh=A0FkUr4PZGC3BJ8Tf522Ac9/Uph3gtwc+TMsH4zYyVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DD+rLbwstiSB8PKB5/d1WjmMXMFhcAAK58egPR6pUSAR3H3bqmc2t8dv68/I4/hsR
	 QAKEb4CcfzaE5hYedcmChP6/cdE9WGdnHoIRn1Bz/gUBP3XFE8W1ZegxGy5L7c7OSQ
	 uXEas5hD9Jx9hPkS1K+fj/mOIZUPIwO0RP60EBm+VU/xXxdF5LrnhlQ3ebjeCwrWvx
	 C6BlN7joE6wD3MvhkxOKQCvXYVK0yo5WJsYgwUqweHTBq9D/HCPmS+00tgmRSWyCWw
	 hCFxcHWljR2xjQQWcCD5rYOGhK1kZnewuH3s3nds5QegnmTrzopmuHAqyryC9rEDqp
	 vVYrjxlbJ3f6g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Celeste Liu <coelacanthushex@gmail.com>, Celeste Liu via B4 Relay
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
 stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
In-Reply-To: <b72e3d2b-d540-47bf-adec-0ab6eda135d8@gmail.com>
References: <20241017-fix-riscv-syscall-nr-v1-1-4edb4ca07f07@gmail.com>
 <87a5exy2rx.fsf@all.your.base.are.belong.to.us>
 <b72e3d2b-d540-47bf-adec-0ab6eda135d8@gmail.com>
Date: Mon, 21 Oct 2024 09:46:35 -0700
Message-ID: <8734kpqu8k.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Celeste Liu <coelacanthushex@gmail.com> writes:

>>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>> index 51ebfd23e0076447518081d137102a9a11ff2e45..3125fab8ee4af468ace9f69=
2dd34e1797555cce3 100644
>>> --- a/arch/riscv/kernel/traps.c
>>> +++ b/arch/riscv/kernel/traps.c
>>> @@ -316,18 +316,25 @@ void do_trap_ecall_u(struct pt_regs *regs)
>>>  {
>>>  	if (user_mode(regs)) {
>>>  		long syscall =3D regs->a7;
>>> +		long res;
>>>=20=20
>>>  		regs->epc +=3D 4;
>>>  		regs->orig_a0 =3D regs->a0;
>>> -		regs->a0 =3D -ENOSYS;
>>>=20=20
>>>  		riscv_v_vstate_discard(regs);
>>>=20=20
>>> -		syscall =3D syscall_enter_from_user_mode(regs, syscall);
>>> +		res =3D syscall_enter_from_user_mode(regs, syscall);
>>> +		/*
>>> +		 * Call syscall_get_nr() again because syscall_enter_from_user_mode()
>>> +		 * may change a7 register.
>>> +		 */
>>> +		syscall =3D syscall_get_nr(current, regs);
>>>=20=20
>>>  		add_random_kstack_offset();
>>>=20=20
>>> -		if (syscall >=3D 0 && syscall < NR_syscalls)
>>> +		if (syscall < 0 || syscall >=3D NR_syscalls)
>>> +			regs->a0 =3D -ENOSYS;
>>> +		else if (res !=3D -1)
>>>  			syscall_handler(regs, syscall);
>>=20
>> Here we can perform the syscall, even if res is -1. E.g., if this path
>> [2] is taken, we might have a valid syscall number in a7, but the
>> syscall should not be performed.
>
> I may misunderstand what you said, but I can't see the issue you pointed.
> A syscall is performed iff
>
> 1) syscall number in a7 must be valid, so it can reach "else if" branch.
> 2) res !=3D -1, so syscall_enter_from_user_mode() doesn't return -1 to
>    inform the syscall should be skipped.

Ah, indeed. Apologies, that'll work!

Related, now wont this reintroduce the seccomp filtering problem? Say,
res is -1 *and* syscall invalid, then a0 updated by seccomp will be
overwritten here?

>> Also, one reason for the generic entry is so that it should be less
>> work. Here, you pull (IMO) details that belong to the common entry
>> implementation/API up the common entry user. Wdyt about pushing it down
>> to common entry? Something like:
>
> Yeah, we can. But I pull it out of common entry to get more simple API se=
mantic:
>
> 1. syscall_enter_from_user_mode() will do two things:
>    1) the return value is only to inform whether the syscall should be sk=
ipped.
>    2) regs will be modified by filters (seccomp or ptrace and so on).
> 2. for common entry user, there is two informations: syscall number and
>    the return value of syscall_enter_from_user_mode() (called is_skipped =
below).
>    so there is three situations:
>    1) if syscall number is invalid, the syscall should not be performed, =
and
>       we set a0 to -ENOSYS to inform userspace the syscall doesn't exist.
>    2) if syscall number is valid, is_skipped will be used:
>       a) if is_skipped is -1, which means there are some filters reject t=
his syscall,
>          so the syscall should not performed. (Of course, we can use bool=
 instead to
>          get better semantic)
>       b) if is_skipped !=3D -1, which means the filters approved this sys=
call,
>          so we invoke syscall handler with modified regs.
>
> In your design, the logical condition is not obvious. Why syscall_enter_f=
rom_user_mode()
> informed the syscall will be skipped but the syscall handler will be call=
ed
> when syscall number is invalid? The users need to think two things to get=
 result:
> a) -1 means skip
> b) -1 < 0 in signed integer, so the skip condition is always a invalid sy=
scall number.
>
> In may way, the users only need to think one thing: The syscall_enter_fro=
m_user_mode()
> said -1 means the syscall should not be performed, so use it as a conditi=
on of reject
> directly. They just need to combine the informations that they get from A=
PI as the
> condition of control flow.

I'm all-in for simpler API usage! Maybe massage the
syscall_enter_from_user_mode() (or a new one), so that additional
syscall_get_nr() call is not needed?


Bj=C3=B6rn

