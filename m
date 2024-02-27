Return-Path: <stable+bounces-23844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B086868AEE
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6002B265E6
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686837E761;
	Tue, 27 Feb 2024 08:42:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89815537F4
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023320; cv=none; b=Zi9OYjttqvqRI3eYJIqxEgdsy2I8UMY41cur1ocvIDEL7yeV4MgCI+VdLd6rMAW1zO7dvrBj2ARQd2rPP0USLC5TfvE/DuWDYC6vzyB6B8WU1xV0Td+AN5rdt8pY/mz/WFmt1qMPdtU7sqHGtwgUBh0FQl6wqGjtXl/ptjdDj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023320; c=relaxed/simple;
	bh=nCzrNseDbp0ZUbUz/XV3DCfHj8kR5xyqAkEiXc0ifJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMUPTmeNSSmrbhfTCsX2NSztMyL3hZIJMJWVyKX5BrJkGsi1mOhFqep3c52x8XPsgregB0pueW6ltubDIsJRMTT918M1SB1QP3/Ov68VUpdZBfIHoDq0g4DypCwChoiSqjIJQlUgf/Bbsxecb8pNrVbOWMMPQkOsMYuzzecMH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so31961385e9.1
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 00:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709023317; x=1709628117;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upVL5itFinnua2/dlTXxChcoBiMA8mXTP5fY2Kgr7aE=;
        b=jhmeplChb5gQm2cupPCk1p/YQeTF8lS2O6FVXdqrTT4T/x/qKErWVm7UdVZKYPJsUr
         t6xGiuF+z8uzZwDwI6MbFiaxktH7fnBW63enOPioeye9myt6XhiKWDGzunGniZJr/du0
         SIzWj7O0ivm3yxEeN7/x/K2GEy7kus5dpstehgthspdEH7cvv3sapivBIsT+Tn2G+yzp
         3tf/l9CujHS10vAeMj5Q2n6idOrzbgOA8vvm3t703POxNOdOwj9Q3ye2rpi3qTz2eX+r
         wIx1YEUGKj4zksRcSJ5NNYml1PS++/WcHT0Z1H2xd+nQBUCZXMHAcio73MvUW9jBnINM
         wE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhQZ17+BhPvC2FHXYXiSTvvd56m3hV9ZS31JpofwMyRe/ohcuPZbuAmK87BQJ7TC/pjdzPRXQhM22rESEsoR+U3D4Ie4Gk
X-Gm-Message-State: AOJu0Yy2mGxQCOibvePFAp1M5pK44jtlVJV1bpIU6HM5o/IkS2/wNlVo
	ZRWwfGt7q5lT8elCtZoj2uyUX2mi4x+u/2ToBHI1f1pUDnwhE4gJS+JYxiim
X-Google-Smtp-Source: AGHT+IE5AVXD3aQzMV+2aqW5YEpFxzc2nBxqmj56UGJvcng1LcqF2aNywS54PL/IkpGTKh6l9Yqlaw==
X-Received: by 2002:a05:600c:190d:b0:412:a49b:2f2a with SMTP id j13-20020a05600c190d00b00412a49b2f2amr4530573wmq.33.1709023316741;
        Tue, 27 Feb 2024 00:41:56 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc454000000b0041249ea88b9sm10492942wmi.16.2024.02.27.00.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:41:56 -0800 (PST)
Message-ID: <abc65c4d-4731-4234-b8a2-5eaa4e5a52e7@kernel.org>
Date: Tue, 27 Feb 2024 09:41:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7.y 1/6] x86/bugs: Add asm helpers for executing VERW
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 Alyssa Milburn <alyssa.milburn@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240226-delay-verw-backport-6-7-y-v1-0-ab25f643173b@linux.intel.com>
 <20240226-delay-verw-backport-6-7-y-v1-1-ab25f643173b@linux.intel.com>
 <c9ede8e2-5066-435b-bd1d-1971a8072952@kernel.org>
 <20240227082755.yl7ny34o33uotqww@desk>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240227082755.yl7ny34o33uotqww@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 02. 24, 9:27, Pawan Gupta wrote:
> On Tue, Feb 27, 2024 at 08:40:26AM +0100, Jiri Slaby wrote:
>> ...
>>> --- a/arch/x86/include/asm/nospec-branch.h
>>> +++ b/arch/x86/include/asm/nospec-branch.h
>>> @@ -315,6 +315,17 @@
>>>    #endif
>>>    .endm
>>> +/*
>>> + * Macro to execute VERW instruction that mitigate transient data sampling
>>> + * attacks such as MDS. On affected systems a microcode update overloaded VERW
>>> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
>>> + *
>>> + * Note: Only the memory operand variant of VERW clears the CPU buffers.
>>> + */
>>> +.macro CLEAR_CPU_BUFFERS
>>> +	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
>>
>> Why is not rip-relative preserved here?
> 
> Because Nikolay reported that it was creating a problem for backports on
> kernels that don't support relocations in alternatives. More on this
> here:
> 
>    https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/

Sure, I know about the issue.

> Also, RIP-relative addressing was a requirement only for the initial
> versions of the series, where the VERW operand was pointing within the
> macro. For performance gains, later versions switched to the
> implementation in which all VERW sites were pointing to single memory
> location. With that, RIP-relative addressing could be droped in favor of
> fixed addresses.
> 
>> Will this work at all (it looks like verw would now touch random
>> memory)?
> 
> AFAIK, all memory operand variants of VERW have the CPU buffer clearing
> behavior. I will confirm this with the CPU architects.

I might be too dumb to understand this, so sorry if the below does not 
make sense. Neither I cannot see "why it works" in the minor patch you 
sent (and incorporated here). You only explain it's easier for backports 
and "was needed in earlier versions".

But verw can #PF (and actually used to before Nik invented the jmp 
workaround in the SUSE backport). I assume it's the case when the store 
of the segment (mds_verw_sel) cannot be accessed/read. Now, with fixed 
addressing this works unless KASLR is employed. If it is, the fixed 
address of mds_verw_sel no longer points to the correct memory. Or what 
am I missing?

>> In any way, should you do any changes during the backport, you shall
>> document that.
> 
> Sorry, I missed to mention this change in 6.7.y backport. I did include
> this info in the other backports I sent:
> 
>    https://lore.kernel.org/stable/20240226-delay-verw-backport-6-6-y-v1-0-aa17b2922725@linux.intel.com/T/
>    https://lore.kernel.org/stable/20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com/T/

I am sure you are aware you need NOT doing this very change in 6.6 and 
6.7 ;). It somehow confused me too.

thanks,
-- 
js
suse labs


