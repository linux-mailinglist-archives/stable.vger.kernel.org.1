Return-Path: <stable+bounces-77795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0049875FF
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B01D28BE1D
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEEA146A7A;
	Thu, 26 Sep 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhMTbOME"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665D4085D;
	Thu, 26 Sep 2024 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362379; cv=none; b=NUcO9HqIP/nMLGKffGxDNM3t0uK71w69RWA3ol+P83z+VPCzwm1FVJKgddvAx+/zFZoPy1EqNckF9T1HpAni2w2PJDV3iVNT+hwvQMOgva7uVmDgwEApwPIrl0otELJKAwxLPPTmSqzmzcEoPHhw5JTmx+qQNhL6JfHWivmtzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362379; c=relaxed/simple;
	bh=y2O40K5pzPKiZyxSeI9ETSL0s7BaixnRPWYCvRrgTRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHww0y6D70KqykYB6oUSqIeb/L0QqxvT0+2YxrdR8nufI0xIejN/2WsbUfDBP+hM5qcBFZe8qQyoJtrtJFcLIRo54k64+La0jy2h7iyn8NEH+0M9HUMt9Dke27iCfegqvu6AN2IVj8oT8DDcziYR+p57uKi5/xDOhp8gNxk6uKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhMTbOME; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75de9a503so11875331fa.0;
        Thu, 26 Sep 2024 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727362376; x=1727967176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LzfrYsOSQJGT0fh6S4JfDVuPRRQF6Y1jTEM7H+EZ8uc=;
        b=OhMTbOMEW2zitBzxUASyHZi85tkeWIOI6PLB4XoWDEzc7XTAis4WY1ConBsTXTWFxf
         XHyf1+GkKW8Pvtruduas+4t+l8CYGH/Jf18jW9lLHbCFa15BnoxPogrdEWrWfaAQtkoP
         fGDhkj5G/eEJu9ayw+gfAkkzeJcq1H3/EqCcaqatwk1qWWzyqwFMuujYazRbDB3P4+t/
         pmWACoesQ9ayBKovuE4nzkQYecLDJbl7Jy2mOvdLnVOmU3awRVdstqbPxwtonpmN9rpB
         5HAmymJEV7wjyUlfNdzU6yuazbGq+NQlHhVkPUa1TulCBdo8aG3EwEH1vbcCNucjn7Co
         ZYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362376; x=1727967176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzfrYsOSQJGT0fh6S4JfDVuPRRQF6Y1jTEM7H+EZ8uc=;
        b=KkudcgDiqNMT3BuO1nQzaNK68+E9mbNQAj8giMMAGzaM3LYgnNxcX6qdalMrGpRcII
         u+mso5N++cne5duFdBuMRyj8XbMnndVydRJ9tSwHg1ipr0hGB9gHl071dT2D2/2KYCWk
         c87GEJRDqr4+/c8ZBtbmXDole+3Jfs4m3y8cttt2vxDqxpvUGh83EbucirtoWAn0NFEG
         0aHyOPS/RQmYvJ438C6KaXfxJLwzF6YCXM+CmHejV6n4P0FBIPdGlfCa0i9Qam7Rz5ca
         OuEEQMdAasf8BPe9BFWYa4woV4YPotFLKe2CtJjcPY+DSoN4FAQOr8kUWEqPBq6D7HrK
         Ovog==
X-Forwarded-Encrypted: i=1; AJvYcCVon+H9lQpHpWJ5VXo1TzwIMsz0ktj2MfCKYiL+Ofv2jd4tZiM574EwoJSz12Zzv9b83jwR8fxy4NRTkaA=@vger.kernel.org, AJvYcCWMK9sYka+sk4QmW10W1k/qRFZgzxkSgfs9KNVWkmvB5p9zB0U4xQpfInSXjQe1A6JDsQQkEcTO@vger.kernel.org
X-Gm-Message-State: AOJu0YwKLzMUx3jP/MlLj4lkCNTl0c2WfbytejkE2wa4jvfrnWBGPKtW
	kqSxJAPrAHOBMQavRN3E4Af4HJudqVaMNbA4wST13pmgc30yh/OC
X-Google-Smtp-Source: AGHT+IHPCC8HpT01ZQMLo9lSdqWf/pqQUR68HwvlYSILzrj4W2zZGGnC0kikp16fdU9MSbI7YSqbCg==
X-Received: by 2002:a05:651c:2220:b0:2f7:4e9b:93e1 with SMTP id 38308e7fff4ca-2f91ca4270amr33037171fa.36.1727362375472;
        Thu, 26 Sep 2024 07:52:55 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824ba6a7sm4201a12.27.2024.09.26.07.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 07:52:54 -0700 (PDT)
