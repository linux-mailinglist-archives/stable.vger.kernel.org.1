Return-Path: <stable+bounces-59059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 748BA92DFC5
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 07:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A58D1C2203B
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 05:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789F354657;
	Thu, 11 Jul 2024 05:49:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80932119;
	Thu, 11 Jul 2024 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676971; cv=none; b=bGqoLCMSfIdDnOrwxdfkq3D8NOobS7VeBhzPW3dBiI86TxU8UfRqeI0XZVBReGEtWJhD9av8Fpj/2/CUz9k10xA3Lv6lMkdmqFMLk+5/IAloQvp/KxTULCvy1nX5sWJzWHoW0e+N0hXu05KrXTEEJJDENBSC863xBwy50ZtNWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676971; c=relaxed/simple;
	bh=TtAx04AsrPmMaDmOaZr4TKNIJz6OqZOHS2TCRopxtTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2z1AbZ2vKjTKqbwFyDZ713tMplvbziNxjtBrzY9BX6sm3fRLnKSaK6kuqKe+Den/F5jgOoOrXqZC1EX9Wz2DYYFBCpUYeywOnIf0Z+wRuE8GTWBkA6EvmJhOP5KanD0WjWX2mrbqd6T2AERzOEWoSmUp0or+UeG+YwEeHHainY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266edee10cso2865995e9.2;
        Wed, 10 Jul 2024 22:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720676968; x=1721281768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00fvTifDFvVnBcJ6kYHawNRR9wAbk1H4q78FlXcE1x8=;
        b=V+cUfUNOOMXl0iuR/7nFB6kyM0TO6Nz50Ouxqwa2YCvbn2XNtwICFWrZhCuxM0zVmX
         y9/wyLGd6Foq8/mStmb+ejqgak+EzLS/fc5xUErRHpJ7fZzIE8a7LW0A6NNvLJQJ3p97
         mgiOudtDiPNOg/YYa0D8q/RKMWZqs8NWy9NPRfOkpJ56XcjPDM0fYnc+cigO4DPmp58V
         oxM6Mj5PHvUnkR/0BnW09kk0nN2zVygiG6I3WdYUnXSYMv3/n42KT7lTU9tmg73OkVZ5
         BJI7AeHDi5Sx8w/PR/T0W0h0QUxfdW9XvnmF1ztHurrTR5/d44763jkUAjjdBK/QUqmv
         wotQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJD0tLmNvs9P/vWLkdkXpCvCQq7Pfc86qOutWLKXIkLT9IrNbMFI80yvtZ84SGMw/2ojdjxz1zVpuk7MdzHvSoB1yRLn8Rh0mE+UL1Qsx2Svb0TLSSRc712Ouaf9YHiPDtUIPi
X-Gm-Message-State: AOJu0Yzjf/nrnWapOF8KfINEbdBkB8e4APn3FjB6OuND5rDm5LA62wvQ
	u/ii/gcIOhEsQKy91IE1pcMyPqIZFYsaUgqIMZblM439r/Jk+HKc
X-Google-Smtp-Source: AGHT+IH1S2Mwi4vybh74mjAke/u9DirvmqwbDrxa8I/YMOrjllCOm2I5dAsxnn2JZZan2yI74IuS1w==
X-Received: by 2002:a05:600c:6c51:b0:426:5e55:199a with SMTP id 5b1f17b1804b1-426707e3149mr44363655e9.23.1720676967885;
        Wed, 10 Jul 2024 22:49:27 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427165c69f0sm80270865e9.30.2024.07.10.22.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 22:49:27 -0700 (PDT)
Message-ID: <e321400f-0b76-4fdf-8773-cbad8a47baba@kernel.org>
Date: Thu, 11 Jul 2024 07:49:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/entry_32: Use stack segment selector for VERW
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
References: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
 <8551ef61-71fb-18f3-a8a8-6c7c3ed731e6@gmail.com>
 <20240710231609.rbxd7m5mjk53rthl@desk>
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
In-Reply-To: <20240710231609.rbxd7m5mjk53rthl@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11. 07. 24, 1:16, Pawan Gupta wrote:
> On Wed, Jul 10, 2024 at 11:50:50PM +0200, Uros Bizjak wrote:
...
>>> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
>>> index d3a814efbff6..d54f6002e5a0 100644
>>> --- a/arch/x86/entry/entry_32.S
>>> +++ b/arch/x86/entry/entry_32.S
>>> @@ -253,6 +253,16 @@
>>>    .Lend_\@:
>>>    .endm
>>> +/*
>>> + * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW operand
>>> + * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %ds.
>>> + */
>>> +.macro CLEAR_CPU_BUFFERS_SAFE
>>> +	ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
>>> +	verw	%ss:_ASM_RIP(mds_verw_sel)
>>> +.Lskip_verw\@:
>>> +.endm
>>
>> Why not simply:
>>
>> .macro CLEAR_CPU_BUFFERS_SAFE
>> 	ALTERNATIVE "", __stringify(verw %ss:_ASM_RIP(mds_verw_sel)),
>> X86_FEATURE_CLEAR_CPU_BUF
>> .endm
> 
> We can do it this way as well. But, there are stable kernels that don't
> support relocations in ALTERNATIVEs. The way it is done in current patch
> can be backported without worrying about which kernels support relocations.

This sounds weird. There are code bases without ALTERNATIVE support at 
all. Will you expand ALTERNATIVE into some cmp & jmp here due to that? No.

Instead, you can send this "backport" to stable for older kernels later, 
once a proper patch is merged.

thanks,
-- 
js
suse labs


