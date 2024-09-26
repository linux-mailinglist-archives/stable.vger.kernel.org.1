Return-Path: <stable+bounces-77742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616F2986A45
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 02:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8474A1C217C0
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 00:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0C13B7A6;
	Thu, 26 Sep 2024 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZGP6SeO6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C92B9B3
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727310744; cv=none; b=TG2+ltZ9o0SRxYFnXm/bLgwDu+rRpYJ9gCtfrI0OKpNO8zfIJzmwWYGyDoLiBBdx3jhfLxU6Qv/fW+T1IjnNXPTShvBzDKyP94nKdR9ale5HVkXEEU42TgnKhpQED7aWmsvPSbc+H0Lohe6J6zvFUdG+KcAtSJWmdY68JkjDTJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727310744; c=relaxed/simple;
	bh=inhp/7je4aEb9CZ9ES0DmSVnFT/nEuo4Tkerx5rKOoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGyFpD9QZMP1O58fLKSqOu5DJxk76MxYYK9jLeS/w3qOnIvg8cynF+o91si1afifZCN/qPbACcXMGOjWnu95Zs0+TcTcISpSyW5Hr3O9W3f+sytRqthJZeZ1+iF7zqq54Pib7uvITqMxEVSO8Jz+pyXzsu95pgWlv2r+QH76ALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ZGP6SeO6; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-374c3400367so292399f8f.2
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 17:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1727310741; x=1727915541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S13MqfQIDnb7OvPgfFjzyFVlhocju1TL+JpU9vyiuK8=;
        b=ZGP6SeO6pYb8fPwwwjrUn/D2l1jDuQ5B3nJSWa7ibGV3YuAo/9BCLxXkO8EpwPZ7ty
         FEuGx0XjQgu5/BUgX0QuHT+Ct0XIaj75XK2MXrFM1m9eiEmlZyPUvNUhoCHOGvLI6y5c
         PZRjlq6sEwE9CSEyC+DSy2VlcUIEUlY2I4DBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727310741; x=1727915541;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S13MqfQIDnb7OvPgfFjzyFVlhocju1TL+JpU9vyiuK8=;
        b=Yf1BO11TPueyqhppmCOPMIlYMhb7ZkGzjLL/67jp7K54BBdor+PtV+EM50LBVvGDga
         eqPmfG3zCJ9Vk4bfBk6cg+Sc/q0EpF9r7sQlATBcTYSt0O/cWQg1sBLDsOmGB4QtNe99
         sCcAHhrMbJd4v8Nh3XFHs0t8cMSPAzBJILvMnmdfW17FOWYQUO8dpXjamBkA9QlAT4bQ
         wTfaizx+dJAtYKDDkKmh+9NcqAtYw2MGI71M8I+UBMWt8fh/9Q1m0BCU+l63+zge1t0m
         etFldf9EnnJQC489phlUDvUDquPMOOIGTe5dePmeKbOK3NXnseCJCdnMJUA8HtNfHbx+
         FOPg==
X-Forwarded-Encrypted: i=1; AJvYcCVkw2e93NB6+rQJvkHpQEhlabAOcChpOM3C1lqQK6lfwLz7P0o8wDKA/Nhylf5OHUSMCEFdpYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxINo55CgPOYKSuOkirPpn/0qmuZdmfQE4cevxTB1MddrM6GmvH
	76uDVru4Of6uUbGyiW0lh7HXg0s0jTydLvwQPs/PT1+Qshc9/p8lFSx9EVYgSa8=
X-Google-Smtp-Source: AGHT+IEuPdBjvoSrO1e3qdTNI88GrUXbnknPEOjgKXsMRBWiNcaGNsT4lgVPFis9GXjg9ZFvBhUQQg==
X-Received: by 2002:a05:6000:1141:b0:374:c90e:990c with SMTP id ffacd0b85a97d-37cc2480bcdmr3495877f8f.33.1727310740571;
        Wed, 25 Sep 2024 17:32:20 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f33df1sm284393966b.43.2024.09.25.17.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 17:32:20 -0700 (PDT)
Message-ID: <4ca44b13-2442-4d59-8716-df43c3692a8a@citrix.com>
Date: Thu, 26 Sep 2024 01:32:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] x86/bugs: Use code segment selector for VERW
 operand
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 Robert Gill <rtgill82@gmail.com>, Jari Ruusu <jariruusu@protonmail.com>,
 Brian Gerst <brgerst@gmail.com>,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
 antonio.gomez.iglesias@linux.intel.com, daniel.sneddon@linux.intel.com,
 stable@vger.kernel.org
References: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
 <20240925-fix-dosemu-vm86-v7-3-1de0daca2d42@linux.intel.com>
 <5703f2d8-7ca0-4f01-a954-c0eb1de930b4@citrix.com>
 <20240925234616.2ublphj3vbluawb3@desk> <20240926001729.2unwdxtcnnkf3k3t@desk>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240926001729.2unwdxtcnnkf3k3t@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/09/2024 1:17 am, Pawan Gupta wrote:
