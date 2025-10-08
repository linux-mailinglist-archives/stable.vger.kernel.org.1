Return-Path: <stable+bounces-183606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C9BBC542E
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70A1F4E4BBD
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D394A286D72;
	Wed,  8 Oct 2025 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XN18ZBQH"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D8286420
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931339; cv=none; b=hePCWelSkcG1KfNbg7Wq8Ern5sgCTKNuyCP76mtjwudKB3gi1y0ZRijx5YFHRRf589vqmO7ws4aO4pl5hIAWxHTslESYn+FLHOwHtx4MqG7yHYdeDjLHLu9MoJ7lVgn4HpdhbZBlpQciEQfHZMfRoVWkPyXYJuqdm8u+ouXk0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931339; c=relaxed/simple;
	bh=GbSaa/EKZ5s8UkgtPrh/MX8WgMkQZPaiA6bJfdaGpgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfyNejVdYcqvAr4oysVx1+bAUSNL8C52uAlD57GoZm67eVROKqC2JpYXqb7O+QqbO0JkckSbqx8NHOChtsCRaf4iEzEaCHgD/N6yk2+IdITL3JTpszH98GjSfVzlgbAr33QRCqt2wymzQNGsc/DxOxHc8R7CNeoCL5QK5E6PlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XN18ZBQH; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3fa8182f-0195-43ee-b163-f908a9e2cba3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759931325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf5/duJrWVKUCDJFgAcXUExHgRsL5XyYj1G/kjKoQGw=;
	b=XN18ZBQHkL8VF42r5TRMQE022lIyv/4biRi92DxLzr+OwHWrQo1lBg7HW2YB6owPNKY/AP
	h3sdwVABCXdpNWT92wcOEWaDCwUIs7coRdTd6DNumvRABDWHVg3NmTg3WWMQ3spQWmrow/
	/rU1jTQvLss0mVrtlzpXkiR37xDte28=
Date: Wed, 8 Oct 2025 21:48:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Eero Tamminen <oak@helsinkinet.fi>,
 Kent Overstreet <kent.overstreet@linux.dev>, amaindex@outlook.com,
 anna.schumaker@oracle.com, boqun.feng@gmail.com, ioworker0@gmail.com,
 joel.granados@kernel.org, jstultz@google.com, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 longman@redhat.com, mhiramat@kernel.org, mingo@redhat.com,
 mingzhe.yang@ly.com, peterz@infradead.org, rostedt@goodmis.org,
 senozhatsky@chromium.org, tfiga@chromium.org, will@kernel.org,
 stable@vger.kernel.org
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <ba00388c-1d5b-4d95-054d-a6f09af41e7b@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/8 18:12, Finn Thain wrote:
> 
> On Wed, 8 Oct 2025, Lance Yang wrote:
> 
>>
>> In other words, we are not just fixing the bug reported by Eero and
>> Geert, but correcting the blocker tracking mechanism's flawed assumption
>> for -stable ;)
>>
>> If you feel this doesn't qualify as a fix, I can change the Fixes: tag
>> to point to the original commit that introduced this flawed mechanism
>> instead.
>>
> 
> That's really a question for the bug reporters. I don't personally have a
> problem with CONFIG_DETECT_HUNG_TASK_BLOCKER so I can't say whether the
> fix meets the requirements set in
> Documentation/process/stable-kernel-rules.rst. And I still don't know

I'm a bit confused, as I recall you previously stating that "It's wrong
and should be fixed"[1].

To clarify, is your current position that it should be fixed in general,
but the fix should not be backported to -stable?

If so, then I have nothing further to add to this thread and am happy
to let the maintainer @Andrew decide.

> what's meant by "unnecessary warnings in a few unexpected cases".

The blocker tracking mechanism will trigger a warning when it
encounters any unaligned lock pointer (e.g., from a packed struct). I
don't think that is the expected behavior. Instead, it should simply
skip any unaligned pointer it cannot handle. For the stable kernels,
at least, this is the correct behavior.

[1] 
https://lore.kernel.org/lkml/6ec95c3f-365b-e352-301b-94ab3d8af73c@linux-m68k.org/

