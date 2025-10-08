Return-Path: <stable+bounces-183586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404FEBC38A7
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 09:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D2119E0872
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 07:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D542F0C75;
	Wed,  8 Oct 2025 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F5wmyozk"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59C165F16;
	Wed,  8 Oct 2025 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907409; cv=none; b=WBCPWFry78ERbaeEmfbuOR4RT2GnY0Ds3Wwj0SPW0ob7v+vCoMtu2IOVZzSBa/lIb76ftvxDgFEx0doI9OWF7BTamU1Qu3CgYGWimAsmO7g68MeHFrDDpLpxNBZYoBrjeI4dAdVjtIe5xAFjWXg9wJNGf//1pYjhAjFTqNtzPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907409; c=relaxed/simple;
	bh=VQJRkZRtjm9yYWfgQgpaOG+NO/ZbwOJN3/eg/6wIot4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud0H+9+SgrTQtHTn2R5pQafjQc1AiEfCc7ikL37QzFvg9GAcgo/cxIXuzJ9LHa8C7unhk10rp9i1bvOscqUh7IgzOEUqfGq/YGl4lLv4ImCHGj31Zzh9vTkdbeyPtzy3QkGI5acfuKAWC1MdUBfJJwYzyANez/OM5FKMcgr06ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F5wmyozk; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <23b67f9d-20ff-4302-810c-bf2d77c52c63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759907403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJE2iJraxcGKQYdozv2wRe9vFO3p9uVwcxrTzZaEgVA=;
	b=F5wmyozke8Z7AcxH5nXvRJXhnHUNF8spAp2HepNhPC948/KGjmk5rYgOkVRLqqjmzT4gOc
	nHr3eFtstfJuEyxDUpUpOIJziHjK6CtXqBIlqKmGQmiApZoep+3PGjmiBvDc6RJDQ1OC+c
	b7/wlbrLmCgrpuixony81PuBKC4BGU0=
Date: Wed, 8 Oct 2025 15:09:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
To: Finn Thain <fthain@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Eero Tamminen
 <oak@helsinkinet.fi>, Kent Overstreet <kent.overstreet@linux.dev>,
 amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com,
 ioworker0@gmail.com, joel.granados@kernel.org, jstultz@google.com,
 leonylgao@tencent.com, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org,
 mingo@redhat.com, mingzhe.yang@ly.com, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, tfiga@chromium.org,
 will@kernel.org, stable@vger.kernel.org
References: <20250909145243.17119-1-lance.yang@linux.dev>
 <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
 <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
 <CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
 <inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp>
 <20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org>
 <b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org>
 <56784853-b653-4587-b850-b03359306366@linux.dev>
 <693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/8 14:14, Finn Thain wrote:
> 
> On Wed, 8 Oct 2025, Lance Yang wrote:
> 
>> On 2025/10/8 08:40, Finn Thain wrote:
>>>
>>> On Tue, 7 Oct 2025, Andrew Morton wrote:
>>>
>>>> Getting back to the $Subject at hand, are people OK with proceeding
>>>> with Lance's original fix?
>>>>
>>>
>>> Lance's patch is probably more appropriate for -stable than the patch I
>>> proposed -- assuming a fix is needed for -stable.
>>
>> Thanks!
>>
>> Apart from that, I believe this fix is still needed for the hung task
>> detector itself, to prevent unnecessary warnings in a few unexpected
>> cases.
>>
> 
> Can you be more specific about those cases? A fix for a theoretical bug
> doesn't qualify for -stable branches. But if it's a fix for a real bug, I
> have misunderstood Andrew's question...

I believe it is a real bug, as it was reported by Eero and Geert[1].

The blocker tracking mechanism in -stable assumes that lock pointers
are at least 4-byte aligned. As I mentioned previously[2], this
assumption fails for packed structs on architectures that don't trap
on unaligned access.

Of course, we could always improve the mechanism to not make
assumptions. But for -stable, this fix completely resolves the issue
by ignoring any unaligned pointer, whatever the cause (e.g., packed
structs, non-native alignment, etc.).

So we can all sleep well at night again :)

[1] 
https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
[2] 
https://lore.kernel.org/lkml/cfb62b9d-9cbd-47dd-a894-3357027e2a50@linux.dev/

> 
>>>
>>> Besides those two alternatives, there is also a workaround:
>>> $ ./scripts/config -d DETECT_HUNG_TASK_BLOCKER
>>> which may be acceptable to the interested parties (i.e. m68k users).
>>>
>>> I don't have a preference. I'll leave it up to the bug reporters (Eero
>>> and Geert).
>>


