Return-Path: <stable+bounces-179151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB43BB50A72
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 03:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86276565F7F
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 01:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D33221739;
	Wed, 10 Sep 2025 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BKaghRGO"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B514658D
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468903; cv=none; b=e6REWrOJD/nEkP6ewk9HuQ+STGIhq8XU0q5CDxw9GR8SQybM1CDmxgxR2n7imRXCKmbUVFUfGFXyFKja6xlPh/AvECNNsxrhuOOjr21/e1cC/LuUeqNXEDEj8pHTAMHePTFpYRcHz9uc3Zqm3gBXOdKx1KvZJ8CQplMTN3mR/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468903; c=relaxed/simple;
	bh=lNwyQ1qlgC5YOiwLCjfVvPjilzDWvlgRD5Sr/+vFbDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwINA5cWAwL12GQQXA5wdctH2NEUMInGqp2mpxn1Rtba7TGZ3u1facZQuTlo8+2s8zrUxgzYu7rWlaMmzdEpldMcRT77HtuMmh7q16LTBdwz8XPDzQSwJ+A78WTrkQ9oS2/OcWHMB+ePI1hqYPzTsGEaIF4EdAaB55GOImm0v7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BKaghRGO; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 21:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757468892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=07Yd4H765qOC6tzm5S7wF2VWIIKcE5+hjsYL92cJvP0=;
	b=BKaghRGOQ0MHnFTX33b2EgYcSDm+bEncTYRvENHbJ3QJO8IE3YcUPgrrCoChuicXfhNNep
	ncfJhA3J3wwuer9hfjm/wmZlMCMuaBJqvBjMmDL1q6T0tHQK4sMY1Nd6JD84pgLKyGo4lk
	mBC0eFg2rI3JdqYLf8pEOCswE20wL1c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, 
	amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com, 
	geert@linux-m68k.org, ioworker0@gmail.com, joel.granados@kernel.org, 
	jstultz@google.com, leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, mingo@redhat.com, 
	mingzhe.yang@ly.com, oak@helsinkinet.fi, peterz@infradead.org, rostedt@goodmis.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Message-ID: <gtie7ylcuftmi2jgzviipxnvjzcds46eqce4fxxalbutwphbe4@erwrj3p7udrz>
References: <20250909145243.17119-1-lance.yang@linux.dev>
 <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
 <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
 <ufkr7rkg7rsfo6ovsnwz2gqf4mtmmevb3mququeukqlryzwzmz@x4chw22ojvnu>
 <bea3d81c-2b33-a89d-ae26-7d565a5d2217@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea3d81c-2b33-a89d-ae26-7d565a5d2217@linux-m68k.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 10, 2025 at 11:35:56AM +1000, Finn Thain wrote:
> Similarly, on m68k, there is no issue with __alignof(long) == 2 because 
> these platforms don't trap on misaligned access. But that seems a bit 
> irrelevant to the real issue, which is not specific architectural quirks, 
> but the algorithms and their ongoing development.

Err, I believe the topic was just alignment and the breaking of commonly
held expectations :)

> 
> > ...
> > > 
> > > IMHO, good C doesn't make alignment assumptions, because that hinders 
> > > source code portability and reuse, as well as algorithm extensibility. 
> > > We've seen it before. The issue here [1] is no different from the 
> > > pointer abuse which we fixed in Cpython [2].
> > 
> > That kind of thinking really dates from before multithreaded and even 
> > lockless algorithms became absolutely pervasive, especially in the 
> > kernel.
> > 
> 
> What I meant was, "assumptions hinder portability etc." not "good C 
> hinders portability etc." (my bad).

Of course, but given the lack of a true atomic type in C there's no good
alternative way to avoid this landmine.

Also, grep for READ_ONCE/WRITE_ONCE in the kernel tree if you want to
see how big the issue is - ad then remember that only captures a
fraction of it :)

> 
> > These days, READ_ONCE() and WRITE_ONCE() are pervasive, and since C 
> > lacks any notion of atomics in the type system (the place this primarily 
> > comes up), it would go a long ways towards improving portability and 
> > eliminating nasty land mines.
> > 
> 
> Natural alignment would seem to be desirable for new ABIs, until you 
> realize that it implies wasted RAM on embedded systems and reduced data 
> locality (that is, cooler caches if you did this on i386).

For the data structures where it matters we tend to organize things by
natural alignment already.

If anyone wanted to gather precise numbers, there's memory allocation
profiling + pahole :)

