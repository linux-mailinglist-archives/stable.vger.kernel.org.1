Return-Path: <stable+bounces-59071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D69192E2A1
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 10:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3369A285526
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD121514ED;
	Thu, 11 Jul 2024 08:44:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8821514C8;
	Thu, 11 Jul 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687464; cv=none; b=HybOF332tZVMWJugGDxEFQLum9pt/Wa7lFQIH2fOKURT/1X4P9LRP/iLD0iA0e5fsAx+07dba/2gGR9L4FNdQ2BgcBQLX3mmKSJq6kd5Tvl5m15ju6TxA2UgGGWTiDAgaBniqs1vJvcaH0h9shZuZ9YFEQqFklSRoZ1FGczYVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687464; c=relaxed/simple;
	bh=JjhRgbQ9GDFAug3/hcT/xXCYrC5MuLiDfv9qArSutxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARA9YdDuAeupdmNo6g8YwvvGoUjiwOI7y9n3QIsCByaS3t6ZH/bKVNVo4NQTRpGOqPT0rtdbs11/TlOoR/MWSbQ5zvjTOztPMFRxtmnJ5ZGdu9b39r/ReIxWe0ixyJcByCaW867GN+M4pVxRyWGlagWYpvvCEDCCKIBf9LgOvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea79e6979so748038e87.2;
        Thu, 11 Jul 2024 01:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720687461; x=1721292261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vazRm2F6T/XBKU6B0zwiOrXRdtsWDjy1Kfm9+UjGHgI=;
        b=mTn+n3gLPg71EQefU41F84pPymAJQ7A1cjb8FP2D3KfNDtaqYy2Oo2qGYxUXoCrZyT
         nORRwmClfV19xEs3hPijCzOZTLn6LyuPoa9/lJMm6YPLO1CEKHrRpyKloepkDKZyzzwz
         3X1+KTOHw8o4obtGfSAdGtHlU3ZRHmR0qZiGh1spe8C9qAEV7ObVxR2SFQYHgypfffgX
         DKhdPC5Ni7Qnrcd59Vnjx9JZ4emQt1sUa6c9zTq1MD5xWcIaarRvolJB7KhH41zUmM2y
         L/uKxUbw3P4aKSOrqFDaiJBygn2W5COIYVJyEQx1KCgqCfIOjHuH7k0wYwKFqoSvfW6v
         KEEg==
X-Forwarded-Encrypted: i=1; AJvYcCXGN7FbHwlBYbNSs7m7Vgvu52FiADfOB8fBN8HLhhPZT+tuI2Sbf1ltZ8g7dzFwOvjotUCShN9B8b3ljcNG2b/cWArb66yVoWcxkvojJ4cqj6pgTjKwZIqbm3mVxBvBlz2rshmx
X-Gm-Message-State: AOJu0YwUwY8aHjA+8zGhCvSp6+3YgA9kZe8aqb9Tsfqy4n8T2SwLH5Gf
	fLTgr487vlKLhzZQhx1HbKxmlOZdVZQqCMsTnNaSvMJV8VeQm0HCrfVY6ih7
X-Google-Smtp-Source: AGHT+IHHvFb95lcoAV9sI1c53YQDvNr0iwjid2YThaLAl5iHBCiMbJJGluSkUgY+xV3vkci7AMBPQw==
X-Received: by 2002:a05:6512:39ce:b0:52e:96d7:2f3a with SMTP id 2adb3069b0e04-52eb99da148mr5273596e87.58.1720687460939;
        Thu, 11 Jul 2024 01:44:20 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f10ebsm109161495e9.16.2024.07.11.01.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:44:20 -0700 (PDT)
Message-ID: <4827a532-a54a-483a-9222-692aea33a611@kernel.org>
Date: Thu, 11 Jul 2024 10:44:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/entry_32: Use stack segment selector for VERW
 operand
To: Uros Bizjak <ubizjak@gmail.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 Robert Gill <rtgill82@gmail.com>, Jari Ruusu <jariruusu@protonmail.com>,
 Brian Gerst <brgerst@gmail.com>,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
 antonio.gomez.iglesias@linux.intel.com, daniel.sneddon@linux.intel.com,
 stable@vger.kernel.org
References: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
 <8551ef61-71fb-18f3-a8a8-6c7c3ed731e6@gmail.com>
 <20240710231609.rbxd7m5mjk53rthl@desk>
 <CAFULd4bhpTKZ5k=hSpitoFQk=U0njuacFhKrvpvcNqbA5ryV9A@mail.gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <CAFULd4bhpTKZ5k=hSpitoFQk=U0njuacFhKrvpvcNqbA5ryV9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11. 07. 24, 10:30, Uros Bizjak wrote:
