Return-Path: <stable+bounces-183645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C5BBC72AD
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 04:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5775234BE34
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B671C3F0C;
	Thu,  9 Oct 2025 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ibQ2QABF"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19231B4F1F
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975335; cv=none; b=Vc4t4tewMJeK3tzeV+pzh7coUplS0m5Kea7EIj4Oc/vLTSmfnizosBUDmg1RxkS819cyuE1nOhu2q58TsSKnxNQ2/h4NZkHaLUaazrnimo5tCxfiQGofYSIkHa/e5nPU3yZ1zhaNcQurlTHJdQCSv9ieqB9sr632BQSxu+c5NeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975335; c=relaxed/simple;
	bh=FGWwqKnQ6kJ8i65qahfQZ38o0N58kC2zqWCBjd710Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qy69INubNKnh6paqUCt6Mglpn1A/5cq10Dvn5OtFZnH5MOG3LebRTea0HwkH6Y72aNRv8NW+h5yN3eNVvKj249igs5PFQb5SSNblNmaKJC+LNcSbp1oZjgYZMiiZdLU3BySKUmUcjPZPzorjCnlPE4pnIwow190iDx5IF8bVJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ibQ2QABF; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e0b7551-698f-4ef6-919b-ff4cbe3aa11c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759975319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhDQlPsddEKheWIQpFcriCM6m7o0PSu3nTL17MTHX4o=;
	b=ibQ2QABFSTUpvgdiYujW8QvoiiTr1qEW3Tdy3UeDf8h5TEfQnjsr5maVJuqWlDZTTUlXD5
	yI3rzmoIa5SFI48PvMG3ZLD3PcxHf2ijRHO6zBJyHIVZ1/i0ruLKCavWH9QgnbffM0axmv
	synA/a4qrBBCMmUDmk+vT/aydAh+VYU=
Date: Thu, 9 Oct 2025 10:01:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Eero Tamminen <oak@helsinkinet.fi>,
 Kent Overstreet <kent.overstreet@linux.dev>, amaindex@outlook.com,
 anna.schumaker@oracle.com, boqun.feng@gmail.com, ioworker0@gmail.com,
 joel.granados@kernel.org, jstultz@google.com, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 longman@redhat.com, mhiramat@kernel.org, mingo@redhat.com,
 mingzhe.yang@ly.com, peterz@infradead.org, rostedt@goodmis.org,
 Finn Thain <fthain@linux-m68k.org>, senozhatsky@chromium.org,
 tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
References: <20250909145243.17119-1-lance.yang@linux.dev>
 <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
 <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
 <CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
 <inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp>
 <20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org>
 <b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org>
 <56784853-b653-4587-b850-b03359306366@linux.dev>
 <693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org>
 <23b67f9d-20ff-4302-810c-bf2d77c52c63@linux.dev>
 <2bd2c4a8-456e-426a-aece-6d21afe80643@linux.dev>
 <ba00388c-1d5b-4d95-054d-a6f09af41e7b@linux-m68k.org>
 <3fa8182f-0195-43ee-b163-f908a9e2cba3@linux.dev>
 <ad7cb710-0d5a-93b1-fa4d-efb236760495@linux-m68k.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <ad7cb710-0d5a-93b1-fa4d-efb236760495@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

@Andrew, what's your call on this?

I think we fundamentally disagree on whether this fix for known
false-positive warnings is needed for -stable.

Rather than continuing this thread, let's just ask the maintainer.

Thanks,
Lance

On 2025/10/9 05:55, Finn Thain wrote:
> 
> On Wed, 8 Oct 2025, Lance Yang wrote:
> 
>> On 2025/10/8 18:12, Finn Thain wrote:
>>>
>>> On Wed, 8 Oct 2025, Lance Yang wrote:
>>>
>>>>
>>>> In other words, we are not just fixing the bug reported by Eero and
>>>> Geert, but correcting the blocker tracking mechanism's flawed
>>>> assumption for -stable ;)
>>>>
>>>> If you feel this doesn't qualify as a fix, I can change the Fixes:
>>>> tag to point to the original commit that introduced this flawed
>>>> mechanism instead.
>>>>
>>>
>>> That's really a question for the bug reporters. I don't personally
>>> have a problem with CONFIG_DETECT_HUNG_TASK_BLOCKER so I can't say
>>> whether the fix meets the requirements set in
>>> Documentation/process/stable-kernel-rules.rst. And I still don't know
>>
>> I'm a bit confused, as I recall you previously stating that "It's wrong
>> and should be fixed"[1].
>>
> 
> You took that quote out of context. Please go and read it again.
> 
>> To clarify, is your current position that it should be fixed in general,
>> but the fix should not be backported to -stable?
>>
> 
> To clarify, what do you mean by "it"? Is it the commentary discussed in
> [1]? The misalignment of atomics? The misalignment of locks? The alignment
> assumptions in your code? The WARN reported by Eero and Geert?
> 
>> If so, then I have nothing further to add to this thread and am happy to
>> let the maintainer @Andrew decide.
>>
>>> what's meant by "unnecessary warnings in a few unexpected cases".
>>
>> The blocker tracking mechanism will trigger a warning when it encounters
>> any unaligned lock pointer (e.g., from a packed struct). I don't think
>> that is the expected behavior.
> 
> Sure, no-one was expecting false positives.
> 
> I think you are conflating "misaligned" with "not 4-byte aligned". Your
> algorithm does not strictly require natural alignment, it requires 4-byte
> alignment of locks.
> 
> Regarding your concern about packed structs, please re-read this message:
> https://lore.kernel.org/all/CAMuHMdV-AtPm-W-QUC1HixJ8Koy_HdESwCCOhRs3Q26=wjWwog@mail.gmail.com/
> 
> AFAIK the problem with your code is nothing more than the usual difficulty
> encountered when porting between architectures that have different
> alignment rules for scalar variables.
> 
> Therefore, my question about the theoretical nature of the problem comes
> down to this.
> 
> Is the m68k architecture the only one producing actual false positives?
> 
> Do you know of actual instances of locks in packed structs?
> 
>> Instead, it should simply skip any unaligned pointer it cannot handle.
>> For the stable kernels, at least, this is the correct behavior.
>>
> 
> Why? Are users of the stable branch actually affected?
> 
>> [1]
>> https://lore.kernel.org/lkml/6ec95c3f-365b-e352-301b-94ab3d8af73c@linux-m68k.org/
>>
>>


