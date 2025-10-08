Return-Path: <stable+bounces-183640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA5BC6B68
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 23:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CE84075DB
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 21:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1B520296E;
	Wed,  8 Oct 2025 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dUr0AYZK"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22E266584;
	Wed,  8 Oct 2025 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960544; cv=none; b=NnhMfm7ztlDievSu7ey7v6JYU+VPCqbae0C6p229ebnjHzBDPoP0NxnyRKjEY2DFDbms/opJO9Dr9pxQJr/iRELhY7NcEsbeRvqtl3BCrF0jFwPK3FwWJCdr1IfBD0SMGRLx16PuyZy+5iay+7ih3fyoX1wMaQEHojs4wI5rhNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960544; c=relaxed/simple;
	bh=W8sZ+BFTCFqdywOhx6jN5UpBCcjv8tYtA+nU9zRVybk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ar9HdbKN0XeDD8aSoP6kJ5yllTHZ2har2CseybRe813fPkRpqFWIoSS4QjCXIwgMIQ5/EjHiOpODyGPlIbttp2LGoGt+p/N3mHUlLJloT91HTJHbPiThlJknyo+JGwv67p/O2ymID5N6cC2QfqQGLbS7c4Fd5Lm3CZEle84o8Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dUr0AYZK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9ABE77A0038;
	Wed,  8 Oct 2025 17:55:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 08 Oct 2025 17:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759960540; x=1760046940; bh=fR1Nie9bPqSH+8AGTkokUlJXi6wRqyLLqLK
	19/Nvduo=; b=dUr0AYZKwOAHn5J/U/fC0j855M02UZTZeZe3m1DETCeso4o4uw9
	X7d8h877mcox+pcfQI0tCk/ifSduIaU8VPTP/EJLC/NeAhwOjwBt02tuCqPKGjO0
	qxhDetcxjkKsyxiQKZVXNZb7583tmyIv9ZV0aZRH9Wc/CJtuWpm8uRHFvGdoXRFx
	WzlxmclTXm63fdljUwFP9SuDig9mItaiHR4pOCIs9yv6MTgol86OBbjX/7FVyymd
	uoRXpKrcI6hQ6OAvAjEAfat3/q2BfH4lrH8MTC8A6MigRvLqwxCLGAk1NHGMni92
	MBn3W8HhdBm/YekHwrLi56G5SQmsfiXKOpQ==
X-ME-Sender: <xms:2t3maBwvwvd_fkOIocVdIZ0rNWggfRs8Mn_HzUEcukwT-tKHkFI2xg>
    <xme:2t3maM8GdLZL4rGy6n6GXniEyLLf5rn2QfkM77Td9pjluPXwjqElwBEUDpyIMjZ4I
    fvqtm3tHrOB780K8DGjOEQyLcQowavrJeIL7qRzvm6FABULtfKW46Q>
X-ME-Received: <xmr:2t3maGA5oVI2dSq0qSDqeWqgOieFvHEJ_XBek4XuBA7R5OXDoK438_vTxOcYjIGMQOLfs9h6f8G9o5zmDsb-ocx1pCrHkk2l8Zc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeggeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefieehjedvtefgiedtudethfekieelhfevhefgvddtkeekvdekhefftdekvedv
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdr
    ohhrghdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlrghntggvrdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopegrkhhpmhes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepghgvvghrtheslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepohgrkheshhgvlhhsihhnkhhinhgv
    thdrfhhipdhrtghpthhtohepkhgvnhhtrdhovhgvrhhsthhrvggvtheslhhinhhugidrug
    gvvhdprhgtphhtthhopegrmhgrihhnuggvgiesohhuthhlohhokhdrtghomhdprhgtphht
    thhopegrnhhnrgdrshgthhhumhgrkhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoh
    epsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhofihorhhk
    vghrtdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2t3maEf12_pG5T9nV9gE7wjP-D7mq4YOC5ZasN0owRMgBj22pBjamQ>
    <xmx:2t3maCF5NmYVOBFMIprk73QJ2uTkFeRl3fH9Vc3X3wqWfUuGyow1Kw>
    <xmx:2t3maOVJTTAoNeB3Hgbt9bAdCBKi_nH_XZ67GJo2DrgD_KlsBIlmNA>
    <xmx:2t3maCyHMIXYsbCYFUTtCaRxiZU3tWaSHtTP7IzXmPtba3rqp7ZILA>
    <xmx:3N3maLM4FlHuBIcV-GzRksRrghG-si3XrDithXLxHXvJKsjLNvsNkJS7>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 17:55:35 -0400 (EDT)
