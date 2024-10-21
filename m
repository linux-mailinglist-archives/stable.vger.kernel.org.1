Return-Path: <stable+bounces-87584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003709A6E03
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207651C21434
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C07C12F588;
	Mon, 21 Oct 2024 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMQ3zHfU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126C12D1FA;
	Mon, 21 Oct 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524210; cv=none; b=Wdfoj1qLcAK9RaTUVqFXxphrO/oUYcaMcmexodbZXdrLf4wQY+SlVGWpLXMDmNQuYDVXYalWRHaK1l0uQZtt1FUsLNm8vwQMnkI3bR6Eb7A2G5JOFCA3ZIwjY9zfzYngUqlp5n/eUu+JVWzuPklVs3zIf03Eyh/Kzkg7rxxKlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524210; c=relaxed/simple;
	bh=WQgFcD4tHwIFRpsSMjrwLXeA3w+pkYq71Q/uLvstKrk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fCUNfRgE6aXmPHiO9Iv5U67+7zGaYb+nYybBripn6jZ+Z2YRe4lYUL3ruBMxJoIXATZZmCjGFQvwn8AEbxbvREsEnpEQCRmmDZAval3jzfLiKVaU/nP7u+IBcqw13oY9Snhfq0HrvI+0vZZCsMZnW0OO5ihLseOrCh2w9jcu3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMQ3zHfU; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71ec1216156so1244140b3a.2;
        Mon, 21 Oct 2024 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729524207; x=1730129007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7efAql/yYxD0cxsxGeq4UphWW+duZvJqOo/OnkMT6Rg=;
        b=MMQ3zHfUnL4YTHMXaYtmmoHX4AvdcwplpuliQwxfYpiSLI0RLSSntl5p/oFwBb9nYu
         AYx48Eb7vnOS9JDRFnsBdzPJwRiBJ8Nl3EaP9hzVVbCKXrGV8X7J64waDI3nzwPjE04E
         N2hha9sokyLda2VO9uGBAHeOqdTjr9BoVIyyzjfqSq7d6D4fTdAVRSRA6SbYLSy95VrJ
         iQG25kjDLWrca9kTTlNVFmxrrIMVBrPk+rMMK6ZATbrWH+/E1ah4iiyyY/6C3n8jr54U
         T7gytwnyUAgH88WgKMmU4OFJnXz5PkyQZNQ3H9I6p+e+hyjy/IIvfbNNwI2Ch6OJiLl3
         TDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524207; x=1730129007;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7efAql/yYxD0cxsxGeq4UphWW+duZvJqOo/OnkMT6Rg=;
        b=nctlN6ybTRiw60frSkT9/Xi46uTOudpx3HPi+ezS8JkLr4MubSPfrgMCPcJ4BDn69b
         nfntGaCIGuZDmg0oycZwVsKEQkGo0PQu6beW2ACo3leXTI2x6N4103mmOU+OzgmcaW8g
         YPkG0JoYF2qhJA3/iqMPhmaEv7lZL/xOCmJeWTJgSmlspVJ5wtUkDm1aHL8khvr8DHgL
         aSbA0grS0GaSLehKOhL4NYd1PjnLFnsA85IrGEclSnHRUcaRh4SRLw7Js1491a4b7bd1
         VAftd95LeABK6YSuFudAljhXOBicVqWNU9js4r2onCldZ8PGLOVmOVQq1reYL6mVNaYX
         E3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVOUNASBcd2WQYHa5SnobyMLi0fI9CYPZ/rD4OydjMoKuUho1/4LDsSVlG7hMR0wYgcotEamyi3a3ylyh8=@vger.kernel.org, AJvYcCX52puN50vkplIPakv5gPGLVv7AUd+nPrjBYsX7bY1Ogb/T42l/m7AoOW4D1fsdntY5YzQd0euE@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqDke6MhTvX3Vfm8g6ZH8/IviwI53uEX3FzI8pN/Mqt6Lkuw5
	QqqE+B0jWVsaJAtLqps3Ourv9iR9+JTSrKB9TGysxl15R4p6iIKD
X-Google-Smtp-Source: AGHT+IGAVWNHHEKLcBCcOvRlXOhjRvV8Y5ZNMgMxykZnhrMxuYGP6buWPdnAqUHOKHME+nyb+U2RTg==
X-Received: by 2002:a05:6a00:3908:b0:71e:695:41ee with SMTP id d2e1a72fcca58-71ea31a605cmr15006697b3a.5.1729524206849;
        Mon, 21 Oct 2024 08:23:26 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec133370bsm3018995b3a.79.2024.10.21.08.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:23:26 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <b72e3d2b-d540-47bf-adec-0ab6eda135d8@gmail.com>
Date: Mon, 21 Oct 2024 23:23:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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
 stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20241017-fix-riscv-syscall-nr-v1-1-4edb4ca07f07@gmail.com>
 <87a5exy2rx.fsf@all.your.base.are.belong.to.us>
