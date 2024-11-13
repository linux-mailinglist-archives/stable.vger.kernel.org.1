Return-Path: <stable+bounces-92930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CD49C74E3
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 15:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C81728851F
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28B12DD8A;
	Wed, 13 Nov 2024 14:57:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280E2AD21;
	Wed, 13 Nov 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509879; cv=none; b=KMKXUw5+D4rmMuQ4uy3kolYtmeJ+lw+We0l/MsnY1Zgrc3r2HhJkhHEtqt4kzX+TwtR4NKNMKBDKE3E6fM/F7msu8d3vFlxf92Kz6gsKY3Y6T8xVsDqDASHovvaHnojhZ9OplJrOp1BnreR7OrbMFDrTlRfFW0HKejVUKEUPACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509879; c=relaxed/simple;
	bh=5JCFyov5MKCRlAdKii3E/dCxGF/WwSiXXi37DywlQL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGe3g6aArfd9QhH/i7Er7UyZJMtaYGm4aWBI0VS15FOe+ZMOHtHRaP5fXw8Q+O3kBKR8TNzBpDB7xvTFF88lPLKrIXXGGGuGUBBnD87eMpy0UBCyCsXPpHoVFpfRuDM/PEOMHijW5bLc9RakReyUpuFiwcpit4+HCE9udUBB7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4340FC4CEC3;
	Wed, 13 Nov 2024 14:57:57 +0000 (UTC)
Date: Wed, 13 Nov 2024 09:58:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Pratt <mcpratt@pm.me>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2 1/1] sched/syscalls: Allow setting niceness
 using sched_param struct
Message-ID: <20241113095816.6ed4cefd@gandalf.local.home>
In-Reply-To: <82xsONg6yQRk_uyZ0-JkTqF2OjxuM4J8IgoNm45Xc6IXAvtX2lPKYxffzZ9GrhIA1TPhpvFoHx9wqWaH3nQyKWRcBggGIsc_61rMDyfMrOE=@pm.me>
References: <20241111070152.9781-1-mcpratt@pm.me>
	<20241111070152.9781-2-mcpratt@pm.me>
	<20241112103438.57ab1727@gandalf.local.home>
	<e3Nl9UdWoWuPJauA6X3vNj71jDUwHZYS5b5WSmKCHrU7AyivFG5oLkrL-ewb3IjoQyUouDgZO2T-3WEzBIJ9Uru1AcEDTaVsRzHrukUfto8=@pm.me>
	<20241112193617.169fefbc@gandalf.local.home>
	<82xsONg6yQRk_uyZ0-JkTqF2OjxuM4J8IgoNm45Xc6IXAvtX2lPKYxffzZ9GrhIA1TPhpvFoHx9wqWaH3nQyKWRcBggGIsc_61rMDyfMrOE=@pm.me>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 06:04:59 +0000
Michael Pratt <mcpratt@pm.me> wrote:

> > $ man sched_setscheduler
> > [..]
> > SCHED_OTHER the standard round-robin time-sharing policy;
> > 
> > SCHED_BATCH for "batch" style execution of processes; and
> > 
> > SCHED_IDLE for running very low priority background jobs.
> > 
> > For each of the above policies, param->sched_priority must be 0.
> > 
> > 
> > Where we already document that the sched_priority "must be 0".  
> 
> I think we should all agree that documentation is a summary of development,
> not the other way around. Not only that, but this is poor documentation.
> The kernel is subject to change, imagine using the word "always"
> for design decisions that are not standardized.
> A more appropriate description would be
> "for each policy, sched_priority must be within the range
> provided by the return of [the query system calls]"
> just as POSIX describes the relationship.
> 
> As far as I can see, the "must be 0" requirement is completely arbitrary,
> or, if there is a reason, it must be a fairly poor one.
> However, I do recognize that the actual static priority cannot change,
> hence the adjustment to niceness instead is the obvious intention
> to any attempt to adjust the priority on the kernel-side from userspace.
> 
> I consider this patch to be a fix for a design decision
> that makes no sense when reading about the intended purpose
> of these values, not that it's the only way to achieve the priority adjustment.
> If anyone considers that something this simple should have been done already,
> the fact that documentation would have to be adjusted should not block it.
> Besides, a well-written program would already have been using
> the functions that return the accepted range before executing
> the sched_setscheduler() system call with a value that would be rejected.
> 
> Am I really the only one to read that you can't set the priority
> with this system call when I can do it on the command line with the "nice" program
> which uses a different system call, and ask "what's the point of this restriction?"

Honestly, I would actually prefer your change. But modifying an existing
API is above my pay grade ;-)   I think you really need Linus to answer that.

Linus?

-- Steve


