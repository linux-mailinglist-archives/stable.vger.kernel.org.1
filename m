Return-Path: <stable+bounces-25298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F74386A0A0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 21:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135CD28834C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12D14AD2D;
	Tue, 27 Feb 2024 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DSnYKMAH"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBAD14AD0A
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064099; cv=none; b=J0rPr+yeivppeW73uhYnquACSO0XmizGXNnLLyrZZFMqMmVXuZkGyaDer+8xYF+bb6woY//lNC1e8njNQ322wHqMycLjt9NhfoUqTzRL9dwhTyREBxm57+CQqEMm8f99f159BCsifoixKaDPYg3tQ/OgqyCXx8VTXSnRlrm2Yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064099; c=relaxed/simple;
	bh=gLyw//m6G9pBImmWZWYlwzKQS/S2+z6YvepUOugVK9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKZ6eQvnj2R0stlCKJbIbLqYzBIKQsuWFx1JJJjXGyp/Y6URE40GgTNSSHFoooYPlummv2UoY1zgRhFu9i+tbSGab0z7Emfh267E3vSU8r6rDd1jaJ8mDQCtWN83Ajl4S0P+o/2ZtOaLukX56G5mQF5jENQYOBWPqCu5el9bbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DSnYKMAH; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c78b520bc3so172684639f.0
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 12:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709064096; x=1709668896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCoSqCHOuyJdrEXgcSRyyHnAhXtrU9sHKBBcP3u4W04=;
        b=DSnYKMAHlaMCu9vajPvhP+L1Uwzx2jYVlT5KxViIHh8kwCZeEgZHdhdFFhrZ9HOorQ
         VbBkqG5t7u4K8IpPYEY2ph9ALnnyBPun3JnyrVtT/t3+wP2bHuh/gIFlR5z7e/QUZnMO
         WQKMgsGIw2ii9XUIfJcvv/mYrMtbHu7zDpN/07zP0dRDLryup/Q3LGIU2fFJkYnGDYXj
         5cd2KsGa/IygzuV6gQvoE0osETFputy3pDM4MkQBJiVq7uxZd6WtzgbDakK2KjD4MjLM
         Aj1Zk51h2GQpnmJHNhP4JTuWzycEQNqUOBTWX2k0fztLMXMuATam+ZSJ4d/mx7FMqwEo
         D+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709064096; x=1709668896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCoSqCHOuyJdrEXgcSRyyHnAhXtrU9sHKBBcP3u4W04=;
        b=JJPxb0vyhay0EHaTRm0oJ7ubaFPkT6Dyg5Bk7hx3a0dCQyVE5TZDwZg3N+alffsdZW
         DL9mqPrI4+B4tBuOHp2LWubGCJXJRobA/Cyu2qlk2nio+Uwk/VB0yS1F8DrI8WKhgBaU
         /QDHUhZTJqkquLccdvwZu/jAZjUsETrfKnAUjwDOmCbOZpLPlo7MCOmdca2tyuZPvl5g
         3I2V+EkDi8V+7YRfQl5+mHfHxAWli3BODKw07wayeks0Z8OgtT/XdWzdLDw/Yopgp3lp
         dEqcxAbdm+uTQlbR1wDYFfi0rFKIivQeB7I6dgIrIP0WLwegJoFm9KJcCnMMZjW3oDAs
         7xZw==
X-Forwarded-Encrypted: i=1; AJvYcCXZuOXAU9GJCQTcEoupulLp12FYa5LM3PC91ZQ3oM7FpPcaEpyn08pJJ+nP1Ss8KRkzBMSALSOUJZW3GUyS2BZQxGK4Y+sK
X-Gm-Message-State: AOJu0Yy6mfNJnOoN/kSwNNcapKF5+oW4tjKSkF0dPHSgh2nuwm8OGGFG
	jaHa+xzcxPqiCG3Ko9WxWRgaJbq3uS/ARjqBPK0gE/hViejJDbPD5K8zu2HHee0=
X-Google-Smtp-Source: AGHT+IG5+tdMrZ2ON9H8ZpGLg3GIka4FUXbeapzA9mauWtoPzhwuW9kisXtyN8OVl6ignL92UATEaA==
X-Received: by 2002:a6b:3f8a:0:b0:7c7:97a0:d2f4 with SMTP id m132-20020a6b3f8a000000b007c797a0d2f4mr11694640ioa.9.1709064095809;
        Tue, 27 Feb 2024 12:01:35 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.200])
        by smtp.gmail.com with ESMTPSA id y90-20020a029563000000b004740d29b120sm1936267jah.111.2024.02.27.12.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:01:35 -0800 (PST)
