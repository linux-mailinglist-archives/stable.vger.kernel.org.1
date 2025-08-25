Return-Path: <stable+bounces-172852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB2B33F8A
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 14:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1771A84272
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A88347DD;
	Mon, 25 Aug 2025 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TysLTrhk"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972723E359
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125207; cv=none; b=La4z0h/4QPOv2Fku4lMUfxPLi+CKZMo7Jh8/eIrX0fLbTbiPWbpD7EmprvYwLI2nn0hybGUajsTjCrRsdUddU+rbHCd+PzWOEwYBucvyCy+uxqxfIILksnF57j2wzYyEtSiq2KDreJV+3ZUGck3D6Wz5pmKqIhHnq6ebIFjNS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125207; c=relaxed/simple;
	bh=43Ge/s4lY/ITVrNgNWTypo7V3guJjCot5tlJ+eiF3ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBMJS3DTZP5mP+xCDVGpwSqATgupBtkfw9J45HS0PbfJq/lUauCrK6JfKHIm6rfDfUBZJtOIYc5VMrwZJA9gGBlaB9rgkMoV43CUGICX7n6GX48qzG2F72SRIhOMH97rudjbDRIdU1Nc2yMoe41zqjMDbyIozzOgcGBxLFm+Vuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TysLTrhk; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b199a90c-4a7f-42bf-9d17-d96f63bb5e62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756125197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iP/mSVckOFLKq8yvIsCRKsJHk3PSSQEgw4qKGeCcFCE=;
	b=TysLTrhkKXPNpnBAmgUyB/9L+mJ2j4PEIhgvv8rQEX4EdyY27A+tS2RnT0Hjmm5q+0l5i1
	iyGc12kjDY7Gl0IKU7e3FMzu+vUDKS/+8q6JIih0wdfDsab/trQ/rLP2Jf1H1jtZjylTOV
	WVhKpp6KjmI88JP+SpCZSwaUnDA1oY8=
Date: Mon, 25 Aug 2025 20:33:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>,
 David Laight <david.laight.linux@gmail.com>
Cc: akpm@linux-foundation.org, geert@linux-m68k.org,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi,
 peterz@infradead.org, stable@vger.kernel.org, will@kernel.org,
 Lance Yang <ioworker0@gmail.com>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825032743.80641-1-ioworker0@gmail.com>
 <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
 <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
 <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
 <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev>
 <20250825130715.3a1141ed@pumpkin>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250825130715.3a1141ed@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/25 20:07, David Laight wrote:
> On Mon, 25 Aug 2025 15:46:42 +0800
> Lance Yang <lance.yang@linux.dev> wrote:
> 
>> On 2025/8/25 14:17, Finn Thain wrote:
>>>
>>> On Mon, 25 Aug 2025, Lance Yang wrote:
>>>    
>>>>
>>>> What if we squash the runtime check fix into your patch?
>>>
>>> Did my patch not solve the problem?
>>
>> Hmm... it should solve the problem for natural alignment, which is a
>> critical fix.
>>
>> But it cannot solve the problem of forced misalignment from drivers using
>> #pragma pack(1). The runtime warning will still trigger in those cases.
>>
>> I built a simple test module on a kernel with your patch applied:
>>
>> ```
>> #include <linux/module.h>
>> #include <linux/init.h>
>>
>> struct __attribute__((packed)) test_container {
>>       char padding[49];
>>       struct mutex io_lock;
>> };
>>
>> static int __init alignment_init(void)
>> {
>>       struct test_container cont;
>>       pr_info("io_lock address offset mod 4: %lu\n", (unsigned long)&cont.io_lock % 4);
> 
> Doesn't that give a compilation warning from 'taking the address of a packed member'?
> Ignore that at your peril.

Hmm, I don't see that acctully ...

> 
> More problematic is that, IIRC, m68k kmalloc() allocates 16bit aligned memory.
> This has broken other things in the past.
> I doubt that increasing the alignment to 32bits would make much difference
> to the kernel memory footprint.

@Finn Given this new information, how about we just apply the runtime check
fix for now?

Since we plan to remove the entire pointer-encoding scheme later anyway, a
minimal and targeted change could be the logical choice. It's easy and safe
to backport, and it cleanly stops the warnings from all sources without
introducing new risks - exactly what we need for stable kernels.

Cheers,
Lance