Message-ID: <555e220d-7ff5-58e4-7ca8-282ca88d8392@gmail.com>
Date: Thu, 26 Sep 2024 16:52:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 3/3] x86/bugs: Use code segment selector for VERW
 operand
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>
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
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20240926001729.2unwdxtcnnkf3k3t@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26. 09. 24 02:17, Pawan Gupta wrote:
> On Wed, Sep 25, 2024 at 04:46:23PM -0700, Pawan Gupta wrote:
>> On Thu, Sep 26, 2024 at 12:29:00AM +0100, Andrew Cooper wrote:
>>> On 25/09/2024 11:25 pm, Pawan Gupta wrote:
>>>> Robert Gill reported below #GP in 32-bit mode when dosemu software was
>>>> executing vm86() system call:
>>>>
>>>>    general protection fault: 0000 [#1] PREEMPT SMP
>>>>    CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
>>>>    Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
>>>>    EIP: restore_all_switch_stack+0xbe/0xcf
>>>>    EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>>>>    ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
>>>>    DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
>>>>    CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
>>>>    Call Trace:
>>>>     show_regs+0x70/0x78
>>>>     die_addr+0x29/0x70
>>>>     exc_general_protection+0x13c/0x348
>>>>     exc_bounds+0x98/0x98
>>>>     handle_exception+0x14d/0x14d
>>>>     exc_bounds+0x98/0x98
>>>>     restore_all_switch_stack+0xbe/0xcf
>>>>     exc_bounds+0x98/0x98
>>>>     restore_all_switch_stack+0xbe/0xcf
>>>>
>>>> This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
>>>> are enabled. This is because segment registers with an arbitrary user value
>>>> can result in #GP when executing VERW. Intel SDM vol. 2C documents the
>>>> following behavior for VERW instruction:
>>>>
>>>>    #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
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
>>>>   arch/x86/include/asm/nospec-branch.h | 6 ++++--
>>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>>>> index ff5f1ecc7d1e..e18a6aaf414c 100644
>>>> --- a/arch/x86/include/asm/nospec-branch.h
>>>> +++ b/arch/x86/include/asm/nospec-branch.h
>>>> @@ -318,12 +318,14 @@
>>>>   /*
>>>>    * Macro to execute VERW instruction that mitigate transient data sampling
>>>>    * attacks such as MDS. On affected systems a microcode update overloaded VERW
>>>> - * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
>>>> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %cs
>>>> + * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
>>>> + * 32-bit mode.
>>>>    *
>>>>    * Note: Only the memory operand variant of VERW clears the CPU buffers.
>>>>    */
>>>>   .macro CLEAR_CPU_BUFFERS
>>>> -	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
>>>> +	ALTERNATIVE "", __stringify(verw %cs:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
>>>>   .endm
>>>
>>> People ought rightly to double-take at this using %cs and not %ss.
>>> There is a good reason, but it needs describing explicitly.  May I
>>> suggest the following:
>>>
>>> *...
>>> * In 32bit mode, the memory operand must be a %cs reference.  The data
>>> segments may not be usable (vm86 mode), and the stack segment may not be
>>> flat (espfix32).
>>> *...
>>
>> Thanks for the suggestion. I will include this.
>>
>>>   .macro CLEAR_CPU_BUFFERS
>>> #ifdef __x86_64__
>>>      ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
>>> #else
>>>      ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
>>> #endif
>>>   .endm
>>>
>>> This also lets you drop _ASM_RIP().  It's a cute idea, but is more
>>> confusion than it's worth, because there's no such thing in 32bit mode.
>>>
>>> "%cs:_ASM_RIP(mds_verw_sel)" reads as if it does nothing, because it
>>> really doesn't in 64bit mode.
>>
>> Right, will drop _ASM_RIP() in 32-bit mode and %cs in 64-bit mode.
> 
> Its probably too soon for next version, pasting the patch here:
> 
> ---8<---
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index e18a6aaf414c..4228a1fd2c2e 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -318,14 +318,21 @@
>   /*
>    * Macro to execute VERW instruction that mitigate transient data sampling
>    * attacks such as MDS. On affected systems a microcode update overloaded VERW
> - * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %cs
> - * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
> - * 32-bit mode.
> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
>    *
>    * Note: Only the memory operand variant of VERW clears the CPU buffers.
>    */
>   .macro CLEAR_CPU_BUFFERS
> -	ALTERNATIVE "", __stringify(verw %cs:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> +#ifdef CONFIG_X86_64
> +	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF

You should drop _ASM_RIP here and direclty use (%rip). This way, you 
also won't need __stringify:

ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF

> +#else
> +	/*
> +	 * In 32bit mode, the memory operand must be a %cs reference. The data
> +	 * segments may not be usable (vm86 mode), and the stack segment may not
> +	 * be flat (ESPFIX32).
> +	 */
> +	ALTERNATIVE "", __stringify(verw %cs:mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF

Also here, no need for __stringify:

ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF

This is in fact what Andrew proposed in his review.

Uros.