Message-ID: <33f16905-baab-47e8-a92f-d2543b69d704@sifive.com>
Date: Tue, 27 Feb 2024 14:01:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes v3 1/2] riscv: Fix enabling cbo.zero when running
 in M-mode
Content-Language: en-US
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
 Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240214090206.195754-1-samuel.holland@sifive.com>
 <20240214090206.195754-2-samuel.holland@sifive.com>
 <20240214-661604d82db4ef137540b762@orel>
 <579c9f3f-8c28-4e4e-88ce-9f266597b7bd@ghiti.fr>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <579c9f3f-8c28-4e4e-88ce-9f266597b7bd@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 2024-02-27 1:48 PM, Alexandre Ghiti wrote:
> Hi Samuel,
> 
> On 14/02/2024 10:28, Andrew Jones wrote:
>> On Wed, Feb 14, 2024 at 01:01:56AM -0800, Samuel Holland wrote:
>>> When the kernel is running in M-mode, the CBZE bit must be set in the
>>> menvcfg CSR, not in senvcfg.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>   arch/riscv/include/asm/csr.h   | 2 ++
>>>   arch/riscv/kernel/cpufeature.c | 2 +-
>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
>>> index 510014051f5d..2468c55933cd 100644
>>> --- a/arch/riscv/include/asm/csr.h
>>> +++ b/arch/riscv/include/asm/csr.h
>>> @@ -424,6 +424,7 @@
>>>   # define CSR_STATUS    CSR_MSTATUS
>>>   # define CSR_IE        CSR_MIE
>>>   # define CSR_TVEC    CSR_MTVEC
>>> +# define CSR_ENVCFG    CSR_MENVCFG
>>>   # define CSR_SCRATCH    CSR_MSCRATCH
>>>   # define CSR_EPC    CSR_MEPC
>>>   # define CSR_CAUSE    CSR_MCAUSE
>>> @@ -448,6 +449,7 @@
>>>   # define CSR_STATUS    CSR_SSTATUS
>>>   # define CSR_IE        CSR_SIE
>>>   # define CSR_TVEC    CSR_STVEC
>>> +# define CSR_ENVCFG    CSR_SENVCFG
>>>   # define CSR_SCRATCH    CSR_SSCRATCH
>>>   # define CSR_EPC    CSR_SEPC
>>>   # define CSR_CAUSE    CSR_SCAUSE
>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>> index 89920f84d0a3..c5b13f7dd482 100644
>>> --- a/arch/riscv/kernel/cpufeature.c
>>> +++ b/arch/riscv/kernel/cpufeature.c
>>> @@ -950,7 +950,7 @@ arch_initcall(check_unaligned_access_all_cpus);
>>>   void riscv_user_isa_enable(void)
>>>   {
>>>       if (riscv_cpu_has_extension_unlikely(smp_processor_id(),
>>> RISCV_ISA_EXT_ZICBOZ))
>>> -        csr_set(CSR_SENVCFG, ENVCFG_CBZE);
>>> +        csr_set(CSR_ENVCFG, ENVCFG_CBZE);
>>>   }
>>>     #ifdef CONFIG_RISCV_ALTERNATIVE
>>> -- 
>>> 2.43.0
>>>
>> After our back and forth on how we determine the existence of the *envcfg
>> CSRs, I wonder if we shouldn't put a comment above this
>> riscv_user_isa_enable() function capturing the [current] decision.
>>
>> Something like
>>
>>   /*
>>    * While the [ms]envcfg CSRs weren't defined until priv spec 1.12,
>>    * they're assumed to be present when an extension is present which
>>    * specifies [ms]envcfg bit(s). Hence, we don't do any additional
>>    * priv spec version checks or CSR probes here.
>>    */
> 
> 
> I was about to read the whole discussion in v2 to understand the v3...thank you
> Drew :) I think it really makes sense to add this comment, do you intend to do
> so Samuel?

Yes, I am about to send a v4 with the changes from the previous discussion,
including a RISCV_ISA_EXT_XLINUXENVCFG bit specifically for the presence of the
[ms]envcfg CSR and a comment like the above.

Regards,
Samuel