Content-Language: en-GB-large
In-Reply-To: <87a5exy2rx.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-10-21 22:00, Björn Töpel wrote:

> Celeste!
> 
> I'll pick up your thread [1] here, since there's code here! :-) Let's
> try to clear up/define the possible flow.
> 
> The common/generic entry syscall_enter_from_user_mode{,_work}() says
> that a return value of -1 means that the syscall should be skipped.
> 
> The RISC-V calling convention uses the same register for arg0/retval
> (a0). So, when a ptracer (PTRACE_SYSCALL+PTRACE_GETREGS). That means
> that the kernel cannot call into the tracer, *after* changing a0.
> 
> The interesting flow for a syscall is roughly:
> 1. The exception/trap function
> 2. syscall_enter_from_user_mode() which might return -1, meaning that
>    the syscall should be skipped. A tracer might have altered the
>    regs. More importantly, if it's -1 the kernel cannot change the
>    return value, because seccomp filtering might already done that.
> 3. If it's a valid syscall, perform the syscall.
> 
> Now some scenarios:
> * A user does a valid syscall.
> * A user does an invalid syscall(-1)
> * A user does an invalid syscall(!= -1)
> 
> Then there're the tracing variants of those, and that's where we go get
> trouble.
> 
> Now the bugs we've seen in RISC-V:
> 
> 1. strace "tracing": Requires that regs->a0 is not tampered with prior
>    ptrace notification
> 
>    E.g.:
>    | # ./strace /
>    | execve("/", ["/"], 0x7ffffaac3890 /* 21 vars */) = -1 EACCES (Permission denied)
>    | ./strace: exec: Permission denied
>    | +++ exited with 1 +++
>    | # ./disable_ptrace_get_syscall_info ./strace /
>    | execve(0xffffffffffffffda, ["/"], 0x7fffd893ce10 /* 21 vars */) = -1 EACCES (Permission denied)
>    | ./strace: exec: Permission denied
>    | +++ exited with 1 +++
> 
>    In the second case, arg0 is prematurely set to -ENOSYS
>    (0xffffffffffffffda).
> 
> 2. strace "syscall tampering": Requires that ENOSYS is returned for
>    syscall(-1), and not skipped w/o a proper return value.
>    
>    E.g.:
>    | ./strace -a0 -ewrite -einject=write:error=enospc echo helloject=write:error=enospc echo hello   
>    
>    Here, strace expects that injecting -1, would result in a ENOSYS.
> 
> 3. seccomp filtering: Requires that the a0 is not tampered to
> 
> First 3 was broken (tampering with a0 after seccomp), then 2 was
> broken (not setting ENOSYS for -1), and finally 1 was broken (and
> still is!).
> 
> Now for your patch:
> 
> Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>
> writes:
> 
>> From: Celeste Liu <CoelacanthusHex@gmail.com>
>>
>> The return value of syscall_enter_from_user_mode() is always -1 when the
>> syscall was filtered. We can't know whether syscall_nr is -1 when we get -1
>> from syscall_enter_from_user_mode(). And the old syscall variable is
>> unusable because syscall_enter_from_user_mode() may change a7 register.
>> So get correct syscall number from syscall_get_nr().
>>
>> So syscall number part of return value of syscall_enter_from_user_mode()
>> is completely useless. We can remove it from API and require caller to
>> get syscall number from syscall_get_nr(). But this change affect more
>> architectures and will block more time. So we split it into another
>> patchset to avoid block this fix. (Other architectures can works
>> without this change but riscv need it, see Link: tag below)
>>
>> Fixes: 61119394631f ("riscv: entry: always initialize regs->a0 to -ENOSYS")
>> Reported-by: Andrea Bolognani <abologna@redhat.com>
>> Closes: https://github.com/strace/strace/issues/315
>> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>> ---
>>  arch/riscv/kernel/traps.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index 51ebfd23e0076447518081d137102a9a11ff2e45..3125fab8ee4af468ace9f692dd34e1797555cce3 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -316,18 +316,25 @@ void do_trap_ecall_u(struct pt_regs *regs)
>>  {
>>  	if (user_mode(regs)) {
>>  		long syscall = regs->a7;
>> +		long res;
>>  
>>  		regs->epc += 4;
>>  		regs->orig_a0 = regs->a0;
>> -		regs->a0 = -ENOSYS;
>>  
>>  		riscv_v_vstate_discard(regs);
>>  
>> -		syscall = syscall_enter_from_user_mode(regs, syscall);
>> +		res = syscall_enter_from_user_mode(regs, syscall);
>> +		/*
>> +		 * Call syscall_get_nr() again because syscall_enter_from_user_mode()
>> +		 * may change a7 register.
>> +		 */
>> +		syscall = syscall_get_nr(current, regs);
>>  
>>  		add_random_kstack_offset();
>>  
>> -		if (syscall >= 0 && syscall < NR_syscalls)
>> +		if (syscall < 0 || syscall >= NR_syscalls)
>> +			regs->a0 = -ENOSYS;
>> +		else if (res != -1)
>>  			syscall_handler(regs, syscall);
> 
> Here we can perform the syscall, even if res is -1. E.g., if this path
> [2] is taken, we might have a valid syscall number in a7, but the
> syscall should not be performed.

I may misunderstand what you said, but I can't see the issue you pointed.
A syscall is performed iff

1) syscall number in a7 must be valid, so it can reach "else if" branch.
2) res != -1, so syscall_enter_from_user_mode() doesn't return -1 to
   inform the syscall should be skipped.

