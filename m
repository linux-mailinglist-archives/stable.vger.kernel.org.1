Return-Path: <stable+bounces-166742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682AFB1CE29
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 23:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE8F7A57BB
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 21:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61BA1F4C85;
	Wed,  6 Aug 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfEhpyXB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866942AA5
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514092; cv=none; b=hGh4H/Si/Hq57gUoZDmWsOBbmz10EScDaG8tyCwYVpTjVZ96swTXgY9uMXL1xBehBvORDUJxH+F3z53wOyThxdecdDzn6+iy40nYjFp+0VrGsTZ7omgVoiklEuwlqRKmQqf+Z/BYVtu6lSsLQWZzQ9/6j5hMO72slLm5/ssokjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514092; c=relaxed/simple;
	bh=qkRcfLl5ocFAY6hoi76QWQaQ78QMNSR2VzNpJiaQUj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGPvpa/ZDE8Q2fy7RFkpct3EshypK3QXV2Pabdebao0vs9/ExFzwWK6MDC5w4tjaQsbaimG56/la7SFzZ3PHIsBxItkfsgVYp9xcfdvq31fCkSpgpOS47kdV3+hHV2Iu2kG14eNSY4EDCOTtnk7NpV2mnr+wdlDl01pm7+1e0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfEhpyXB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso2406105e9.1
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754514089; x=1755118889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP35gs3R8EC0sw4SRNt/FmRmt7x6xMqmU2uMiYHePeI=;
        b=RfEhpyXByw5kAoDf7gM9Ct+QFVb4HMG8nMh2YaR8I3bcvt2wDMmjkNiIY4gYcJpb2n
         oC9qY0OFld8KRsJbQTMEuST0hRQwEJTBBCkjtJMwwEK1+PqQblYqG/hVBtrE6zFU8RLY
         FraWA1KkdDnW12TOyQh6b+MYb6Ya71BJ/FCFy7mwl3DMhfCllBbjFou08lC/lttu2h1W
         8nP1OHpgQsNuWfGCA41X3/nIac6sWunHpWtFpAAsNtqJCrIcNcZHW/Mhoc39VToLDbzh
         PzkQoQMVKx/7NqEWpMvnDVik+aUSYWL1mQWs+CS4Yljg+MUrSCcokaNpCYeF+hWnxcLA
         WXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754514089; x=1755118889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iP35gs3R8EC0sw4SRNt/FmRmt7x6xMqmU2uMiYHePeI=;
        b=K8Ms3ZEDUMeS07atD6G5NQAXy9wW6KIBe0gMUGIsDBcFw8QzSH/EarqxH5dcrCjIjM
         BM76h3yDaWa0hpVajdFmnbrpOo8MHI2hAPpgfpwOKu1uPCJQ85lbRPNrYArhVBV95X4V
         lz18dNXFm7xv5k5Nr3uTcdGGxMytI/UL2J2XTw6Ss/RcpHZk1d8AspMYxHBOhIp57rW8
         CBeuxzhobB69KjEFtjs0jmcDXS0Zzx80AMD6SnzU5XgyCtRy3IKgnYRDKMjpJXE0Za33
         sAu1iJlwnOXtc2qk1Fa3TDR9tfnsx9Ay7BBu688KLTjBh0sfUtc+zcq/kb9KFj66cNv6
         syUg==
X-Gm-Message-State: AOJu0Yz9pHNVOhXAbWZnA5A9hp8zjE8yNvktYdK3N3uw0RubyRT76+tf
	raIO7y1ZcVmRhyuBIlVRqOb4tuk8rZAi0TwrQw+Ka1qAcjDkA6sQobk6
X-Gm-Gg: ASbGncsF1+16Ghq6pyPzKjCbUaxdajPuU5DBab2Y/pvTa5PDNpeHR1El/87mkl/kMOW
	SdRj088tgGvmWCj2GY1vuLrvS3Rh/RW6P/MTxx9X/ZFOy65RoWjTfpfNMqzJ0ba1P3eTLY6/O26
	WuK4SXlA1ti4aOG2n0MlkTvUwDp1eiWun8GdLvgXqMWqDsPDb7UEuzgNk/joMjZZ51w/hguEY5c
	ta1SBJ5XyrgqouEQqp1CATTik1xoSs+X6RSLoCWTyH19ZB5WKpMGcoYNbJYn16qZHT2jVYomIk2
	QQlmjzDmjduanOGAIo4z6hQShHwwnLPB7W0YEYnwEWKnA5y6WcAPSmc3XnDouuuO4Ogqj3pyZoY
	7gqamJBcTen6y9cUs0c2id/jjLKXlYQLDPVVbnRTadL/w9ar0Bf4iXDuOrhI5FgHBLhNRh+c=
X-Google-Smtp-Source: AGHT+IFhm1CUYg071RjKeRq2juZyCxJvhEWvX0SdtQk0WqoipnWx0cOdyl44akM5AyT+b+LN1ckDxg==
X-Received: by 2002:a05:600c:4fc4:b0:458:7005:2ac3 with SMTP id 5b1f17b1804b1-459e748f99dmr36017275e9.21.1754514088838;
        Wed, 06 Aug 2025 14:01:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58554f2sm62238555e9.12.2025.08.06.14.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:01:28 -0700 (PDT)
