Return-Path: <stable+bounces-146105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07EAC11DD
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 19:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DB43B367F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4617C21C;
	Thu, 22 May 2025 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gHMrvacA"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB281754B;
	Thu, 22 May 2025 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933837; cv=none; b=R1Cux/o3Er9YpL3CoLyljxfkbgpXkPslx9m2oyaKGuQ3J2PW9OSzHj/oSYKmvVviHcnKNxHDtMnlVhj0pnxnsQKxqaXNoyCd8fVyDZQlK0tUg1lduWWRa+ubO26SrgiTqgXXzCI2R47gS8tGhdGaHNDBB9Ac6qFH0srM1ms387U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933837; c=relaxed/simple;
	bh=SWtj3pVOZ1u6Uc3aN+dBp2QT57HrsFQjqoacbSjVGp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auGrKyQ+R6ar47EIBP8VIsagYtKsNCKB0IcZTXOMPkyLohAoxMm5Njl5UUG048x5weEZ7xaQ8nNO8IFZm6CV7VnNqKHiuT+k9z8RwDHRfFw6LaKdhkWqlN1jsr3rPuEuTmuipuloSb6lJwPqNaM10wydFZfAQ8L9zfXpD+h5fF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gHMrvacA; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54MHA0an3079943
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 22 May 2025 10:10:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54MHA0an3079943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747933802;
	bh=PMEg8ra3XO2QAG2WCZTxzB5wfNGBy2hvSgxlIXLA5Dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gHMrvacAWDacAzBG/P5kDBglh0R2imuxf4kzjmLvyUmfYuGpn6aQsKTnqb3ShvlHv
	 8E8t1jhHl6XcPmJsvLTl3c9B5xGAi0stWKB78eFcXqgdsh6pjFdWBlbHV8dmp+5rjf
	 xxOCnMyrYuSmZ79ST/0X4xno43zxm+XurAI8QVkuPrz4rEH6I8vT5qcxFbS8sJDD+U
	 U+c+HwLbqN76MLLkCpBEAO7uedaiLxASpcyBki4Qpl9nm2TH8DphVjNbzNpeLc5J4z
	 Aho/+YMszL5Hj6x+BUHjnNF6b/ofPva2Ns7q3OBLg9qthIGdb1UfGx5GR4xsx36dDB
	 1WfZsdwMik0xg==
Message-ID: <7a9d29bd-d247-4e57-8330-14f6a5008864@zytor.com>
Date: Thu, 22 May 2025 10:10:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred/signal: Prevent single-step upon ERETU
 completion
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, stable@vger.kernel.org
References: <20250522060549.2882444-1-xin@zytor.com>
 <e32dc7de-9f97-4857-8e07-0905a94acfad@zytor.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <e32dc7de-9f97-4857-8e07-0905a94acfad@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2025 12:20 AM, H. Peter Anvin wrote:
> On 5/21/25 23:05, Xin Li (Intel) wrote:
>>   
>> +/*
>> + * To prevent infinite SIGTRAP handler loop if TF is used without an external
>> + * debugger, clear the software event flag in the augmented SS, ensuring no
>> + * single-step trap is pending upon ERETU completion.
>> + *
>> + * Note, this function should be called in sigreturn() before the original state
>> + * is restored to make sure the TF is read from the entry frame.
>> + */
>> +static __always_inline void prevent_single_step_upon_eretu(struct pt_regs *regs)
>> +{
>> +	/*
>> +	 * If the trap flag (TF) is set, i.e., the sigreturn() SYSCALL instruction
>> +	 * is being single-stepped, do not clear the software event flag in the
>> +	 * augmented SS, thus a debugger won't skip over the following instruction.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_X86_FRED) && cpu_feature_enabled(X86_FEATURE_FRED) &&
>> +	    !(regs->flags & X86_EFLAGS_TF))
>> +		regs->fred_ss.swevent = 0;
>> +}
>> +
> 
> Minor nit (and I should have caught this when I saw your patch earlier):
> 
> cpu_feature_enabled(X86_FEATURE_FRED) is unnecessary here, because when
> FRED is not enabled, regs->fred_ss.swevent will always be 0, and this
> bit has no function, so there is no point in making that extra test.

Yeah, less conditions, less complexity.  I will remove it.

Thanks!
     Xin

