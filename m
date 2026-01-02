Return-Path: <stable+bounces-204522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E014CEF8F9
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 01:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADF1F3004EF5
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 00:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297A71F12F8;
	Sat,  3 Jan 2026 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOrsMqoL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85D209F43
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767400924; cv=none; b=e/XWJE/O/fI3Y15jcKrsZdMQ0ikfAVVhIm+PF9vKhnkc/Poz6GPiuHNnrEsbfH1UK+fG3qTb+u80rRnmh7/xdlhROaJUIMjoySJWbS30RaEqYeNRsRBUNFAQRFYylP+YJBYsvZVLpJXjH1Z9ewr9V3SkpZO17I8wOqr9Of501sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767400924; c=relaxed/simple;
	bh=J67UORjZXBYO7lqMtFHemzhBCJvKdFYD+BnAx+uh9dg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k76S8CqChUHY2oAoHcLh8TMTwZROKvHsEsas+DNI1zl934ERnE+fBUvluYw63kNeB9Jp/KVe3r8TIE2VICsMkqI95LGmDnCEnsz3pKfzZ/psblWCQRoLxPnzhz4MCYRmKM2Vc8cZMV/REyb5XHeWdSm6L3Uayo3e920kY/kQQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOrsMqoL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso16401907a12.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 16:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767400920; x=1768005720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu2XOwAewPAf2hIqWYAVG0zECJ1HMFf+2EIxiKJs26A=;
        b=fOrsMqoL8w1m4SnMmqtEDVb0A1xKA4mGbWOQ+Qa0qyIacQvNuLkMOgxjKwtBl02BNF
         9nqs/R9Ji64IxyBoxPOJ8/a1/Z5am897lY+1uTQsOmSY8eH8kKsZuDly8Q0a61spDXgh
         VtanxAcO8p7/dOZ9FQrcTcTbxYErrJCOnws68/TXjL2TUaeyYiOtUuwHopOE4E3MWXaa
         mhUjA6FUsN7PCIEAad74RM7/m+1BcN7cTeOwVaEQ+moXtvVmcmKOm4hU+EB7iesY7eML
         MgAXAqvHsqw4qCpPc5RY+wFAXgkUaohEThg/66btQ5pys2MIoI3qFL+s4hF4wnET71/9
         zctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767400920; x=1768005720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lu2XOwAewPAf2hIqWYAVG0zECJ1HMFf+2EIxiKJs26A=;
        b=wcTvSCzLzdUctY3hQ7be4rQpvKVYuFN1QvfAsNa9NBrR1eKNAJkxzLS5SjteEhZA5o
         cSNAkcybJLY30MS/P4ZfwQfKca3eLAnpxYLiYEotRGdw+3TQWivEGOphmY66WQq9tjhx
         craLVRH8lXYB1G0yuwvv8Dl3750Pc2ym2lSz9LcwjUg6HPrE8WDnr7zXzgN9+ItnE3wS
         I9qPSXhUznt80/eWb14XXb798STwdfFp6W4e4F7lQ45ov8rWHK3yFu2j85USkdxpHznB
         CLLBxMDaluFrVQuGQ8aG5dcynr10+xS24m9QBLmgSrjcGaueXqy956K/Jk8mSdp12W1p
         9PuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7oYiVad0k86Hn5FYOb0JvLp+01XebqpF/ZEaoZZTUagTvhDG7cBv0u51JJhHDHTPZYHDrxkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dhD4VejSjkHMUqBJDPRjRY5JLDDe4uLpTwgXK/JUJBqe8Gi6
	JU6jW6oBbxMrpKBsOAbVnnABDt2c2IOXJ0T2jg8/Xw7nzJ2Kg4KMqxgxxtvKvQ==
