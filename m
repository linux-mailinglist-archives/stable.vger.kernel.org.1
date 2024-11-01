Return-Path: <stable+bounces-89536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18A9B9A22
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 22:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DF1281AFF
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE421E2612;
	Fri,  1 Nov 2024 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xC7btHVd"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D41547DC
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496135; cv=none; b=bM2f7Ny7ZVaaJl2y5S3zAXe6qfovSDxyPJ29Szf3J27zaG74HxQu6272ckVaQcH0WxNuPKNXQ+gZod60iyrPaq0ojLdWfNqlWTSdFmVLloWWrdyc/m3gkFMRUdbqSJfJg/bmSZql61iCHGVCFlzTMBB6giSJskKHuNlWEMBtT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496135; c=relaxed/simple;
	bh=1hlRSnBMxIgGnFT5nopO8avrxoyd9weX8/cYTA1zyms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0K3XaQkmERUVFF7re6KWhTuLg+nNpovwcfF0s1AfKeC4ge1QwVG258gp8ghJ0+Olaw9NLEmMjBS/J22CfX9cked6fXU/uY+0kG3C3nR0n28eXCfgI2yUviOh0HIP2+A7THqO2Kv6QeuVW5xaQ9g5R7tmSzMVgBYuWXwBZY0u0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xC7btHVd; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Nov 2024 21:21:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730496129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJAt7BYdr1o1tGrdUqJzXzkGawN+UGekAKhugSDQTJU=;
	b=xC7btHVdJ0oKc5X22DZvKst3vviBxs2uD97QbLxBHJDplTzJg9mAO2Mj8VFGgMxXzsID/W
	wEmeD4iE79GKNpjfciYe0KwOvzrQjcn6viIw3nMcb2sZ0L7hIYaHqOrKk6wUmVDCTO4yoJ
	r4Xd/85kAYOjA3ZBh2Q2wIzNMmUkZMg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
	Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <ZyVGYggBMa4KIG70@google.com>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
 <ZyU8UNKLNfAi-U8F@google.com>
 <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 01, 2024 at 03:58:07PM -0500, Eric W. Biederman wrote:
> Roman Gushchin <roman.gushchin@linux.dev> writes:
> 
> > On Fri, Nov 01, 2024 at 02:51:00PM -0500, Eric W. Biederman wrote:
> >> Roman Gushchin <roman.gushchin@linux.dev> writes:
> >> 
> >> > Prior to commit d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of
> >> > ucounts") UCOUNT_RLIMIT_SIGPENDING rlimit was not enforced for a class
> >> > of signals. However now it's enforced unconditionally, even if
> >> > override_rlimit is set.
> >> 
> >> Not true.
> >> 
> >> It added a limit on the number of siginfo structures that
> >> a container may allocate.  Have you tried not limiting your
> >> container?
> >> 
> >> >This behavior change caused production issues.
> >> 
> >> > For example, if the limit is reached and a process receives a SIGSEGV
> >> > signal, sigqueue_alloc fails to allocate the necessary resources for the
> >> > signal delivery, preventing the signal from being delivered with
> >> > siginfo. This prevents the process from correctly identifying the fault
> >> > address and handling the error. From the user-space perspective,
> >> > applications are unaware that the limit has been reached and that the
> >> > siginfo is effectively 'corrupted'. This can lead to unpredictable
> >> > behavior and crashes, as we observed with java applications.
> >> 
> >> Note.  There are always conditions when the allocation may fail.
> >> The structure is allocated with __GFP_ATOMIC so it is much more likely
> >> to fail than a typical kernel memory allocation.
> >> 
> >> But I agree it does look like there is a quality of implementation issue
> >> here.
> >> 
> >> > Fix this by passing override_rlimit into inc_rlimit_get_ucounts() and
> >> > skip the comparison to max there if override_rlimit is set. This
> >> > effectively restores the old behavior.
> >> 
> >> Instead please just give the container and unlimited number of siginfo
> >> structures it can play with.
> >
> > Well, personally I'd not use this limit too, but I don't think
> > "it's broken, userspace shouldn't use it" argument is valid.
> 
> I said if you don't want the limit don't use it.
> 
> A version of "Doctor it hurts when I do this". To which the doctor
> replies "Don't do that then".
> 
> I was also asking that you test with the limit disabled (at user
> namespace creation time) so that you can verify that is problem.
> 
> >> The maximum for rlimit(RLIM_SIGPENDING) is the rlimit(RLIM_SIGPENDING)
> >> value when the user namespace is created.
> >> 
> >> Given that it took 3 and half years to report this.  I am going to
> >> say this really looks like a userspace bug.
> >
> > The trick here is another bug fixed by https://lkml.org/lkml/2024/10/31/185.
> > Basically it's a leak of the rlimit value.
> > If a limit is set and reached in the reality, all following signals
> > will not have a siginfo attached, causing applications which depend on
> > handling SIGSEGV to crash.
> 
> I will take a deeper look at the patch you are referring to.
> 
> >> Beyond that your patch is actually buggy, and should not be applied.
> >> 
> >> If we want to change the semantics and ignore the maximum number of
> >> pending signals in a container (when override_rlimit is set) then
> >> the code should change the computation of the max value (pegging it at
> >> LONG_MAX) and not ignore it.
> >
> > Hm, isn't the unconditional (new < 0) enough to capture the overflow?
> > Actually I'm not sure I understand how "long new" can be "> LONG_MAX"
> > anyway.
> 
> Agreed "new < 0" should catch that, but still splitting the logic
> between the calculation of max and the test of max is quite confusing.
> It makes much more sense to put the logic into the calculate of max.

You mean something like this?

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 046b3d57ebb4..49fcec41e5b4 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -317,11 +317,12 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,

        for (iter = ucounts; iter; iter = iter->ns->ucounts) {
                long new = atomic_long_add_return(1, &iter->rlimit[type]);
-               if (new < 0 || (!override_rlimit && (new > max)))
+               if (new < 0 || new > max)
                        goto unwind;
                if (iter == ucounts)
                        ret = new;
-               max = get_userns_rlimit_max(iter->ns, type);
+               if (!override_rlimit)
+                       max = get_userns_rlimit_max(iter->ns, type);
                /*
                 * Grab an extra ucount reference for the caller when
                 * the rlimit count was previously 0.

--

If you strongly prefer this version, I can send a v2. I like my original
version slightly better, but not a strong preference. Please, let me know.

Thanks!