If [2] path is taken, syscall_trace_enter() will return -1 and pass through
syscall_enter_from_user_mode() so res == -1, the syscall will not be performed.

> 
> Also, one reason for the generic entry is so that it should be less
> work. Here, you pull (IMO) details that belong to the common entry
> implementation/API up the common entry user. Wdyt about pushing it down
> to common entry? Something like:

Yeah, we can. But I pull it out of common entry to get more simple API semantic:

1. syscall_enter_from_user_mode() will do two things:
   1) the return value is only to inform whether the syscall should be skipped.
   2) regs will be modified by filters (seccomp or ptrace and so on).
2. for common entry user, there is two informations: syscall number and
   the return value of syscall_enter_from_user_mode() (called is_skipped below).
   so there is three situations:
   1) if syscall number is invalid, the syscall should not be performed, and
      we set a0 to -ENOSYS to inform userspace the syscall doesn't exist.
   2) if syscall number is valid, is_skipped will be used:
      a) if is_skipped is -1, which means there are some filters reject this syscall,
         so the syscall should not performed. (Of course, we can use bool instead to
         get better semantic)
      b) if is_skipped != -1, which means the filters approved this syscall,
         so we invoke syscall handler with modified regs.

In your design, the logical condition is not obvious. Why syscall_enter_from_user_mode()
informed the syscall will be skipped but the syscall handler will be called
when syscall number is invalid? The users need to think two things to get result:
a) -1 means skip
b) -1 < 0 in signed integer, so the skip condition is always a invalid syscall number.

In may way, the users only need to think one thing: The syscall_enter_from_user_mode()
said -1 means the syscall should not be performed, so use it as a condition of reject
directly. They just need to combine the informations that they get from API as the
condition of control flow.

> 
> --8<--
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 51ebfd23e007..66fded8e4b60 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -319,7 +319,6 @@ void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		regs->epc += 4;
>  		regs->orig_a0 = regs->a0;
> -		regs->a0 = -ENOSYS;
>  
>  		riscv_v_vstate_discard(regs);
>  
> @@ -329,6 +328,8 @@ void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		if (syscall >= 0 && syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
> +		else if (syscall != -1)
> +			regs->a0 = -ENOSYS;
>  
>  		/*
>  		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 1e50cdb83ae5..9b69c2ad4f12 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -14,6 +14,7 @@
>  #include <linux/kmsan.h>
>  
>  #include <asm/entry-common.h>
> +#include <asm/syscall.h>
>  
>  /*
>   * Define dummy _TIF work flags if not defined by the architecture or for
> @@ -166,6 +167,8 @@ static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *re
>  
>  	if (work & SYSCALL_WORK_ENTER)
>  		syscall = syscall_trace_enter(regs, syscall, work);
> +	else if (syscall == -1L)
> +		syscall_set_return_value(current, regs, -ENOSYS, 0);
>  
>  	return syscall;
>  }
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 5b6934e23c21..99742aee5002 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -43,8 +43,10 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  	/* Handle ptrace */
>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
>  		ret = ptrace_report_syscall_entry(regs);
> -		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
> +		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU)) {
> +			syscall_set_return_value(current, regs, -ENOSYS, 0);
>  			return -1L;
> +		}
>  	}
>  
>  	/* Do seccomp after ptrace, to catch any tracer changes. */
> @@ -66,6 +68,14 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  		syscall = syscall_get_nr(current, regs);
>  	}
>  
> +	/*
> +	 * If we're not setting the return value here, the context is
> +	 * gone; For higher callers, -1 means that the syscall should
> +	 * be skipped.
> +	 */
> +	if (syscall == -1L)
> +		syscall_set_return_value(current, regs, -ENOSYS, 0);
> +
>  	syscall_enter_audit(regs, syscall);
>  
>  	return ret ? : syscall;
> --8<--
> 
> I did a quick test of the above, and it seems to cover all the previous
> bugs -- but who knows! ;-)
> 
> 
> Björn
> 
> [1] https://lore.kernel.org/linux-riscv/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/entry/common.c#n47


