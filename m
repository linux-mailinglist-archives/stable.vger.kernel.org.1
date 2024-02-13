Return-Path: <stable+bounces-20100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F48539BA
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 19:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9A61F24C61
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FE4605B1;
	Tue, 13 Feb 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mnEAXcok"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAA5FB8E
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848293; cv=none; b=I1X9brx6Evq5cDRGj8xQVNXDLKttTvn/zWHLiVasQRZcWX0O2T5Rsocc3dd5aDTi6hlfv3C7zPTTeDXrq0XYLipsJnKL32OACr/1SnqFmBczzlKdaz7QM2PCUsblRIeyjJIfRxOl/Dq2yB1x3O3U15EG+cra/Afk+/4UXhzNd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848293; c=relaxed/simple;
	bh=pTUWSs9Hru+vC5ud7Rw+jqlKHCuME49A73ss4j0HPBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8nExQHZiH06e7Zu6F8JRjmz7mysNbp1dycIU2qdgdarzKtI2FmFXLRa3JMdCGoqaH7e6xXTli4pjOJlvbdmmqqlZBkB/2BuQBYS6FsUoVDbEdtoD2DcYvMnHFcYXhQSN+pEEiDkrUeIy04qN2x0l+hGZH2I8/Dsz6eFkP3Jmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mnEAXcok; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7810827e54eso287440085a.2
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 10:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707848289; x=1708453089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+/YbJCPpm0EK3T37Th2lKCSnThgdS1uZBmxaE4WYMY=;
        b=mnEAXcok4g8RlLdRlpedDoBcXD0SCgnFccabt2ZgDHTqdAMm+A0SGJZjM8P2mEyX+2
         JTyo9mGvG8YMmR68l09xumDJ3Xy+doU0osWzKcDwYiDRkJzxoBrLWxOYh9h498kvBkdA
         ftoOcS4paPOgk7kVrPhZCkkPzWTD2+K6r7DPKcCh2JrklLQfiJ/ZRoHxmrjJVQqMK3xe
         tPzT2KLhnY0+6aQz/Q0Mc+FYGiliDIi11vnwrb2XFFKorz+6+dEYMqylOpaj09Vn8lCP
         xu4TcksSQuAfnsOlf3Ps5hPLyFBLhiIe2B0hU63Dp2fBFo16BLg9sFMo7z4k56T+Au1b
         vl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848289; x=1708453089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+/YbJCPpm0EK3T37Th2lKCSnThgdS1uZBmxaE4WYMY=;
        b=JaqwORnNAkF/Oo4ncbfI2X5TycfoAMjlXpOgK8TANdmw2gpK6Dc4vEHsZ58hGE3EuY
         RivSp+Avr3WUfivug0qWxNtwjsqvrCoD4g3MbMvmUHbjmABfyac7ndzmOFYu7vg2l9vN
         joDc2YKxm/KKzZF0VL2T6Szdi3ezjkicd4qV5IACz871RBgethmtQ3SqXoKqb25QsRht
         R/8Sxi3e3m+IqJepglvSG4z827tOB2oKtN+dNKkPmKeg9KefdDOrV42t0MXEhaRfNWL9
         c3FQgHAFIQ0UXAzVe1itZyT/z+KuFGIKGmONDpMEEoDiaq5GXO4P/krMW4Awj8zsBGF5
         PSpA==
X-Forwarded-Encrypted: i=1; AJvYcCX+9qAwvaHhdxAe5Ac8j3JPycK1Wn8uk8+ND/5wSF7/ulv2p28FQYJDMbXvnMh0v/sZAkma7TE8/l+cNH03Ds0yOcpoKENS
X-Gm-Message-State: AOJu0Yyq8uk2rtkwB4E56fBhZ3j2iohMkwIRSRJFsiZxwcbn/CddXoDK
	C/i3yPpq6/vHC6lAW+eDsLqsN9w/luRKP0oD/y+iXkPO0+GhU7yzh3sETKyFT1I=
X-Google-Smtp-Source: AGHT+IEED1duRB9V/QfYpNn/a6siPwseDkG/lIlUu48zJh2xglpQ9h6SRuDpAud2qU+dAsLRiyn2vw==
X-Received: by 2002:a05:620a:4609:b0:783:f683:e28b with SMTP id br9-20020a05620a460900b00783f683e28bmr511286qkb.34.1707848289467;
        Tue, 13 Feb 2024 10:18:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBqBu9ONTTKo2Oh6qupzG9ZOkDJpj3+OTM1FGXNQ5hMekCp0uEVCuMmGUmpK9EMsM166EDu187AKnOkxbeNfL/OvBEEJTja82qs4b5dDlVkw1rF0JfWGx4YyRrfyxVtEGsfXawBrepYGsSDNdUHnedCQVCjCzCIePauRUXd2ywKNq/16SlZP07xdR7gzGZ3eEZt61gcy1rbEaKPv2Q2g==
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id po3-20020a05620a384300b0078366823711sm3149882qkn.119.2024.02.13.10.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 10:18:09 -0800 (PST)
Message-ID: <7b9c1298-91fa-411e-8939-a45a6ac87307@sifive.com>
Date: Tue, 13 Feb 2024 12:18:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes v2 3/4] riscv: Add ISA extension parsing for Sm and
 Ss
