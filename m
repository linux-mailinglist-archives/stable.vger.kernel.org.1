Return-Path: <stable+bounces-176403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E4B3715E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FFC1BC0106
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D9A1FECAB;
	Tue, 26 Aug 2025 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fZ0A2Zb+"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279131A553
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229620; cv=none; b=N4e6gV5HyMcfDt5bcMdPGu4pCRlhqsSWhP3fphE4XCnE9VWGZhNOI/ZXnvQav9+Ec3XCIcYNxPB5WloUv2MIADaF3REWeZkBmUg/0zsuPtmrueD8sIFsaPOna/ayKYO4759/YjoAmd70GdiwfoyQCaKbOqIxy5hR6FubvaQhw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229620; c=relaxed/simple;
	bh=Lv/0nHQLDanSD5J0vZpr9/RzK4ZHra4XsbNospdyjbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bljqd0msd9HCMR9F3MvUb7MSoPIsc9Rlm55Pps5kICv6cwnayW3zNY7Kzw/63MEvmad5TkqpnWa8PPj6FuBbfAL7QikWxt0O27uVxXg71kyYy0AHkDk8q+D9IYiSmwMm4GwNnqiXWWX/MO53gvn0/yR+cCO/iEbF5NAkwhKHgNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fZ0A2Zb+; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea6baf8d-683b-45d8-9719-7dbf207c1ab5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756229616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUoqxcUlPg3O6Yzt47yvZHjLSL3Kl4wtFO6GsITh3g4=;
	b=fZ0A2Zb+GdeYtJTftL2vzGPKV7FeRtXI16gLsUkeuFS6ZIQjHxEs7S7eAT0YdtlYyvCglT
	/ISJqKqVJcDN/sJqU//4imqr++r4vHhCnHs3N98dkrZ7Bf+2QHKFnWiz030A+bbejUYCOy
	roVHPJ3HkUOgswuiOK5b+g2WmLPZGlk=
Date: Wed, 27 Aug 2025 01:33:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Content-Language: en-US
To: Eero Tamminen <oak@helsinkinet.fi>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Andrew Morton <akpm@linux-foundation.org>,
 Finn Thain <fthain@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <1a5ce56a-d0d0-481e-b663-a7b176682a65@helsinkinet.fi>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <1a5ce56a-d0d0-481e-b663-a7b176682a65@helsinkinet.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Eero,

On 2025/8/26 23:22, Eero Tamminen wrote:
> Hi Finn & Lance,
> 
> On 25.8.2025 5.03, Finn Thain wrote:
>> Some recent commits incorrectly assumed the natural alignment of locks.
>> That assumption fails on Linux/m68k (and, interestingly, would have 
>> failed
>> on Linux/cris also). This leads to spurious warnings from the hang check
>> code. Fix this bug by adding the necessary 'aligned' attribute.
> [...]
>> Reported-by: Eero Tamminen <oak@helsinkinet.fi>
>> Closes: https://lore.kernel.org/lkml/ 
>> CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
>> Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded 
>> blocker")
>> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
>> ---
>> I tested this on m68k using GCC and it fixed the problem for me. AFAIK,
>> the other architectures naturally align ints already so I'm expecting to
>> see no effect there.
> 
> Yes, it fixes both of the issues (warnings & broken console):
>      Tested-by: Eero Tamminen <oak@helsinkinet.fi>
> 
> (Emulated Atari Falcon) boot up performance with this is within normal 
> variation.
> 
> 
> On 23.8.2025 10.49, Lance Yang wrote:
>  > Anyway, I've prepared two patches for discussion, either of which should
>  > fix the alignment issue :)
>  >
>  > Patch A[1] adjusts the runtime checks to handle unaligned pointers.
>  > Patch B[2] enforces 4-byte alignment on the core lock structures.
>  >
>  > Both tested on x86-64.
>  >
>  > [1] https://lore.kernel.org/lkml/20250823050036.7748-1- 
> lance.yang@linux.dev
>  > [2] https://lore.kernel.org/lkml/20250823074048.92498-1-
>  > lance.yang@linux.dev
> 
> Same goes for both of these, except that removing warnings makes minimal 
> kernel boot 1-2% faster than 4-aligning the whole struct.

Thanks a lot for testing!

Cheers,
Lance