Date: Wed, 6 Aug 2025 22:01:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jimmy Tran <jtoantran@google.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav
 Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar
 <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, David Laight
 <david.laight@aculab.com>, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v2 3/7] runtime constants: add x86 architecture support
Message-ID: <20250806220124.4c6571a2@pumpkin>
In-Reply-To: <20250806162003.1134886-4-jtoantran@google.com>
References: <20250806162003.1134886-1-jtoantran@google.com>
	<20250806162003.1134886-4-jtoantran@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Aug 2025 16:19:59 +0000
Jimmy Tran <jtoantran@google.com> wrote:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> commit e3c92e81711d14b46c3121d36bc8e152cb843923 upstream.
> 
> This implements the runtime constant infrastructure for x86, allowing
> the dcache d_hash() function to be generated using as a constant for
> hash table address followed by shift by a constant of the hash index.
> 
> Cc: <stable@vger.kernel.org> # 6.10.x: e60cc61: vfs: dcache: move hashlen_hash
> Cc: <stable@vger.kernel.org> # 6.10.x: e782985: runtime constants: add default
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jimmy Tran <jtoantran@google.com>
> ---
>  arch/x86/include/asm/runtime-const.h | 61 ++++++++++++++++++++++++++++
>  arch/x86/kernel/vmlinux.lds.S        |  3 ++
>  2 files changed, 64 insertions(+)
>  create mode 100644 arch/x86/include/asm/runtime-const.h
> 
> diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
> new file mode 100644
> index 0000000000000..76fdeaa0faa3f
> --- /dev/null
> +++ b/arch/x86/include/asm/runtime-const.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RUNTIME_CONST_H
> +#define _ASM_RUNTIME_CONST_H
> +
> +#define runtime_const_ptr(sym) ({				\
> +	typeof(sym) __ret;					\
> +	asm_inline("mov %1,%0\n1:\n"				\
> +		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
> +		".long 1b - %c2 - .\n\t"			\
> +		".popsection"					\
> +		 : "=r" (__ret)					\
> +		 : "i" (0x0123456789abcdefULL),	\

Surely for 32bit that should only be (say) 0x01234567?
Something ought to error the out of range constant.

> +		 "i" (sizeof(long)));				\
> +	__ret; })
> +
> +// The 'typeof' will create at _least_ a 32-bit type, but
> +// will happily also take a bigger type and the 'shrl' will
> +// clear the upper bits

Eh?
What are you trying to achieve.
'shrl' is a 32bit instruction, will be C0 /5 imm8.
It only makes sense to have 'unsigned int __ret = (val).
For a 64bit input you'd need to use 'shrd r/m32,r32,imm8' (0F AC ...)
(that is Intel syntax - that's the book I've got).
Since that is 'shrd low_32,high_32,count' you'd need separate
asm parameters for the low and high parts.
Only the low part is updated - which makes returning __ret incorrect
even if a 'shrd' instruction is 'magically' generated.

OTOH I've no idea what "+r" does for a 64bit variable and %k0 doesn't
seem to be in the gcc docs I'm looking at.

> +#define runtime_const_shift_right_32(val, sym) ({		\
> +	typeof(0u+(val)) __ret = (val);				\
> +	asm_inline("shrl $12,%k0\n1:\n"				\
> +		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
> +		".long 1b - 1 - .\n\t"				\
> +		".popsection"					\
> +		 : "+r" (__ret));					\
> +	__ret; })

If you want to allow a 64bit input, then something like this might work:
	u64 v = 0u + (val);
	u32 lo = v, hi = v >> 32;
	if (statically_true(hi == 0))
		asm_inline("shrl $12,%0", "+r" (lo));
	else
		asm_inline("shrd $12,%0,%1", "+r" (lo) : "r" (hi));
	lo
The "+r" could be "+rm" - but I'm not sure that'll work in a #define
and the values are pretty much needed in registers.
(Do check the at&t argument order for shrd.)

	David

> +
> +#define runtime_const_init(type, sym) do {		\
> +	extern s32 __start_runtime_##type##_##sym[];	\
> +	extern s32 __stop_runtime_##type##_##sym[];	\
> +	runtime_const_fixup(__runtime_fixup_##type,	\
> +		(unsigned long)(sym),				\
> +		__start_runtime_##type##_##sym,		\
> +		__stop_runtime_##type##_##sym);		\
> +} while (0)
> +
> +/*
> + * The text patching is trivial - you can only do this at init time,
> + * when the text section hasn't been marked RO, and before the text
> + * has ever been executed.
> + */
> +static inline void __runtime_fixup_ptr(void *where, unsigned long val)
> +{
> +	*(unsigned long *)where = val;
> +}
> +
> +static inline void __runtime_fixup_shift(void *where, unsigned long val)
> +{
> +	*(unsigned char *)where = val;
> +}
> +
> +static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
> +	unsigned long val, s32 *start, s32 *end)
> +{
> +	while (start < end) {
> +		fn(*start + (void *)start, val);
> +		start++;
> +	}
> +}
> +
> +#endif
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index c57d5df1abc60..cb5b41480a848 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -371,6 +371,9 @@ SECTIONS
>  	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
>  #endif
>  
> +	RUNTIME_CONST(shift, d_hash_shift)
> +	RUNTIME_CONST(ptr, dentry_hashtable)
> +
>  	. = ALIGN(PAGE_SIZE);
>  
>  	/* freed after init ends here */


