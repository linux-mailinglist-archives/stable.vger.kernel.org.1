Return-Path: <stable+bounces-172824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9001B33E2C
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6767B48629F
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761062E717C;
	Mon, 25 Aug 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nPPJsa0x"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE52E7BDD
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121861; cv=none; b=kfWlNAfxa8XeLs2ma4L7iie6Y5NCFEN73gO1LskwVL6YT9NaVP4z9AZRzw4g0WtnonKqRHwwlymxP23LtYr+lAVLBt/xa8rICIOZ9boXpdBiL+kQGDjn/MHljEUhq5DydHZMN4P4VK+S7tSJgJ6Vf8yxfvQeMBVf3qoyFib2Mig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121861; c=relaxed/simple;
	bh=pwJCEMDpvX3gklff8xWinqIcMPxht82kzXUSa4aAw8Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kJdAGgGytm+6pmt43P78z0SgPOP7rqzfo/S/d7rWD5/pT22d8nmh0IgDV5lIMPuJkQZNvRDY4RHLgmoL70kHkn1mYb+Jw4GYYwC/lZ+yH6hEjBQzSfXYJSkIpQKy881SA5KLDn4Ncs1a1Z9sp4H68htlrqrjOFFVSfskkOKZXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nPPJsa0x; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <30a55f56-93c2-4408-b1a5-5574984fb45f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756121847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0E9DoNqxH8BhrYWKlmOL9GX4MsVdIQhY6Uu/0eN17PI=;
	b=nPPJsa0xezAuseaYyAKztO89AC2rWbR4RjjyDTrK9pem5DC8VI6SQBPctQ61hKlfEtvcRy
	ctw6+e+AciKKAJCaZT3I4/wXtIoiloms6v80MmCTJ4AXwsLL8NpmSHUMqqD4liNzn36M+X
	ovTmSgNUttMRPT4sTSIuDLaWVh/x0gQ=
Date: Mon, 25 Aug 2025 19:36:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
To: Finn Thain <fthain@linux-m68k.org>
Cc: akpm@linux-foundation.org, geert@linux-m68k.org,
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
In-Reply-To: <d95592ec-f51e-4d80-b633-7440b4e69944@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/25 19:19, Lance Yang wrote:
> Thanks for digging deeper!
> 
> On 2025/8/25 18:49, Finn Thain wrote:
>>
>> [Belated Cc linux-m68k...]
>>
>> On Mon, 25 Aug 2025, Lance Yang wrote:
>>
>>>
>>> On 2025/8/25 14:17, Finn Thain wrote:
>>>>
>>>> On Mon, 25 Aug 2025, Lance Yang wrote:
>>>>
>>>>>
>>>>> What if we squash the runtime check fix into your patch?
>>>>
>>>> Did my patch not solve the problem?
>>>
>>> Hmm... it should solve the problem for natural alignment, which is a
>>> critical fix.
>>>
>>> But it cannot solve the problem of forced misalignment from drivers
>>> using #pragma pack(1). The runtime warning will still trigger in those
>>> cases.
>>>
>>> I built a simple test module on a kernel with your patch applied:
>>>
>>> ```
>>> #include <linux/module.h>
>>> #include <linux/init.h>
>>>
>>> struct __attribute__((packed)) test_container {
>>>      char padding[49];
>>>      struct mutex io_lock;
>>> };
>>>
>>> static int __init alignment_init(void)
>>> {
>>>      struct test_container cont;
>>>      pr_info("io_lock address offset mod 4: %lu\n", (unsigned 
>>> long)&cont.io_lock % 4);
>>>      return 0;
>>> }
>>>
>>> static void __exit alignment_exit(void)
>>> {
>>>      pr_info("Module unloaded\n");
>>> }
>>>
>>> module_init(alignment_init);
>>> module_exit(alignment_exit);
>>> MODULE_LICENSE("GPL");
>>> MODULE_AUTHOR("x");
>>> MODULE_DESCRIPTION("x");
>>> ```
>>>
>>> Result from dmesg:
>>> [Mon Aug 25 15:44:50 2025] io_lock address offset mod 4: 1
>>>
>>
>> Thanks for sending code to illustrate your point. Unfortunately, I was 
>> not
>> able to reproduce your results. Tested on x86, your test module shows no
>> misalignment:
>>
>> [131840.349042] io_lock address offset mod 4: 0
>>
>> Tested on m68k I also get 0, given the patch at the top of this thread:
>>
>> [    0.400000] io_lock address offset mod 4: 0
>>
>>>
>>> As we can see, a packed struct can still force the entire mutex object
>>> to an unaligned address. With an address like this, the WARN_ON_ONCE can
>>> still be triggered.
> 
>>
>> I don't think so. But there is something unexpected going on here -- the
>> output from pahole appears to say io_lock is at offset 49, which seems to
>> contradict the printk() output above.
> 
> Interesting! That contradiction is the key. It seems we're seeing different
> compiler behaviors.
> 
> I'm on GCC 14.2.0 (Debian 14.2.0-19), and it appears to be strictly 
> respecting
> the packed attribute.
> 
> So let's print something more:
> 
> ```
> #include <linux/module.h>
> #include <linux/init.h>
> 
> struct __attribute__((packed)) test_container {
>      char padding[49];
>      struct mutex io_lock;
> };
> 
> static int __init alignment_init(void)
> {
>      struct test_container cont;
>      pr_info("Container base address      : %px\n", &cont);
>      pr_info("io_lock member address      : %px\n", &cont.io_lock);
>      pr_info("io_lock address offset mod 4: %lu\n", (unsigned 
> long)&cont.io_lock % 4);
>      return 0;
> }
> 
> static void __exit alignment_exit(void)
> {
>      pr_info("Module unloaded\n");
> }
> 
> module_init(alignment_init);
> module_exit(alignment_exit);
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("x");
> MODULE_DESCRIPTION("x");
> ```
> 
> Result from dmesg:
> 
> ```
> [Mon Aug 25 19:15:33 2025] Container base address      : ff1100063570f840
> [Mon Aug 25 19:15:33 2025] io_lock member address      : ff1100063570f871
> [Mon Aug 25 19:15:33 2025] io_lock address offset mod 4: 1
> ```
> 
> io_lock is exactly base + 49, resulting in misalignment.
> 
> Seems like your compiler is cleverly re-aligning the whole struct on the
> stack, but we can't rely on that behavior, as it's not guaranteed across
> all compilers or versions. wdyt?


Same here, using a global static variable instead of a local one. The result
is consistently misaligned.

```
#include <linux/module.h>
#include <linux/init.h>

static struct __attribute__((packed)) test_container {
     char padding[49];
     struct mutex io_lock;
} cont;

static int __init alignment_init(void)
{
     pr_info("Container base address      : %px\n", &cont);
     pr_info("io_lock member address      : %px\n", &cont.io_lock);
     pr_info("io_lock address offset mod 4: %lu\n", (unsigned 
long)&cont.io_lock % 4);
     return 0;
}

static void __exit alignment_exit(void)
{
     pr_info("Module unloaded\n");
}

module_init(alignment_init);
module_exit(alignment_exit);
MODULE_LICENSE("GPL");
MODULE_AUTHOR("x");
MODULE_DESCRIPTION("x");
```

Result from dmesg:

```
[Mon Aug 25 19:33:28 2025] Container base address      : ffffffffc28f0940
[Mon Aug 25 19:33:28 2025] io_lock member address      : ffffffffc28f0971
[Mon Aug 25 19:33:28 2025] io_lock address offset mod 4: 1
```

