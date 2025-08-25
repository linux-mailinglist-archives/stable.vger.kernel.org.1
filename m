Return-Path: <stable+bounces-172799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AA8B3380C
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF09189A962
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5612882CC;
	Mon, 25 Aug 2025 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UjHepv8b"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67728F1
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108022; cv=none; b=pLmtIfzUUPW9+r02cgj6UPWID76z3K3BNSiQOM7/5/qv6hBun1oJEIGUCaJaveAywuuDO3aqTWzfMfVnHemnT1TA3sYuU8T77rp9HSexi2LEl4pjuD/ElIN1EizfU+c6QhtPodFXeA30wQ/ANOWJHyUv/mcX1EHsfV5eHmc4MRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108022; c=relaxed/simple;
	bh=Nbzd19yUjVLxyR4RmsPuP6P/OEWa8peSA4D/Bsvo6QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIMBaF2EnQH3GFT3wbAFsKcIu/hMVUjt6RaEjUNB6YJtUo8lQ2rhlhNCC/9I3Zm3q8xjgDCpJAbNjnnIxmL2qtexQQ+XNq+4m6mEWhYzRE8LsZc5h7PJc51eAXpbptcdMSFBe3xMFf0Og/9Vb0gFY4WrWRNymaZMpVk7ksUUtmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UjHepv8b; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756108009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuBezIELdTw6MY40H0rggeYKFrP3ZFapNdPV9JT04jc=;
	b=UjHepv8bsjSnrSIiGUpmII7coGV4lqLR7tStk3RW3xsbEqWay19GTGYB6hzWxDOPHELs5q
	Nst0pvGRUNWWzE2c6fJ1+9fMqcRyH+0tknS8BX+KolUbgA6aMS8dzVBlFv4NK3GQBRwdNi
	VkO8N+/sY7CMZE/kTPsxoMb+areJTRw=
Date: Mon, 25 Aug 2025 15:46:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>
Cc: akpm@linux-foundation.org, geert@linux-m68k.org,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi,
 peterz@infradead.org, stable@vger.kernel.org, will@kernel.org,
 Lance Yang <ioworker0@gmail.com>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825032743.80641-1-ioworker0@gmail.com>
 <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
 <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
 <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/25 14:17, Finn Thain wrote:
> 
> On Mon, 25 Aug 2025, Lance Yang wrote:
> 
>>
>> What if we squash the runtime check fix into your patch?
> 
> Did my patch not solve the problem?

Hmm... it should solve the problem for natural alignment, which is a
critical fix.

But it cannot solve the problem of forced misalignment from drivers using
#pragma pack(1). The runtime warning will still trigger in those cases.

I built a simple test module on a kernel with your patch applied:

```
#include <linux/module.h>
#include <linux/init.h>

struct __attribute__((packed)) test_container {
     char padding[49];
     struct mutex io_lock;
};

static int __init alignment_init(void)
{
     struct test_container cont;
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
[Mon Aug 25 15:44:50 2025] io_lock address offset mod 4: 1

As we can see, a packed struct can still force the entire mutex object
to an unaligned address. With an address like this, the WARN_ON_ONCE
can still be triggered.

That's why I proposed squashing the runtime check fix into your patch.
Then it can be cleanly backported to stop all the spurious warnings at
once.

I hope this clarifies things.


