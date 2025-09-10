Return-Path: <stable+bounces-179147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF82CB509FF
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 02:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC5E5E11D9
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 00:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF481C700C;
	Wed, 10 Sep 2025 00:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vds3mBrW"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE713AD1C
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465512; cv=none; b=Su0z1jUOsiwsWHoFrz3FmZdLg7YzRZf7ID6e34DMVtcsndekaFZTnmKxXf55qewlqx9HkrTkxafBT3VF2SnwExRIIR9ebEtH3pWjfn38/6vyOR9mbAY00hlyJpSGdQHISAgYMrkqyFbwHUTtntQQ5xPJW0QaBGzGPiRXeClyOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465512; c=relaxed/simple;
	bh=QS0LPsV1AZdLXItNY4UDYirhob+/Y/E1e6f0lusByOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYh2icw3h8g55sYp907hERQTILW1EUY4/ZFZXRst03wdWIs1AhTU2hWlyMv/Nk/m8lJF/zM1PvjtO1oArVT30ec10VTb61+ZEnuAFlZt4ogfLcmBJbgi0wkondgzCqhyGKtNqYLY0uH6iccvx6CWhFHJX5mpODfq62BD5G+pGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vds3mBrW; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 20:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757465507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEcZ+4LpqvsoBpDv5Pc439qYu8Se1iA78e4Hvoihta0=;
	b=vds3mBrWbGzaiZu0OCfI/rKaCgYv8OetxS5dZY0jlCMivaYJH8qD52ynDOFVFbh6PWcvsT
	tRARO0VZCWV8zGYzMIXCrt5jbw5CZK/mWKYu2AFjOOy61wnzA55q6jL3DrTX4sShJulxwp
	xa41t5sF1PKRk8gkRUvLQDgpsdxwK/I=
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
Message-ID: <ufkr7rkg7rsfo6ovsnwz2gqf4mtmmevb3mququeukqlryzwzmz@x4chw22ojvnu>
References: <20250909145243.17119-1-lance.yang@linux.dev>
 <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
 <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 10, 2025 at 10:07:04AM +1000, Finn Thain wrote:
> 
> On Tue, 9 Sep 2025, Kent Overstreet wrote:
> 
> > On Tue, Sep 09, 2025 at 10:52:43PM +0800, Lance Yang wrote:
> > > From: Lance Yang <lance.yang@linux.dev>
> > > 
> > > The blocker tracking mechanism assumes that lock pointers are at least
> > > 4-byte aligned to use their lower bits for type encoding.
> > > 
> > > However, as reported by Eero Tamminen, some architectures like m68k
> > > only guarantee 2-byte alignment of 32-bit values. This breaks the
> > > assumption and causes two related WARN_ON_ONCE checks to trigger.
> > 
> > Isn't m68k the only architecture that's weird like this?
> > 
> 
> No. Historically, Linux/CRIS did not naturally align integer types either. 
> AFAIK, there's no standard that demands natural alignment of integer 
> types. Linux ABIs differ significantly.
> 
> For example, Linux/i386 does not naturally align long longs. Therefore, 
> x86 may be expected to become the next m68k (or CRIS) unless such 
> assumptions are avoided and alignment requirements are made explicit.

That doesn't really apply; i386's long long is ugly but it's not as much
of an issue in practice, because it's greater than a machine word.

> The real problem here is the algorithm. Some under-resourced distros 
> choose to blame the ABI instead of the algorithm, because in doing so, 
> they are freed from having to work to improve upstream code bases.

Hang on, let's avoid playing the blame game. It's perfectly reasonable
to view standards not as holy religious texts that must be adhered to;
these things were written down when specifications were much looser.

> 
> IMHO, good C doesn't make alignment assumptions, because that hinders 
> source code portability and reuse, as well as algorithm extensibility. 
> We've seen it before. The issue here [1] is no different from the pointer 
> abuse which we fixed in Cpython [2].

That kind of thinking really dates from before multithreaded and even
lockless algorithms became absolutely pervasive, especially in the
kernel.

These days, READ_ONCE() and WRITE_ONCE() are pervasive, and since C
lacks any notion of atomics in the type system (the place this primarily
comes up), it would go a long ways towards improving portability and
eliminating nasty land mines.