Date: Thu, 9 Oct 2025 08:55:21 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <lance.yang@linux.dev>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Eero Tamminen <oak@helsinkinet.fi>, 
    Kent Overstreet <kent.overstreet@linux.dev>, amaindex@outlook.com, 
    anna.schumaker@oracle.com, boqun.feng@gmail.com, ioworker0@gmail.com, 
    joel.granados@kernel.org, jstultz@google.com, leonylgao@tencent.com, 
    linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
    longman@redhat.com, mhiramat@kernel.org, mingo@redhat.com, 
    mingzhe.yang@ly.com, peterz@infradead.org, rostedt@goodmis.org, 
    senozhatsky@chromium.org, tfiga@chromium.org, will@kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
In-Reply-To: <3fa8182f-0195-43ee-b163-f908a9e2cba3@linux.dev>
Message-ID: <ad7cb710-0d5a-93b1-fa4d-efb236760495@linux-m68k.org>
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov> <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> <CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
 <inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp> <20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org> <b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org> <56784853-b653-4587-b850-b03359306366@linux.dev>
 <693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org> <23b67f9d-20ff-4302-810c-bf2d77c52c63@linux.dev> <2bd2c4a8-456e-426a-aece-6d21afe80643@linux.dev> <ba00388c-1d5b-4d95-054d-a6f09af41e7b@linux-m68k.org> <3fa8182f-0195-43ee-b163-f908a9e2cba3@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Wed, 8 Oct 2025, Lance Yang wrote:

> On 2025/10/8 18:12, Finn Thain wrote:
> > 
> > On Wed, 8 Oct 2025, Lance Yang wrote:
> > 
> >>
> >> In other words, we are not just fixing the bug reported by Eero and 
> >> Geert, but correcting the blocker tracking mechanism's flawed 
> >> assumption for -stable ;)
> >>
> >> If you feel this doesn't qualify as a fix, I can change the Fixes: 
> >> tag to point to the original commit that introduced this flawed 
> >> mechanism instead.
> >>
> > 
> > That's really a question for the bug reporters. I don't personally 
> > have a problem with CONFIG_DETECT_HUNG_TASK_BLOCKER so I can't say 
> > whether the fix meets the requirements set in 
> > Documentation/process/stable-kernel-rules.rst. And I still don't know
> 
> I'm a bit confused, as I recall you previously stating that "It's wrong 
> and should be fixed"[1].
> 

You took that quote out of context. Please go and read it again.

> To clarify, is your current position that it should be fixed in general, 
> but the fix should not be backported to -stable?
> 

To clarify, what do you mean by "it"? Is it the commentary discussed in 
[1]? The misalignment of atomics? The misalignment of locks? The alignment 
assumptions in your code? The WARN reported by Eero and Geert?

> If so, then I have nothing further to add to this thread and am happy to 
> let the maintainer @Andrew decide.
> 
> > what's meant by "unnecessary warnings in a few unexpected cases".
> 
> The blocker tracking mechanism will trigger a warning when it encounters 
> any unaligned lock pointer (e.g., from a packed struct). I don't think 
> that is the expected behavior.

Sure, no-one was expecting false positives.

I think you are conflating "misaligned" with "not 4-byte aligned". Your 
algorithm does not strictly require natural alignment, it requires 4-byte 
alignment of locks.

Regarding your concern about packed structs, please re-read this message: 
https://lore.kernel.org/all/CAMuHMdV-AtPm-W-QUC1HixJ8Koy_HdESwCCOhRs3Q26=wjWwog@mail.gmail.com/

AFAIK the problem with your code is nothing more than the usual difficulty 
encountered when porting between architectures that have different 
alignment rules for scalar variables.

Therefore, my question about the theoretical nature of the problem comes 
down to this.

Is the m68k architecture the only one producing actual false positives? 

Do you know of actual instances of locks in packed structs?

> Instead, it should simply skip any unaligned pointer it cannot handle. 
> For the stable kernels, at least, this is the correct behavior.
> 

Why? Are users of the stable branch actually affected?

> [1]
> https://lore.kernel.org/lkml/6ec95c3f-365b-e352-301b-94ab3d8af73c@linux-m68k.org/
> 
> 