X-Gm-Gg: AY/fxX65HA4+k+2TmQv+svSj+kOjdixUkBBb3KMK3sLNTUO2XO9EVHpt2gSX1lWCGsL
	RLbYl7NI6n0Sa+gTC5kSIiSYXwVM4iFUYNdQcoS4NdbUVCpuPbPZGoU3/1V6TKXBJOzDoczD6bM
	DCKxL5/17IPXEP/wNjgGn1y9bqlT9r9XdzDJI7GxWXegIfHoT1KgbsQrLnSdFmvPp56KL3tHsl2
	9lM0snZRC3ohmqwTh3rlCRXVwDvHNulHz0abooLK1rXHAJHyyyC9K70G2Njx7IfOPb+Wz0EHeFt
	9apNxq9zXazFb4IkLvLJALqt/4CxatunOSC7RIl09qqaOfqq4suXZIXqcZfcJuL7tFJTG7St1wH
	pcdP8XbPz3oVHBEY7eDGnOUSzGWiWifUDSamul40YKhsRSjzE/8jxpIGPGHTXSyTF61ntf8WAF8
	ekBBtKl7S4CMs2UiXkd/enVuVaPHYLdYpR30t3KpXMhgNol2XmUbHu
X-Google-Smtp-Source: AGHT+IFdvdEcrAIYSA22XzNr2wKPflwtXqsVf2mK8AXHiedc5sR4d+y6uOcJKoLds0TT7gNd5aiiog==
X-Received: by 2002:a05:600c:458e:b0:47a:9560:ec28 with SMTP id 5b1f17b1804b1-47d19566d27mr540529425e9.13.1767393875116;
        Fri, 02 Jan 2026 14:44:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d452c69sm6169675e9.9.2026.01.02.14.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 14:44:34 -0800 (PST)
Date: Fri, 2 Jan 2026 22:44:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>, Jeremy
 Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] randomize_kstack: Maintain kstack_offset per
 task
Message-ID: <20260102224432.172b1247@pumpkin>
In-Reply-To: <20260102131156.3265118-2-ryan.roberts@arm.com>
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
	<20260102131156.3265118-2-ryan.roberts@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Jan 2026 13:11:52 +0000
Ryan Roberts <ryan.roberts@arm.com> wrote:

> kstack_offset was previously maintained per-cpu, but this caused a
> couple of issues. So let's instead make it per-task.
> 
> Issue 1: add_random_kstack_offset() and choose_random_kstack_offset()
> expected and required to be called with interrupts and preemption
> disabled so that it could manipulate per-cpu state. But arm64, loongarch
> and risc-v are calling them with interrupts and preemption enabled. I
> don't _think_ this causes any functional issues, but it's certainly
> unexpected and could lead to manipulating the wrong cpu's state, which
> could cause a minor performance degradation due to bouncing the cache
> lines. By maintaining the state per-task those functions can safely be
> called in preemptible context.
> 
> Issue 2: add_random_kstack_offset() is called before executing the
> syscall and expands the stack using a previously chosen rnadom offset.
                                                           <>
	David

