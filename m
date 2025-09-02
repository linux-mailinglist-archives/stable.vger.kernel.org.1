Return-Path: <stable+bounces-177193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1077AB4042C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD581B22B4E
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC93074AE;
	Tue,  2 Sep 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w5bHHYAd"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E5732ED40
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819876; cv=none; b=tjqUOeR+xzG8imL3l3vmnDBlg9m2t0lwPb0F3JcJ/P7eMTH7wqMnGKMDWEGie9fSAyIt1OgP14cyOrHdiWtxBvl0IejsKZLHEhA7Njx7szq72gMrelHLFnjkJEBSG+Eu2lcbvYm+uCuiQ5axbQSu3RvX3R1qZxJ7GbS2nHuKlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819876; c=relaxed/simple;
	bh=pDe7Bax8OHI5BmNveGIn98X/IVs5G4OLXHlf6nPqWdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPCxPCOBy9uGdhYUSatKWL1kdnilCvoDZl3G+TG7GTOoeiXuvU/V3yk2hxYpPrf1BySxln2Pq9Nlk82pbpY/dw5Gnztc3E/c7PdvlGwUf2zjt8vyCsaj4QjvWY31yO8SRrXPVEXWd1ACwbD241iseYrx5eVgsj6FK62273axMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w5bHHYAd; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f6835c03-3c3f-40ee-8000-f53f49d2b4a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756819860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40Z84sgwetMbmmZdXb2WLa4xBqxAl/JOWhj9T2RQau8=;
	b=w5bHHYAdZAGiudzrFbS4Z3VV4YzJjmmuecFyP2MuFdT8pGwvYYKI389jfNPyARZoSThCvD
	VfYnAhdn75HlLNyMAvVsWMgf01PlsCAY4ORoSxlMjXWuIS/JRQ/9WqHocixT1MshVEeZpz
	rALW9o030eIJfHuHIyPozab3ApZYPlY=
Date: Tue, 2 Sep 2025 21:30:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@linux-m68k.org>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi,
 peterz@infradead.org, stable@vger.kernel.org, will@kernel.org,
 Lance Yang <ioworker0@gmail.com>, linux-m68k@lists.linux-m68k.org
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825032743.80641-1-ioworker0@gmail.com>
 <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
 <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
 <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
 <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev>
 <d07778f8-8990-226b-5171-4a36e6e18f32@linux-m68k.org>
 <d95592ec-f51e-4d80-b633-7440b4e69944@linux.dev>
 <30a55f56-93c2-4408-b1a5-5574984fb45f@linux.dev>
 <4405ee5a-becc-7375-61a9-01304b3e0b20@linux-m68k.org>
 <cfb62b9d-9cbd-47dd-a894-3357027e2a50@linux.dev>
 <CAMuHMdV-AtPm-W-QUC1HixJ8Koy_HdESwCCOhRs3Q26=wjWwog@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CAMuHMdV-AtPm-W-QUC1HixJ8Koy_HdESwCCOhRs3Q26=wjWwog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Geert,

On 2025/9/1 16:45, Geert Uytterhoeven wrote:
> Hi Lance,
> 
> On Thu, 28 Aug 2025 at 04:05, Lance Yang <lance.yang@linux.dev> wrote:
>> On 2025/8/28 07:43, Finn Thain wrote:
>>> On Mon, 25 Aug 2025, Lance Yang wrote:
>>>> Same here, using a global static variable instead of a local one. The
>>>> result is consistently misaligned.
>>>>
>>>> ```
>>>> #include <linux/module.h>
>>>> #include <linux/init.h>
>>>>
>>>> static struct __attribute__((packed)) test_container {
>>>>       char padding[49];
>>>>       struct mutex io_lock;
>>>> } cont;
>>>>
>>>> static int __init alignment_init(void)
>>>> {
>>>>       pr_info("Container base address      : %px\n", &cont);
>>>>       pr_info("io_lock member address      : %px\n", &cont.io_lock);
>>>>       pr_info("io_lock address offset mod 4: %lu\n", (unsigned long)&cont.io_lock % 4);
>>>>       return 0;
>>>> }
>>>>
>>>> static void __exit alignment_exit(void)
>>>> {
>>>>       pr_info("Module unloaded\n");
>>>> }
>>>>
>>>> module_init(alignment_init);
>>>> module_exit(alignment_exit);
>>>> MODULE_LICENSE("GPL");
>>>> MODULE_AUTHOR("x");
>>>> MODULE_DESCRIPTION("x");
>>>> ```
>>>>
>>>> Result from dmesg:
>>>>
>>>> ```
>>>> [Mon Aug 25 19:33:28 2025] Container base address      : ffffffffc28f0940
>>>> [Mon Aug 25 19:33:28 2025] io_lock member address      : ffffffffc28f0971
>>>> [Mon Aug 25 19:33:28 2025] io_lock address offset mod 4: 1
>>>> ```
>>>>
>>>
>>> FTR, I was able to reproduce that result (i.e. static storage):
>>>
>>> [    0.320000] Container base address      : 0055d9d0
>>> [    0.320000] io_lock member address      : 0055da01
>>> [    0.320000] io_lock address offset mod 4: 1
>>>
>>> I think the experiments you sent previously would have demonstrated the
>>> same result, except for the unpredictable base address that you sensibly
>>> logged in this version.
>>
>> Thanks for taking the time to reproduce it!
>>
>> This proves the problem can happen in practice (e.g., with packed structs),
>> so we need to ignore the unaligned pointers on the architectures that don't
>> trap for now.
> 
> Putting locks inside a packed struct is definitely a Very Bad Idea
> and a No Go.  Packed structs are meant to describe memory data and

Right. That's definitely not how packed structs should be used ;)

> MMIO register layouts, and must not contain control data for critical
> sections.

Unfortunately, this patten was found in an in-tree driver, as reported[1]
by kernel test robot, and there might be other undiscovered instances ...

[1] 
https://lore.kernel.org/oe-kbuild-all/202508240539.ARmC1Umu-lkp@intel.com

Cheers,
Lance

