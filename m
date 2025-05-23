Return-Path: <stable+bounces-146196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93B7AC2294
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 14:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2DF1C02C4B
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756AE23C4E3;
	Fri, 23 May 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd+GOq3U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250A224243;
	Fri, 23 May 2025 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003018; cv=none; b=CHR3NB1AxJzqNPrqzFRYGEcKOLt99O3n8bpekVEwYjwGAEm513EsiQAYpyKnUazwPvm7WG9JdZkcRXhuEL+kjRcrzFZcMDgNGPPyXd0POagiETHB+H/VixRQpUAbM3ORVpx6mcaf4dM4P4pM/7pJMv0as39f07JSD6M+fuh948I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003018; c=relaxed/simple;
	bh=2YXTyuWiucs9t9ZnyDJa/Sndy917iIIa9KeByAWUCb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMmd8879SpGB9tcsA/JKJj3PA2APABpnQHNsYgRyTq8ssNvGtfQ5PuMlETS/KnY2eCyzRWcH0KyWKl1PhcUQXTv8adiwD/YGRmGPc4ZcdL/iKe1NIUi0QDRdCVGFXI0PbuLlIj+XzYbZIUuRTy+dfftjUvcY2C4dg962fufYI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd+GOq3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7707FC4CEE9;
	Fri, 23 May 2025 12:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748003017;
	bh=2YXTyuWiucs9t9ZnyDJa/Sndy917iIIa9KeByAWUCb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cd+GOq3UExxvah8NeYyeKueCctnzcBnOlougUAjSgk6C3EG2xbUq5Ty7dj1jUe9rC
	 TIIblBWJM9u98FVIPUyieLLqQGqNRjWrqtOpfjFwnvTrWBToqkD89um5lJ0XsBto1+
	 rr0UiG8sQCn+afNK00J7xY4pZ4EDLd4yTVpGoV9nQjxDEg5lfAq42u5cYoeeRtGAZc
	 NDtkD3tkBkOK6+UkxwoX1RBIizxYeo9GBQozx/xdBn7Semgo9l7Y7eUFLGSWQ4SO8P
	 zdGVBSYiGNPBIb47lqP8lBsWqR/qqAaUdoDF9xKhf/MbI1bx3qNDFoqY2w5T9PCpUF
	 pnsc/zzUVnGyg==
Date: Fri, 23 May 2025 08:23:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	brgerst@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: Patch "x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations"
 has been added to the 6.14-stable tree
Message-ID: <aDBoxEL3_0rpplFl@lappy>
References: <20250522213009.3137023-1-sashal@kernel.org>
 <20250522230101.GA1911411@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522230101.GA1911411@ax162>

On Thu, May 22, 2025 at 04:01:01PM -0700, Nathan Chancellor wrote:
>On Thu, May 22, 2025 at 05:30:09PM -0400, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
>>
>> to the 6.14-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      x86-relocs-handle-r_x86_64_rex_gotpcrelx-relocations.patch
>> and it can be found in the queue-6.14 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit d8e603969259e50aa632d1a3fde8883f41e26150
>> Author: Brian Gerst <brgerst@gmail.com>
>> Date:   Thu Jan 23 14:07:37 2025 -0500
>>
>>     x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
>>
>>     [ Upstream commit cb7927fda002ca49ae62e2782c1692acc7b80c67 ]
>>
>>     Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
>>     stack protector location.  Treat them as another type of PC-relative
>>     relocation.
>>
>>     Signed-off-by: Brian Gerst <brgerst@gmail.com>
>>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>>     Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>     Link: https://lore.kernel.org/r/20250123190747.745588-6-brgerst@gmail.com
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
>> index e937be979ec86..92a1e503305ef 100644
>> --- a/arch/x86/tools/relocs.c
>> +++ b/arch/x86/tools/relocs.c
>> @@ -32,6 +32,11 @@ static struct relocs		relocs32;
>>  static struct relocs		relocs32neg;
>>  static struct relocs		relocs64;
>>  # define FMT PRIu64
>> +
>> +#ifndef R_X86_64_REX_GOTPCRELX
>> +# define R_X86_64_REX_GOTPCRELX 42
>> +#endif
>> +
>>  #else
>>  # define FMT PRIu32
>>  #endif
>> @@ -227,6 +232,7 @@ static const char *rel_type(unsigned type)
>>  		REL_TYPE(R_X86_64_PC16),
>>  		REL_TYPE(R_X86_64_8),
>>  		REL_TYPE(R_X86_64_PC8),
>> +		REL_TYPE(R_X86_64_REX_GOTPCRELX),
>>  #else
>>  		REL_TYPE(R_386_NONE),
>>  		REL_TYPE(R_386_32),
>> @@ -861,6 +867,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
>>
>>  	case R_X86_64_PC32:
>>  	case R_X86_64_PLT32:
>> +	case R_X86_64_REX_GOTPCRELX:
>>  		/*
>>  		 * PC relative relocations don't need to be adjusted unless
>>  		 * referencing a percpu symbol.
>
>Didn't Ard just say this has no purpose in stable?
>
>https://lore.kernel.org/CAMj1kXGtasdqRPn8koNN095VEEU4K409QvieMdgGXNUK0kPgkw@mail.gmail.com/

Indeed! This was an issue with my scripts and happened to ~10 more
commits I was dropping. I've now dropped all of those.

Sorry for the noise and thanks for catching this!

-- 
Thanks,
Sasha

