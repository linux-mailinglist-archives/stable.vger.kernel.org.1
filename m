Return-Path: <stable+bounces-77808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE76987786
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 18:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6541C21B44
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 16:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CBB158DC3;
	Thu, 26 Sep 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LkEsorXo"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78861522A
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368092; cv=none; b=tUW+nOZNOH/XvT1E5oRiKyQ2Zs4zwfpR3DUqYZzm7rV4b68cmj4+NVnDviD4RpjFT1BwjpU/BpC9rzg3L0feW73OX3rxqWlrD8tSoRAy2Xm8Tt6L8yqVHy9ggaYJ9Zt9zLSL4X1QQHRR6cBq18E5VCVxUr7ECuEG+CNOqsHl6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368092; c=relaxed/simple;
	bh=mEm1zA5qR8TPXAZ/j8ma4Q5lr0/WE8b87OmoVmlC7Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnBzlMGgzBVS2HoPgARGWEPQBzRzDKB7uXzlpDpLPY8BTFnKUBP3hF4l+J8z9ZQ+tkH8D90xOqJdPg311N10wqGOdnXqnkAU2XUw5YcpGSHebiC1nL21ZBVuLnqSTCXsLy4G0PrsjWYLmqA6mb1pvaVdYk4m7D+pnCkKjY0FEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=LkEsorXo; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so1326040e87.2
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1727368089; x=1727972889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CIxjEKqTmFld63wZ5uaJhMTjf7dLJV3EOglZ0vA99MI=;
        b=LkEsorXowZCSeL93jg5l7fRizl7eABw9qqj9hXHWTjEo9Ds1SzGnrKdar98q/SMKlO
         UTtqBcTo5TlSRGKL0r6ibVof9NQCeGbMxCL1iQvolgEcQgzRvj4Qnl76Lj/VG5Kkuw7M
         MljiobojnAnvIxkQi4/0cm3l1i8SPemRlCtQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727368089; x=1727972889;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIxjEKqTmFld63wZ5uaJhMTjf7dLJV3EOglZ0vA99MI=;
        b=oI1oSkG5b2Zfqww6s3mqqjLoQzUyhcYgltlv+W5U9aSwuWCayjL+u4ocmlGLppjJ7g
         o0d8B+KyKjb46jm7WFYvdPmGLQspJD1Vkzvck7eEKwZ2ruU9T+SN/CyD3OpqrUEA7UL9
         NrLgw7miGhbI8WWgks2BgjcYcs1+/sxqoRsJgCDyU1gW8jV2E7v9ByrZbTq7uE42vE6c
         1ddr7CaFIXQqf7nuS7nckCTIqqmCPK1osiNZ01rT7wOqBrfHgviJhnelelvrNBDjEQkr
         x8ISGp7iUwGHQ7574Ngo2Ho4yckk6U8cW9SvfvIUrXlDedSLrYxyyrvC5rM4Dp4GO9J0
         na4w==
X-Forwarded-Encrypted: i=1; AJvYcCUHnCa2q+3G3/CG7v71R/oR6wrI8NxWgdOeH4zjGBsuPq8tAdw8Mcxr88rF9pA9xalM0v1sn8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtB9PpzLC5kxTSg7KkapbvlG2iAJOaLayKybw3TvYRZIdMoNs
	1byzpaSowJXMXYwRhlMpHv9ysTIODk6rCpRO2VGsLbMj12xGGHFwSuqNbt5XFRg=
X-Google-Smtp-Source: AGHT+IE3jPgukJH1K8BJQv4arbonytAcsMUM3OByhz192tL4DKuB/tQ+75/GqDjAcfbNJ8eMEEuljA==
X-Received: by 2002:a05:6512:2207:b0:536:52ec:2870 with SMTP id 2adb3069b0e04-5389fc43e99mr156882e87.28.1727368088430;
        Thu, 26 Sep 2024 09:28:08 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824949f6sm91011a12.82.2024.09.26.09.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 09:28:07 -0700 (PDT)
