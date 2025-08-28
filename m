Return-Path: <stable+bounces-176544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38CCB39171
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 04:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E29246551C
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 02:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B8248883;
	Thu, 28 Aug 2025 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OEdAR1uH"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDE195FE8
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 02:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346734; cv=none; b=mPkYGFpTWi3AyAhnuCsgL+g6wG50N22w71cbBZ5xjETmtZt0s60z5SXj7FM8wL+mkrBBq47634G1T7hqgADcpewXU7XiRRNrqqVhNqP8CsK2tnoUhjVWRYkBLj4esUxpsEORhW2YqoMgmfZ6+RecEKmUzFalUJTPjEjsmzK+6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346734; c=relaxed/simple;
	bh=IiiK/TLSYzjTbuhRBbkspw8DwVRCSdJwRbF9f7BfnzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+yh7GwON+Ut+4peexj80fSrg49hkt74ukDBvTVc1nNz1VmQq5+sWDvrT6Nmn2WmVXBsGQ75npZryjqJlOaRlILrvtstoG5YGAkfMo6rjqn56gFMJnsCMGD9/qKfV/32qQd7JmioL7Smm8qB5YSQFRxzEcBuJ/a2t1aVWqdOebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OEdAR1uH; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cfb62b9d-9cbd-47dd-a894-3357027e2a50@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756346720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb2F2xDiL4eTGN41G2MHNYXODkWfWx3B+Sfl8F3SlJw=;
	b=OEdAR1uHhvyS3yB4J7+ExJ3vBSsoIRGDRSEgjJLQN0jVFDfw4h6Ix2tzNSSUoP3oIR85+f
	kaIZZxMQqSCzAUYpng0TFfAAKLFqQxm9fB+S9Bf+l8Y1mFC6PJe0EOIBVAVhX90gAuHH+9
	TpqCpbeKga7zbbp3YT9LlRDUFCCdXjI=
Date: Thu, 28 Aug 2025 10:05:11 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <4405ee5a-becc-7375-61a9-01304b3e0b20@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/28 07:43, Finn Thain wrote:
> 
> On Mon, 25 Aug 2025, Lance Yang wrote:
> 
>>
>> Same here, using a global static variable instead of a local one. The
>> result is consistently misaligned.
>>
>> ```
>> #include <linux/module.h>
>> #include <linux/init.h>
>>
>> static struct __attribute__((packed)) test_container {
>>      char padding[49];
>>      struct mutex io_lock;
>> } cont;
>>
>> static int __init alignment_init(void)
>> {
>>      pr_info("Container base address      : %px\n", &cont);
>>      pr_info("io_lock member address      : %px\n", &cont.io_lock);
>>      pr_info("io_lock address offset mod 4: %lu\n", (unsigned long)&cont.io_lock % 4);
>>      return 0;
>> }
>>
>> static void __exit alignment_exit(void)
>> {
>>      pr_info("Module unloaded\n");
>> }
>>
>> module_init(alignment_init);
>> module_exit(alignment_exit);
>> MODULE_LICENSE("GPL");
>> MODULE_AUTHOR("x");
>> MODULE_DESCRIPTION("x");
>> ```
>>
>> Result from dmesg:
>>
>> ```
>> [Mon Aug 25 19:33:28 2025] Container base address      : ffffffffc28f0940
>> [Mon Aug 25 19:33:28 2025] io_lock member address      : ffffffffc28f0971
>> [Mon Aug 25 19:33:28 2025] io_lock address offset mod 4: 1
>> ```
>>
> 
> FTR, I was able to reproduce that result (i.e. static storage):
> 
> [    0.320000] Container base address      : 0055d9d0
> [    0.320000] io_lock member address      : 0055da01
> [    0.320000] io_lock address offset mod 4: 1
> 
> I think the experiments you sent previously would have demonstrated the
> same result, except for the unpredictable base address that you sensibly
> logged in this version.

Thanks for taking the time to reproduce it!

This proves the problem can happen in practice (e.g., with packed structs),
so we need to ignore the unaligned pointers on the architectures that don't
trap for now.

Cheers,
Lance