Content-Language: en-US
To: Stefan O'Rear <sorear@fastmail.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-4-samuel.holland@sifive.com>
 <20240213-1835b458d8cad71a76fa7322@orel>
 <1c93421f-a70b-46ba-a25c-50cde87bf64d@app.fastmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <1c93421f-a70b-46ba-a25c-50cde87bf64d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-13 11:52 AM, Stefan O'Rear wrote:
> On Tue, Feb 13, 2024, at 10:14 AM, Andrew Jones wrote:
>> On Mon, Feb 12, 2024 at 07:37:34PM -0800, Samuel Holland wrote:
>>> Previously, all extension version numbers were ignored. However, the
>>> version number is important for these two extensions. The simplest way
>>> to implement this is to use a separate bitmap bit for each supported
>>> version, with each successive version implying all of the previous ones.
>>> This allows alternatives and riscv_has_extension_[un]likely() to work
>>> naturally.
>>>
>>> To avoid duplicate extensions in /proc/cpuinfo, the new successor_id
>>> field allows hiding all but the newest implemented version of an
>>> extension.
>>>
>>> Cc: <stable@vger.kernel.org> # v6.7+
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>>
>>> Changes in v2:
>>>  - New patch for v2
>>>
>>>  arch/riscv/include/asm/cpufeature.h |  1 +
>>>  arch/riscv/include/asm/hwcap.h      |  8 ++++++
>>>  arch/riscv/kernel/cpu.c             |  5 ++++
>>>  arch/riscv/kernel/cpufeature.c      | 42 +++++++++++++++++++++++++----
>>>  4 files changed, 51 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>>> index 0bd11862b760..ac71384e7bc4 100644
>>> --- a/arch/riscv/include/asm/cpufeature.h
>>> +++ b/arch/riscv/include/asm/cpufeature.h
>>> @@ -61,6 +61,7 @@ struct riscv_isa_ext_data {
>>>  	const char *property;
>>>  	const unsigned int *subset_ext_ids;
>>>  	const unsigned int subset_ext_size;
>>> +	const unsigned int successor_id;
>>>  };
>>>  
>>>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>>> index 5340f818746b..5b51aa1db15b 100644
>>> --- a/arch/riscv/include/asm/hwcap.h
>>> +++ b/arch/riscv/include/asm/hwcap.h
>>> @@ -80,13 +80,21 @@
>>>  #define RISCV_ISA_EXT_ZFA		71
>>>  #define RISCV_ISA_EXT_ZTSO		72
>>>  #define RISCV_ISA_EXT_ZACAS		73
>>> +#define RISCV_ISA_EXT_SM1p11		74
>>> +#define RISCV_ISA_EXT_SM1p12		75
>>> +#define RISCV_ISA_EXT_SS1p11		76
>>> +#define RISCV_ISA_EXT_SS1p12		77
>>>  
>>>  #define RISCV_ISA_EXT_MAX		128
>>>  #define RISCV_ISA_EXT_INVALID		U32_MAX
>>>  
>>>  #ifdef CONFIG_RISCV_M_MODE
>>> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SM1p11
>>> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SM1p12
>>>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
>>>  #else
>>> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SS1p11
>>> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SS1p12
>>>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
>>>  #endif
>>>  
>>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>>> index d11d6320fb0d..2e6b90ed0d51 100644
>>> --- a/arch/riscv/kernel/cpu.c
>>> +++ b/arch/riscv/kernel/cpu.c
>>> @@ -215,6 +215,11 @@ static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
>>>  		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
>>>  			continue;
>>>  
>>> +		/* Only show the newest implemented version of an extension */
>>> +		if (riscv_isa_ext[i].successor_id != RISCV_ISA_EXT_INVALID &&
>>> +		    __riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].successor_id))
>>> +			continue;
>>
>> I'm not sure we need this. Expanding Ss1p12 to 'Ss1p11 Ss1p12' and then
>> outputting both in the ISA string doesn't seem harmful to me. Also, using

I was thinking that parsers would be confused by seeing the same extension
multiple times, but I have no problem with it if folks disagree.

>> a successor field instead of supersedes field may make this logic easy,
>> but it'll require updating old code (changing RISCV_ISA_EXT_INVALID to the
>> new version extension ID) when new versions are added. A supersedes field
>> wouldn't require old code updates and would match the profiles spec which
>> have explicit 'Ss1p12 supersedes Ss1p11.' type sentences.
> 
> Seconding - suppressing implied extensions in /proc/cpuinfo will require anything
> that parses /proc/cpuinfo to know about extension implication in order to
> generate the complete list.

Well, from an ISA string perspective (i.e. what's shown in /proc/cpuinfo), only
including the latest version _does_ give you the complete list, because Ss1p11
and Ss1p12 aren't different extensions. I'm only expanding them to different
flags inside the kernel so we can avoid storing the version number as an integer
and doing numeric comparisons at each usage site.

So /proc/cpuinfo parsers wouldn't need to know about implication, since that's a
kernel implementation detail. They just need to know how to parse the version
number from an ISA string. And I would expect them to be able to do that anyway.

There would only be backward-compatibility concerns if parsers are doing a
string match on the whole "ss1p12", which I would consider wrong to start with.

Regards,
Samuel


