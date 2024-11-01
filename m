Return-Path: <stable+bounces-89529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7419B9990
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 21:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A102824E2
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE11E1D9588;
	Fri,  1 Nov 2024 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hTJPHP6h"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429501D0F77
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493531; cv=none; b=D4Yw4jKSawTC9bxvUTonE6wO09ZPvAmG0/EgCJ/ofxcdTrG7w5JxGDvDmuwiMi3S916hZPXvaz0U5B7KFWcbi6hMH2S3MgZcHqy7c/yjV7bX95/rPcjikJQCDvhxgbR2N45PSQLQRUYVV6UveStELFkmmxWgFqDOTILGXjGuPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493531; c=relaxed/simple;
	bh=NCS2luq8mYhP/9G3a2do+e48ZgCc1j3lR8FK24tvkQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4/Ep0RXminvRnExQDfrJD5ir6AukbqF+URPwxvx/Ev3UQKrgCjA1PvF2mv2j9MXGSN24NBPyGqo/68jZOqV/C03PrjN+YMpQJnrECUcqCG+CR969GR8ylPF9CL8YfFGNoGPk/gN18VKOnp5e3EgpoWGT9O4x17h6rtd6Vm7OcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hTJPHP6h; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Nov 2024 20:38:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730493526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ms/9TQIzfqjeevMFuhJ63c3HeS+oXiwuqUvr6GFnvY4=;
	b=hTJPHP6hZkpZzYxX1DQnWugFXcjksyxYGgdBhJ+h3jVEFFTgWUNMGAFh3dEDqZztAS/Mny
	TVvTdtLH9x2I3MtefRr4+vbAljEH/KiE90wW6xoZHhlfk4SfxWfEd+B0YNgT70e8co+FWC
	gNF8oWloytHmi+zJyb8tMvMRv1LJU2Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
	Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <ZyU8UNKLNfAi-U8F@google.com>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 01, 2024 at 02:51:00PM -0500, Eric W. Biederman wrote:
> Roman Gushchin <roman.gushchin@linux.dev> writes:
> 
> > Prior to commit d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of
> > ucounts") UCOUNT_RLIMIT_SIGPENDING rlimit was not enforced for a class
> > of signals. However now it's enforced unconditionally, even if
> > override_rlimit is set.
> 
> Not true.
> 
> It added a limit on the number of siginfo structures that
> a container may allocate.  Have you tried not limiting your
> container?
> 
> >This behavior change caused production issues.
> 
> > For example, if the limit is reached and a process receives a SIGSEGV
> > signal, sigqueue_alloc fails to allocate the necessary resources for the
> > signal delivery, preventing the signal from being delivered with
> > siginfo. This prevents the process from correctly identifying the fault
> > address and handling the error. From the user-space perspective,
> > applications are unaware that the limit has been reached and that the
> > siginfo is effectively 'corrupted'. This can lead to unpredictable
> > behavior and crashes, as we observed with java applications.
> 
> Note.  There are always conditions when the allocation may fail.
> The structure is allocated with __GFP_ATOMIC so it is much more likely
> to fail than a typical kernel memory allocation.
> 
> But I agree it does look like there is a quality of implementation issue
> here.
> 
> > Fix this by passing override_rlimit into inc_rlimit_get_ucounts() and
> > skip the comparison to max there if override_rlimit is set. This
> > effectively restores the old behavior.
> 
> Instead please just give the container and unlimited number of siginfo
> structures it can play with.

Well, personally I'd not use this limit too, but I don't think
"it's broken, userspace shouldn't use it" argument is valid.

> 
> The maximum for rlimit(RLIM_SIGPENDING) is the rlimit(RLIM_SIGPENDING)
> value when the user namespace is created.
> 
> Given that it took 3 and half years to report this.  I am going to
> say this really looks like a userspace bug.

The trick here is another bug fixed by https://lkml.org/lkml/2024/10/31/185.
Basically it's a leak of the rlimit value.
If a limit is set and reached in the reality, all following signals
will not have a siginfo attached, causing applications which depend on
handling SIGSEGV to crash.

> Beyond that your patch is actually buggy, and should not be applied.
> 
> If we want to change the semantics and ignore the maximum number of
> pending signals in a container (when override_rlimit is set) then
> the code should change the computation of the max value (pegging it at
> LONG_MAX) and not ignore it.

Hm, isn't the unconditional (new < 0) enough to capture the overflow?
Actually I'm not sure I understand how "long new" can be "> LONG_MAX"
anyway.

Thanks!