> On Wed, Sep 25, 2024 at 04:46:23PM -0700, Pawan Gupta wrote:
>> On Thu, Sep 26, 2024 at 12:29:00AM +0100, Andrew Cooper wrote:
>>> On 25/09/2024 11:25 pm, Pawan Gupta wrote:
>>>> Robert Gill reported below #GP in 32-bit mode when dosemu software was
>>>> executing vm86() system call:
>>>>
>>>>   general protection fault: 0000 [#1] PREEMPT SMP
>>>>   CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
>>>>   Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
>>>>   EIP: restore_all_switch_stack+0xbe/0xcf
>>>>   EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>>>>   ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
>>>>   DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
>>>>   CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
>>>>   Call Trace:
>>>>    show_regs+0x70/0x78
>>>>    die_addr+0x29/0x70
>>>>    exc_general_protection+0x13c/0x348
>>>>    exc_bounds+0x98/0x98
>>>>    handle_exception+0x14d/0x14d
>>>>    exc_bounds+0x98/0x98
>>>>    restore_all_switch_stack+0xbe/0xcf
>>>>    exc_bounds+0x98/0x98
>>>>    restore_all_switch_stack+0xbe/0xcf
>>>>
>>>> This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
>>>> are enabled. This is because segment registers with an arbitrary user value
>>>> can result in #GP when executing VERW. Intel SDM vol. 2C documents the
>>>> following behavior for VERW instruction:
>>>>
>>>>   #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
>>>> 	   FS, or GS segment limit.
>>>>
>>>> CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
>>>> space. Use %cs selector to reference VERW operand. This ensures VERW will
>>>> not #GP for an arbitrary user %ds.
>>>>
>>>> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
>>>> Cc: stable@vger.kernel.org # 5.10+
>>>> Reported-by: Robert Gill <rtgill82@gmail.com>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
>>>> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
>>>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>>>> Suggested-by: Brian Gerst <brgerst@gmail.com>
>>>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>>>> ---
>>>>  arch/x86/include/asm/nospec-branch.h | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>>>> index ff5f1ecc7d1e..e18a6aaf414c 100644
>>>> --- a/arch/x86/include/asm/nospec-branch.h
>>>> +++ b/arch/x86/include/asm/nospec-branch.h
>>>> @@ -318,12 +318,14 @@
>>>>  /*
>>>>   * Macro to execute VERW instruction that mitigate transient data sampling
>>>>   * attacks such as MDS. On affected systems a microcode update overloaded VERW
>>>> - * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
>>>> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %cs
>>>> + * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
>>>> + * 32-bit mode.
>>>>   *
>>>>   * Note: Only the memory operand variant of VERW clears the CPU buffers.
>>>>   */
>>>>  .macro CLEAR_CPU_BUFFERS
>>>> -	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
>>>> +	ALTERNATIVE "", __stringify(verw %cs:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
>>>>  .endm
>>> People ought rightly to double-take at this using %cs and not %ss. 
>>> There is a good reason, but it needs describing explicitly.  May I
>>> suggest the following:
>>>
>>> *...
>>> * In 32bit mode, the memory operand must be a %cs reference.  The data
>>> segments may not be usable (vm86 mode), and the stack segment may not be
>>> flat (espfix32).
>>> *...
>> Thanks for the suggestion. I will include this.
>>
>>>  .macro CLEAR_CPU_BUFFERS
>>> #ifdef __x86_64__
>>>     ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
>>> #else
>>>     ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
>>> #endif
>>>  .endm
>>>
>>> This also lets you drop _ASM_RIP().  It's a cute idea, but is more
>>> confusion than it's worth, because there's no such thing in 32bit mode.
>>>
>>> "%cs:_ASM_RIP(mds_verw_sel)" reads as if it does nothing, because it
>>> really doesn't in 64bit mode.
>> Right, will drop _ASM_RIP() in 32-bit mode and %cs in 64-bit mode.
> Its probably too soon for next version, pasting the patch here:
>
> ---8<---
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index e18a6aaf414c..4228a1fd2c2e 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -318,14 +318,21 @@
>  /*
>   * Macro to execute VERW instruction that mitigate transient data sampling
>   * attacks such as MDS. On affected systems a microcode update overloaded VERW
> - * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %cs
> - * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
> - * 32-bit mode.
> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
>   *
>   * Note: Only the memory operand variant of VERW clears the CPU buffers.
>   */
>  .macro CLEAR_CPU_BUFFERS
> -	ALTERNATIVE "", __stringify(verw %cs:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> +#ifdef CONFIG_X86_64
> +	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> +#else
> +	/*
> +	 * In 32bit mode, the memory operand must be a %cs reference. The data
> +	 * segments may not be usable (vm86 mode), and the stack segment may not
> +	 * be flat (ESPFIX32).
> +	 */

I was intending for this to replace the "Using %cs" sentence, as a new
paragraph in that main comment block.

Otherwise, yes, this is half of what I had in mind.

~Andrew