> On Thu, Jul 11, 2024 at 1:16 AM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
>>
>> On Wed, Jul 10, 2024 at 11:50:50PM +0200, Uros Bizjak wrote:
>>>
>>>
>>> On 10. 07. 24 21:06, Pawan Gupta wrote:
>>>> Robert Gill reported below #GP when dosemu software was executing vm86()
>>>> system call:
>>>>
>>>>     general protection fault: 0000 [#1] PREEMPT SMP
>>>>     CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
>>>>     Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
>>>>     EIP: restore_all_switch_stack+0xbe/0xcf
>>>>     EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>>>>     ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
>>>>     DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
>>>>     CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
>>>>     Call Trace:
>>>>      show_regs+0x70/0x78
>>>>      die_addr+0x29/0x70
>>>>      exc_general_protection+0x13c/0x348
>>>>      exc_bounds+0x98/0x98
>>>>      handle_exception+0x14d/0x14d
>>>>      exc_bounds+0x98/0x98
>>>>      restore_all_switch_stack+0xbe/0xcf
>>>>      exc_bounds+0x98/0x98
>>>>      restore_all_switch_stack+0xbe/0xcf
>>>>
>>>> This only happens when VERW based mitigations like MDS/RFDS are enabled.
>>>> This is because segment registers with an arbitrary user value can result
>>>> in #GP when executing VERW. Intel SDM vol. 2C documents the following
>>>> behavior for VERW instruction:
>>>>
>>>>     #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
>>>>         FS, or GS segment limit.
>>>>
>>>> CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
>>>> space. Replace CLEAR_CPU_BUFFERS with a safer version that uses %ss to
>>>> refer VERW operand mds_verw_sel. This ensures VERW will not #GP for an
>>>> arbitrary user %ds. Also, in NMI return path, move VERW to after
>>>> RESTORE_ALL_NMI that touches GPRs.
>>>>
>>>> For clarity, below are the locations where the new CLEAR_CPU_BUFFERS_SAFE
>>>> version is being used:
>>>>
>>>> * entry_INT80_32(), entry_SYSENTER_32() and interrupts (via
>>>>     handle_exception_return) do:
>>>>
>>>> restore_all_switch_stack:
>>>>     [...]
>>>>      mov    %esi,%esi
>>>>      verw   %ss:0xc0fc92c0  <-------------
>>>>      iret
>>>>
>>>> * Opportunistic SYSEXIT:
>>>>
>>>>      [...]
>>>>      verw   %ss:0xc0fc92c0  <-------------
>>>>      btrl   $0x9,(%esp)
>>>>      popf
>>>>      pop    %eax
>>>>      sti
>>>>      sysexit
>>>>
>>>> *  nmi_return and nmi_from_espfix:
>>>>      mov    %esi,%esi
>>>>      verw   %ss:0xc0fc92c0  <-------------
>>>>      jmp     .Lirq_return
>>>>
>>>> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
>>>> Cc: stable@vger.kernel.org # 5.10+
>>>> Reported-by: Robert Gill <rtgill82@gmail.com>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
>>>> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
>>>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>>>> Suggested-by: Brian Gerst <brgerst@gmail.com> # Use %ss
>>>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>>>> ---
>>>> v4:
>>>> - Further simplify the patch by using %ss for all VERW calls in 32-bit mode (Brian).
>>>> - In NMI exit path move VERW after RESTORE_ALL_NMI that touches GPRs (Dave).
>>>>
>>>> v3: https://lore.kernel.org/r/20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com
>>>> - Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian).
>>>> - Do verw before popf in SYSEXIT path (Jari).
>>>>
>>>> v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com
>>>> - Safe guard against any other system calls like vm86() that might change %ds (Dave).
>>>>
>>>> v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com
>>>> ---
>>>>
>>>> ---
>>>>    arch/x86/entry/entry_32.S | 18 +++++++++++++++---
>>>>    1 file changed, 15 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
>>>> index d3a814efbff6..d54f6002e5a0 100644
>>>> --- a/arch/x86/entry/entry_32.S
>>>> +++ b/arch/x86/entry/entry_32.S
>>>> @@ -253,6 +253,16 @@
>>>>    .Lend_\@:
>>>>    .endm
>>>> +/*
>>>> + * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW operand
>>>> + * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %ds.
>>>> + */
>>>> +.macro CLEAR_CPU_BUFFERS_SAFE
>>>> +   ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
>>>> +   verw    %ss:_ASM_RIP(mds_verw_sel)
>>>> +.Lskip_verw\@:
>>>> +.endm
>>>
>>> Why not simply:
>>>
>>> .macro CLEAR_CPU_BUFFERS_SAFE
>>>        ALTERNATIVE "", __stringify(verw %ss:_ASM_RIP(mds_verw_sel)),
>>> X86_FEATURE_CLEAR_CPU_BUF
>>> .endm
>>
>> We can do it this way as well. But, there are stable kernels that don't
>> support relocations in ALTERNATIVEs. The way it is done in current patch
>> can be backported without worrying about which kernels support relocations.
> 
> Then you could use absolute reference in backports to kernels that
> don't support relocations in ALTERNATIVEs, "verw %ss:mds_verw_sel"
> works as well, but the relocation is one byte larger.

No, the kernels support (and use) relocations. It's only ALTERNATIVEs in 
older kernels don't.

-- 
js
suse labs


