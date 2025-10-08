Return-Path: <stable+bounces-183575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B24BC32E2
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 05:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CE61898F94
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 03:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6298D221DB1;
	Wed,  8 Oct 2025 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T/3jXx84"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166621423C
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759892616; cv=none; b=lNiWV+OJ+yVnxSRNbc2JKboQlatxaEeoyN6HnYUhGdGNMuWhFSrjzQjz34hSZmtay5ZPkiybM1JL5+Qam0qbdGTzDkXPnId3PIJtYwh9ZPs3gMKswdo8PkqV6W7pWGvGheev8eLlE9274cibVu7uFPnLpeCo12KEhcmXo0yMkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759892616; c=relaxed/simple;
	bh=5yStW0L1wEARM1VcACJHqDCy7X/TSWEwGB67a2Fqnmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hf2xwSdrPiGz1jiKnIM8rdi6+JCiuMFz3xfJERQCzznQCIzhqbIhnUb0+vbIbsXbYrjm3x/r71Uzu3pXdHg+e2tUHF2mo570luvGHyFmx1P1o7a0rzHG27lIfzxkhHRW1IxzNe6GWxdYSfZnyhzrTlKe2hQbNlhiga+kjY+6MbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T/3jXx84; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <56784853-b653-4587-b850-b03359306366@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759892608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSRrtrvWgwS90ySr5nF6OQKQum7o9S6zWNvqm6k9XvM=;
	b=T/3jXx84Rfw++V6z2MKJJv5c/rPYfsL5Ui23RZkEQx9CDR0WnlRFujpQtx7DTK8morvqzQ
	fGf+hxuXI0wGprlzykRqYh0W/J+sSVWQbdk1l39Qun/FBJqNpmP2TIBlXlxC4mcFM9II/u
	MInrvhq4Nld0p1caXSOIDmVSFa3ddig=
Date: Wed, 8 Oct 2025 11:03:18 +0800
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
 Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Eero Tamminen <oak@helsinkinet.fi>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, amaindex@outlook.com,
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/8 08:40, Finn Thain wrote:
> 
> On Tue, 7 Oct 2025, Andrew Morton wrote:
> 
>>
>> Getting back to the $Subject at hand, are people OK with proceeding
>> with Lance's original fix?
>>
> 
> Lance's patch is probably more appropriate for -stable than the patch I
> proposed -- assuming a fix is needed for -stable.

Thanks!

Apart from that, I believe this fix is still needed for the hung task
detector itself, to prevent unnecessary warnings in a few unexpected
cases.

> 
> Besides those two alternatives, there is also a workaround:
> $ ./scripts/config -d DETECT_HUNG_TASK_BLOCKER
> which may be acceptable to the interested parties (i.e. m68k users).
> 
> I don't have a preference. I'll leave it up to the bug reporters (Eero and
> Geert).