> choose_random_kstack_offset() is called after executing the syscall and
> chooses and stores a new random offset for the next syscall. With
> per-cpu storage for this offset, an attacker could force cpu migration
> during the execution of the syscall and prevent the offset from being
> updated for the original cpu such that it is predictable for the next
> syscall on that cpu. By maintaining the state per-task, this problem
> goes away because the per-task random offset is updated after the
> syscall regardless of which cpu it is executing on.
> 
> Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
> Closes: https://lore.kernel.org/all/dd8c37bc-795f-4c7a-9086-69e584d8ab24@arm.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/randomize_kstack.h | 26 +++++++++++++++-----------
>  include/linux/sched.h            |  4 ++++
>  init/main.c                      |  1 -
>  kernel/fork.c                    |  2 ++
>  4 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> index 1d982dbdd0d0..5d3916ca747c 100644
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -9,7 +9,6 @@
>  
>  DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>  			 randomize_kstack_offset);
> -DECLARE_PER_CPU(u32, kstack_offset);
>  
>  /*
>   * Do not use this anywhere else in the kernel. This is used here because
> @@ -50,15 +49,14 @@ DECLARE_PER_CPU(u32, kstack_offset);
>   * add_random_kstack_offset - Increase stack utilization by previously
>   *			      chosen random offset
>   *
> - * This should be used in the syscall entry path when interrupts and
> - * preempt are disabled, and after user registers have been stored to
> - * the stack. For testing the resulting entropy, please see:
> - * tools/testing/selftests/lkdtm/stack-entropy.sh
> + * This should be used in the syscall entry path after user registers have been
> + * stored to the stack. Preemption may be enabled. For testing the resulting
> + * entropy, please see: tools/testing/selftests/lkdtm/stack-entropy.sh
>   */
>  #define add_random_kstack_offset() do {					\
>  	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
>  				&randomize_kstack_offset)) {		\
> -		u32 offset = raw_cpu_read(kstack_offset);		\
> +		u32 offset = current->kstack_offset;			\
>  		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));	\
>  		/* Keep allocation even after "ptr" loses scope. */	\
>  		asm volatile("" :: "r"(ptr) : "memory");		\
> @@ -69,9 +67,9 @@ DECLARE_PER_CPU(u32, kstack_offset);
>   * choose_random_kstack_offset - Choose the random offset for the next
>   *				 add_random_kstack_offset()
>   *
> - * This should only be used during syscall exit when interrupts and
> - * preempt are disabled. This position in the syscall flow is done to
> - * frustrate attacks from userspace attempting to learn the next offset:
> + * This should only be used during syscall exit. Preemption may be enabled. This
> + * position in the syscall flow is done to frustrate attacks from userspace
> + * attempting to learn the next offset:
>   * - Maximize the timing uncertainty visible from userspace: if the
>   *   offset is chosen at syscall entry, userspace has much more control
>   *   over the timing between choosing offsets. "How long will we be in
> @@ -85,14 +83,20 @@ DECLARE_PER_CPU(u32, kstack_offset);
>  #define choose_random_kstack_offset(rand) do {				\
>  	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
>  				&randomize_kstack_offset)) {		\
> -		u32 offset = raw_cpu_read(kstack_offset);		\
> +		u32 offset = current->kstack_offset;			\
>  		offset = ror32(offset, 5) ^ (rand);			\
> -		raw_cpu_write(kstack_offset, offset);			\
> +		current->kstack_offset = offset;			\
>  	}								\
>  } while (0)
> +
> +static inline void random_kstack_task_init(struct task_struct *tsk)
> +{
> +	tsk->kstack_offset = 0;
> +}
>  #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>  #define add_random_kstack_offset()		do { } while (0)
>  #define choose_random_kstack_offset(rand)	do { } while (0)
> +#define random_kstack_task_init(tsk)		do { } while (0)
>  #endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>  
>  #endif
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d395f2810fac..9e0080ed1484 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1591,6 +1591,10 @@ struct task_struct {
>  	unsigned long			prev_lowest_stack;
>  #endif
>  
> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> +	u32				kstack_offset;
> +#endif
> +
>  #ifdef CONFIG_X86_MCE
>  	void __user			*mce_vaddr;
>  	__u64				mce_kflags;
> diff --git a/init/main.c b/init/main.c
> index b84818ad9685..27fcbbde933e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -830,7 +830,6 @@ static inline void initcall_debug_enable(void)
>  #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>  DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>  			   randomize_kstack_offset);
> -DEFINE_PER_CPU(u32, kstack_offset);
>  
>  static int __init early_randomize_kstack_offset(char *buf)
>  {
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b1f3915d5f8e..b061e1edbc43 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -95,6 +95,7 @@
>  #include <linux/thread_info.h>
>  #include <linux/kstack_erase.h>
>  #include <linux/kasan.h>
> +#include <linux/randomize_kstack.h>
>  #include <linux/scs.h>
>  #include <linux/io_uring.h>
>  #include <linux/bpf.h>
> @@ -2231,6 +2232,7 @@ __latent_entropy struct task_struct *copy_process(
>  	if (retval)
>  		goto bad_fork_cleanup_io;
>  
> +	random_kstack_task_init(p);
>  	stackleak_task_init(p);
>  
>  	if (pid != &init_struct_pid) {


