Return-Path: <stable+bounces-76211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421997A015
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 13:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA051F22C4C
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E3D1465AB;
	Mon, 16 Sep 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c3zSB9y3"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFC14E2DA;
	Mon, 16 Sep 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485211; cv=none; b=p9tlvXjfTupAYR2flQmMEpsk9z67J2gaO177oUhELH5LTLmIJNz9B65mnyo9bV8DxzufV5aoLuSGVJhRH6gEHqjykPTIWT72PiXNv2tjOfwDElz1q9skW1xfBihZOD5bqX0ezzdyi9lLN6j8Rf6eWcFCZgBmUgjJmi9YkwPim4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485211; c=relaxed/simple;
	bh=EzoZWZaUvRz0LpS1ExKERZU6KL0YSPNyxZqKuLFI8iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXtQj//APbTquo95gPd1KQXW/SBuaPARYXelgXvvVikh+GrrYATdAwPXRwCsS/raxjeJekUb3o9F4geBhC9JSB6SByE0n43nDdg5tpd2ZFo9Uvg6IWtugnA6y5olaDbLIfvkIPud1Ayl09FVTsnQP+lZubOv7N9wSWNoW51zFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c3zSB9y3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sWQo08nNykXt5tP+ATjSDBh3iUttS1j5lm5pZenyIB0=; b=c3zSB9y3INdC32zFauW9lrJttf
	Mpwtwm5Wy9eOb4aUEYrFMSgowQQg8+Tv+eSpvJXUOmYyQWlUH/XGemsGpQHLgVmhedugR/SSeck+k
	9SDSveK05auR36/5YScKmWqKDNaIdQO6KXrmSSqeQ+cHd/B3u8P3EyFS3GcjFllchNTzbEZahr9+m
	2Z7iNkjga4rWXzkgcEv6XITHm6lZXeFOJN/sDTUGc8l4nL/NRkJ/pVK20qNmygZbksMvX9acSNREZ
	eIX1fowTT6aG72F8TwIxPOLZa4o3DqYnEbr/x9BFYyka18nKD5n+HcwWEGLEmJhrIyar3kXSkRhKU
	DzahQ4qg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sq9fY-00000000NaH-0Fdc;
	Mon, 16 Sep 2024 11:13:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2C59A300777; Mon, 16 Sep 2024 13:13:23 +0200 (CEST)
Date: Mon, 16 Sep 2024 13:13:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Pratt <mcpratt@pm.me>
Cc: Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] sched/syscalls: Allow setting niceness using
 sched_param struct
Message-ID: <20240916111323.GX4723@noisy.programming.kicks-ass.net>
References: <20240916050741.24206-1-mcpratt@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916050741.24206-1-mcpratt@pm.me>

On Mon, Sep 16, 2024 at 05:08:49AM +0000, Michael Pratt wrote:
> From userspace, spawning a new process with, for example,
> posix_spawn(), only allows the user to work with
> the scheduling priority value defined by POSIX
> in the sched_param struct.
> 
> However, sched_setparam() and similar syscalls lead to
> __sched_setscheduler() which rejects any new value
> for the priority other than 0 for non-RT schedule classes,
> a behavior kept since Linux 2.6 or earlier.

Right, and the current behaviour is entirely in-line with the POSIX
specs.

I realize this might be a pain, but why should be change this spec
conforming and very long standing behaviour?

Worse, you're proposing a nice ABI that is entirely different from the
normal [-20,19] range.

Why do you feel this is the best way forward? Would not adding
POSIX_SPAWN_SETSCHEDATTR be a more future proof mechanism?

