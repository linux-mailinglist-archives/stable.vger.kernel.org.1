Return-Path: <stable+bounces-88233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325D9B1F1B
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 16:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18441F20FEA
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D79C16F8F5;
	Sun, 27 Oct 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwn4YrpQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0D1714A0;
	Sun, 27 Oct 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730042974; cv=none; b=b/ymYBxnrsdS2uDRmQVGbagxM65JbPjdFz6nuACL/G3JuFf65UeuRZxwN1xkxQYaVoE6mgPWl1bpld3nu6oysMgKz274llo58t6v9wb22zGSI0F252uaQMWEJriTnYzGOZntncGawuxV8QaSMUreIURCtgyPb9aA+WkiRQ9DuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730042974; c=relaxed/simple;
	bh=wfzioLG6qHWfLLFPEUfkQI8Jbf6jbo8FK6HQ3IhDkdA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aHTzUdxnIQ5f9pkmCdpyCn8rty6QJTrqoMcE/eGcDjCA9oVsQM2FrzX7PWOGLDEzhnXds7bKNWu/Sr0pSbgTwWPQKb6LfoBq32NXP/CMcF2yZbk8rGJa/aOjUl4C4GsqUPLsQtYkO9HpiqIhjyT/GJiPRCTOZhBjf4qqpyogoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwn4YrpQ; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso2411242a12.3;
        Sun, 27 Oct 2024 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730042971; x=1730647771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rodhsl2jwO/015f4VTLUGip9vsJwlnOpOG4HSAqhlNI=;
        b=Rwn4YrpQ/wH4/SVogQWFCMAuY4S7LY+c1/djbGxq8SHdCauyKPwVatpwyI4m9Dozgg
         2/PPtGNVgxpvQUxvmSOoEeJXsff7kDubeHa2YwRXp8mgimJjG8LDzrxXjurwKnRbRFY1
         f+UxDFw5KH3OUKgCqLvbKYM5f5FaYx1nScgR0IM5zJJt3lzE634RryD3TF4j2eH2Tkqt
         1oPTRvGUgICL95Hga6Qr06j5RwrHnXBl905dGvZo9of7xcfX53cb+65irlyGGYG579wh
         PfkMRy+Tm9JNrIhLtp3GsBki6M5yRC6irysYs0MiacypcgqE7ECcKpvJ2WDYaf29Knoq
         RLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730042971; x=1730647771;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rodhsl2jwO/015f4VTLUGip9vsJwlnOpOG4HSAqhlNI=;
        b=tilMt76LHk3RIiakI/hFEHiWXw/H9R9PXbjZShOYEgR4DR8mWtTgTHqFRc53zBoHwj
         NNt11NuiE2tPGVjmKFF3hpTllb1BJlQLbq2NfR1e00DtVp30mTDtZAtSzZi1pjtb1Mpw
         POraxLENPeKfkJliD4f/H9jyGYB5Rxd+uWdgjw1M6Gyd6t2Dt7gTg5h+H2Iu//iUfODo
         FkpzQHLR5vTCduVUTKXaNvcboNtJ8qHrd4EVMy3lnztSksRVgYsEC6Zg5juwHPprobp6
         EEoGZEHX6CLmmqhvNEIttn0+/OW2Bc0zIUa58LPvCTZ86wg9OiL+BuHbW3syC1jtUMIS
         QLVg==
X-Forwarded-Encrypted: i=1; AJvYcCU8g/rEQ69qAZOMwW9n0QkzrRUkgIszHq6ZsJcfechITmeLwhvh7sfISxGMCGt4UZfNUSG3clyM0IzTgm4=@vger.kernel.org, AJvYcCUA3dVzuriTMQXtIWwTue66w1YzqugQnzOpiIDur6KwJPk5S2a+6tbbS2F3nlsEr5AZV1CitqOH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6/LOpGZWzR2V5WsgLWorfEoY5tt4e+lWqSIxQFBxwLqjT1hQI
	bUM6UNS109j9SsY1UVqjFZBYlP9U9iksTjhejHQ0UDtQirTdj8ZH
X-Google-Smtp-Source: AGHT+IG2BQrmcJxVQaY8t/NaWIL5qJcI9gTvZnuGQk5uE7/amUuptYGAttmfF3//7+Rm+oTL2tx3Gw==
X-Received: by 2002:a05:6a20:c89c:b0:1d9:6adc:afd3 with SMTP id adf61e73a8af0-1d9a83c9c49mr6447043637.19.1730042970897;
        Sun, 27 Oct 2024 08:29:30 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3fddbsm4142235b3a.209.2024.10.27.08.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 08:29:30 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <3dc10d89-6c0c-4654-95ed-dd6f19efbad4@gmail.com>
Date: Sun, 27 Oct 2024 23:29:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
Content-Language: en-GB-large
To: Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
 Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <87ldya4nv0.ffs@tglx>