Message-ID: <acea2233-0975-4449-952c-8eb05b075d8c@citrix.com>
Date: Thu, 26 Sep 2024 17:28:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] x86/bugs: Use code segment selector for VERW
 operand
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Uros Bizjak <ubizjak@gmail.com>
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
 <555e220d-7ff5-58e4-7ca8-282ca88d8392@gmail.com>
 <20240926161031.dcohgbkbqs4bk32n@desk>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <20240926161031.dcohgbkbqs4bk32n@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/09/2024 5:10 pm, Pawan Gupta wrote:
> On Thu, Sep 26, 2024 at 04:52:53PM +0200, Uros Bizjak wrote:
>>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>>> index e18a6aaf414c..4228a1fd2c2e 100644
>>> --- a/arch/x86/include/asm/nospec-branch.h
>>> +++ b/arch/x86/include/asm/nospec-branch.h
>>> @@ -318,14 +318,21 @@
>>>   /*
>>>    * Macro to execute VERW instruction that mitigate transient data sampling
>>>    * attacks such as MDS. On affected systems a microcode update overloaded VERW
>>> - * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %cs
>>> - * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
>>> - * 32-bit mode.
>>> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
>>>    *
>>>    * Note: Only the memory operand variant of VERW clears the CPU buffers.
>>>    */
>>>   .macro CLEAR_CPU_BUFFERS
>>> -	ALTERNATIVE "", __stringify(verw %cs:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
>>> +#ifdef CONFIG_X86_64
>>> +	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
>> You should drop _ASM_RIP here and direclty use (%rip). This way, you also
>> won't need __stringify:
>>
>> ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
>>
>>> +#else
>>> +	/*
>>> +	 * In 32bit mode, the memory operand must be a %cs reference. The data
>>> +	 * segments may not be usable (vm86 mode), and the stack segment may not
>>> +	 * be flat (ESPFIX32).
>>> +	 */
>>> +	ALTERNATIVE "", __stringify(verw %cs:mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
>> Also here, no need for __stringify:
>>
>> ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
>>
>> This is in fact what Andrew proposed in his review.
> Thanks for pointing out, I completely missed that part. Below is how it
> looks like with stringify gone:
>
> --- >8 ---
> Subject: [PATCH] x86/bugs: Use code segment selector for VERW operand
>
> Robert Gill reported below #GP in 32-bit mode when dosemu software was
> executing vm86() system call:
>
>   general protection fault: 0000 [#1] PREEMPT SMP
>   CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
>   Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
>   EIP: restore_all_switch_stack+0xbe/0xcf
>   EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>   ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
>   DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
>   CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
>   Call Trace:
>    show_regs+0x70/0x78
>    die_addr+0x29/0x70
>    exc_general_protection+0x13c/0x348
>    exc_bounds+0x98/0x98
>    handle_exception+0x14d/0x14d
>    exc_bounds+0x98/0x98
>    restore_all_switch_stack+0xbe/0xcf
>    exc_bounds+0x98/0x98
>    restore_all_switch_stack+0xbe/0xcf
>
> This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
> are enabled. This is because segment registers with an arbitrary user value
> can result in #GP when executing VERW. Intel SDM vol. 2C documents the
> following behavior for VERW instruction:
>
>   #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
> 	   FS, or GS segment limit.
>
> CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
> space. Use %cs selector to reference VERW operand. This ensures VERW will
> not #GP for an arbitrary user %ds.
>
> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
> Cc: stable@vger.kernel.org # 5.10+
> Reported-by: Robert Gill <rtgill82@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/include/asm/nospec-branch.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index ff5f1ecc7d1e..96b410b1d4e8 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -323,7 +323,16 @@
>   * Note: Only the memory operand variant of VERW clears the CPU buffers.
>   */
>  .macro CLEAR_CPU_BUFFERS
> -	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> +#ifdef CONFIG_X86_64
> +	ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
> +#else
> +	/*
> +	 * In 32bit mode, the memory operand must be a %cs reference. The data
> +	 * segments may not be usable (vm86 mode), and the stack segment may not
> +	 * be flat (ESPFIX32).
> +	 */
> +	ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
> +#endif

You should also delete _ASM_RIP() as you're removing the only user of it.

But yes, with that, Reviewed-by: Andrew Cooper
<andrew.cooper3@citrix.com> FWIW.

