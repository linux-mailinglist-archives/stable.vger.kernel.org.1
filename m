Return-Path: <stable+bounces-23876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037B0868C8F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BAC1C2113E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2AC137C32;
	Tue, 27 Feb 2024 09:42:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E91369A2
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026943; cv=none; b=EMBDKvqe7Ta5gPjB1C6bXKf/nifUSlrFQiWO4tZ1W9NRFtKDfHBuCJ4UuCu881nrX058gH4+SmkeS9kcIIeUdacm+ZSP8eIp4kEmXhlOncZeXvE6gM1GkNgyjCMlT64eBMj79OpAv/zbtDeCxkXP8d03T7IVGtDSMFlyvjfimrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026943; c=relaxed/simple;
	bh=Q73eZbnXegwz/8ZwkjAuhJf/WSl1lx64HRdNZaJRqbk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tnf94xj7gZ1DfTP1Ys+epZ4KAa2HRx9I6lOfAKjZop0Itz0qIjsU86j2yhZ2T2WaQ1oECO+igaEzevnz5dqbRLV/v58pG1oSsCAoa0OX4fUt1CzCepupFcvxVpeTJJym+xs2n3gj48BK89gVb4FuMAA+intsRgTAUFRBbrV7kSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d32f74833so2247734f8f.3
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 01:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709026940; x=1709631740;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NR0NfCN9+nj2pFAIzIcxmIC75lEZtY2QCKieu4rtf2I=;
        b=Nsq78c2wlnbxCMEBIuOtbqAVMLmTMqOl7PxNN/Xk6Iq7EK8F1pgJtANChxoK5quVx0
         57wYtcnceqQ5YMMZ1ZihwntbEfR5hgUfDeweRJ7o3ZulRAELM5Pvs4APeOTT2ufzZTc/
         M2JoxiBPx30+SK7I0rjtk08uh/8dCeGAlE8tzCERXCMZ+23DHTc5KjhhX7ug028DwUf5
         1awDph6iozG3MfYdEPJibEps7LYtUznitiSODUaLgTUGDIqTgNRjkIXBePxzQwFeQ31N
         DYCpsJlBISYUmj6iTu8dWPuVZ22qg+cwVGtEGmeqYXOnDZfDZR4rN+suf1xb/yXQKfFA
         w0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU4+WZOrtNVwR+8ceM7Uq0dxJmF9q2BYgaI/PZxaiizIl2E1Gs5QQCQSG4Mlt3y2hl0Z+t8HjrHlc2khU25kKAMFyp0PLvk
X-Gm-Message-State: AOJu0YxX8yJnrMMLx5BR7NHZKkIGsb6CVhtkrggEVI7RpegX9AB4mYjK
	xxA+sgH/ubexhPHU90rRuIyd/rX3J2TaUbjMLa2iEfHsvw5V0+vnpfAq5s6x
X-Google-Smtp-Source: AGHT+IE7+0y/prMP3zOuPPpEflWKoD6OEYk7GOlu/g5y3GzLor8cRHJgdNyREPDdBmpzqH6m+PgY1w==
X-Received: by 2002:a05:6000:1b8d:b0:33d:297d:75a9 with SMTP id r13-20020a0560001b8d00b0033d297d75a9mr7203989wru.24.1709026939626;
        Tue, 27 Feb 2024 01:42:19 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id by6-20020a056000098600b0033d568f8310sm10976586wrb.89.2024.02.27.01.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 01:42:18 -0800 (PST)
Message-ID: <fd8f2df0-563e-4f5c-aca4-bc92a14e9426@kernel.org>
Date: Tue, 27 Feb 2024 10:42:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7.y 1/6] x86/bugs: Add asm helpers for executing VERW
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 Alyssa Milburn <alyssa.milburn@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Peter Zijlstra <peterz@infradead.org>, Nikolay Borisov <nborisov@suse.com>
References: <20240226-delay-verw-backport-6-7-y-v1-0-ab25f643173b@linux.intel.com>
 <20240226-delay-verw-backport-6-7-y-v1-1-ab25f643173b@linux.intel.com>
 <c9ede8e2-5066-435b-bd1d-1971a8072952@kernel.org>
 <20240227082755.yl7ny34o33uotqww@desk>
 <abc65c4d-4731-4234-b8a2-5eaa4e5a52e7@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <abc65c4d-4731-4234-b8a2-5eaa4e5a52e7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 02. 24, 9:41, Jiri Slaby wrote:
>> Also, RIP-relative addressing was a requirement only for the initial
>> versions of the series, where the VERW operand was pointing within the
>> macro. For performance gains, later versions switched to the
>> implementation in which all VERW sites were pointing to single memory
>> location. With that, RIP-relative addressing could be droped in favor of
>> fixed addresses.
>>
>>> Will this work at all (it looks like verw would now touch random
>>> memory)?
>>
>> AFAIK, all memory operand variants of VERW have the CPU buffer clearing
>> behavior. I will confirm this with the CPU architects.
> 
> I might be too dumb to understand this, so sorry if the below does not 
> make sense. Neither I cannot see "why it works" in the minor patch you 
> sent (and incorporated here). You only explain it's easier for backports 
> and "was needed in earlier versions".
> 
> But verw can #PF (and actually used to before Nik invented the jmp 
> workaround in the SUSE backport). I assume it's the case when the store 
> of the segment (mds_verw_sel) cannot be accessed/read. Now, with fixed 
> addressing this works unless KASLR is employed. If it is, the fixed 
> address of mds_verw_sel no longer points to the correct memory. Or what 
> am I missing?

The assembler generates a relocation for the fixed address anyway. And 
the linker resolves it as rip-relative. At least the pair from my 
binutils-2.42.

But if it generates a rip-relative address, is < 6.5 with no support of 
rip-rel in alternatives still fine?

Another question: can we rely on the assembler to generate a relocation 
and on the linker to resolve it as rip-relative?

thanks,
-- 
js
suse labs