In-Reply-To: <87ldya4nv0.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-10-27 04:21, Thomas Gleixner wrote:
> On Fri, Oct 25 2024 at 07:30, Björn Töpel wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>> It's completely unclear to me what the actual problem is. The flow how
>>> this works on all architectures is:
>>>
>>>        regs->orig_a0  = regs->a0
>>>        regs->a0 = -ENOSYS;
>>>
>>>        nr = syscall_enter_from_user_mode(....);
>>>
>>>        if (nr >= 0)
>>>           regs->a0 = nr < MAX_SYSCALL ? syscall(nr) : -ENOSYS;
>>>                      
>>> If syscall_trace_enter() returns -1 to skip the syscall, then regs->a0
>>> is unmodified, unless one of the magic operations modified it.
>>>
>>> If syscall_trace_enter() was not active (no tracer, no seccomp ...) then
>>> regs->a0 already contains -ENOSYS.
>>>
>>> So what's the exact problem?
>>
>> It's a mix of calling convention, and UAPI:
>>   * RISC-V uses a0 for arg0 *and* return value (like arm64).
>>   * RISC-V does not expose orig_a0 to userland, and cannot easily start
>>     doing that w/o breaking UAPI.
>>
>> Now, when setting a0 to -ENOSYS, it's clobbering arg0, and the ptracer
>> will have an incorrect arg0 (-ENOSYS).
> 
> Oh I see. I was looking at it from the x86 POV... 
> 
> Looking deeper into this, this is all completely inconsistent across
> architectures. All of them copied either from x86 or from some other
> close enough existing copy and changed stuff on top.
> 
> So we have two different scenarios AFAICT (I did not look really
> deeply):
> 
>    1) The register which holds the syscall number is used for the
>       return value
> 
>    2) An argument register is used for the return value
> 
> #1 is the easy case and just "works"
> 
>    because orig_$REG holds the original syscall number and everything
>    falls into place.
> 
> #2 needs some thought, but we are not going to add this:
> 
>> 	 if (work & SYSCALL_WORK_ENTER)
>> 		 syscall = syscall_trace_enter(regs, syscall, work);
>> +	else if (syscall == -1L)
>> +		syscall_set_return_value(current, regs, -ENOSYS, 0);
>>
> 
> into the syscall path just to make #2 work. That's hotpath and affects
> all other architectures too.
> 
> So the problem for the #2 case is that there is no distinction between a
> user space issued syscall(@nr = -1) and the return value of (-1) of
> various functions involved in the syscall 'tracer' processing.
> 
> So what the issue with Celeste's change is:
> 
> 	res = syscall_enter_from_user_mode(regs, syscall);
> 	syscall = syscall_get_nr(current, regs);
> 
> 	add_random_kstack_offset();
> 
> 	if (syscall < 0 || syscall >= NR_syscalls)
>         	regs->a0 = -ENOSYS;
> 
> As the tracer can invalidate the syscall number along with regs->a0,
> this overwrites the error code set by the tracer. Your solution has a
> similar problem.

Oh. It's a real issue.

> 
> There is another issue vs. regs->a0. Assume a ptracer modified regs->a0
> (arg0) and lets the task continue (no fatal signal pending).
> 
> Then the following seccomp() invocation will get regs->orig_a0 from
> syscall_get_arguments(), which is not what the ptracer set, right?
> 
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
> 
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
> 
>>  3. seccomp filtering: Requires that the a0 is not tampered to
> 
> No. seccomp uses syscall_get_arguments() which sets a0 to orig_a0 for
> inspection. As I said before that fails when the ptracer changed
> argument 0 before the seccomp invocation. seccomp will see the original
> argument and waves it through.
> 
> Looking at Celeste's analysis again:
> 
>> We can't know whether syscall_nr is -1 when we get -1
>> from syscall_enter_from_user_mode(). And the old syscall variable is
>> unusable because syscall_enter_from_user_mode() may change a7 register.
> 
> You obviously can save the user space supplied value away
> in do_trap_ecall_u() by simply doing
> 
>        long orig_nr = regs->a7;
> 
> No? But I'm not sure that it solves all problems. It cannot solve the
> ptrace/seccomp interaction.
> 
> The rest of the changelog is simply bogus. Just because riscv made a
> mistake with the UABI design does not mean that it's useless for
> everyone else.
> 
> And no, I'm not going to change x86 for that just to have a pointless
> load in the syscall hotpath, when the normal operation just keeps the
> syscall number in the same register.
> 
> The real problem is that orig_a0 is not exposed in the user view of the
> registers. Changing that struct breaks the existing applications
> obviously.
> 
> But you can expose it without changing the struct by exposing a regset
> for orig_a0 which allows you to read and write it similar to what ARM64
> does for the syscall number.

If we add something like NT_SYSCALL_NR to UAPI, it cannot solve anything: We 
already have PTRACE_GET_SYSCALL_INFO to get syscall number, which was introduced 
in 5.3 kernel. The problem is only in the kernel before 5.3. So we can't fix 
this issue unless we also backport NT_SYSCALL_NR to 4.19 LTS. But if we can 
backport it, we can backport PTRACE_GET_SYSCALL_INFO directly instead.

That's why I try to limit changes in "internal handle logic" in all 3 tries 
before.

> 
> That of course requires updated user space, but existing user space will
> continue to work with the current limitations.
> 
> Thanks,
> 
>         tglx

