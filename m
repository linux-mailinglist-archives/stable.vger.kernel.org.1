Return-Path: <stable+bounces-247088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZwAgGhAtBWrITAIAu9opvQ
	(envelope-from <stable+bounces-247088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:01:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B47DE53CE96
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490A230191B2
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861B24BBEB;
	Thu, 14 May 2026 02:01:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBE3F413A;
	Thu, 14 May 2026 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724107; cv=none; b=M0IMy92f5jpVz+Aj4Om+OWo9EcoUprVQwxnFKRz35oruBvb51AEBPZyQvgqTVYUEz1Tdvpq/BZb0FEubd7+7Bq+F1auqiWPB71GGNvESqhrRg7TI57lXEMGqjbhfYIxf8DuohxpC1wZ9LWXzd8WkHuHrzvF/S6U6/i24riX6znU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724107; c=relaxed/simple;
	bh=SIeEtKTPOEcxKqoCtgQEaDeW5WSVCcgkrWssl+pKz9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XeIFUcJhgVS3CU/CZi+wmaxG/nCCehnVU+yQzjXzNdkC5hyz3Fjb22Zu7OgzomS2cLp0kKP3ju/C97c7TSbfg+76dwlyCHCnE3kgirVkSMW/RpeJER51l7aAM9w/TAfdzpxMHnLFNXNarJlN7tsHJjVCImCp4CjrndChX+RXzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 96B451201AD;
	Thu, 14 May 2026 02:01:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 854FC1A;
	Thu, 14 May 2026 02:01:38 +0000 (UTC)
Date: Wed, 13 May 2026 22:01:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Kyle McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Linux RT Development
 <linux-rt-devel@lists.linux.dev>, Clark Williams <williams@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <20260513220136.5a11c740@fedora>
In-Reply-To: <agUodtxEi24HQ1Oo@slm.duckdns.org>
References: <20260506235716.2530720-1-tj@kernel.org>
	<20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
	<20260512113754.448c1f5b@gandalf.local.home>
	<056f95bc5805f7e161458984fff4b3cb@kernel.org>
	<20260512172847.5024e5e8@gandalf.local.home>
	<20260513193914.1593369-1-tj@kernel.org>
	<20260513202432.18dd7b9f@gandalf.local.home>
	<agUdAatmlqQc1NS_@slm.duckdns.org>
	<20260513213108.2870a1e7@fedora>
	<agUodtxEi24HQ1Oo@slm.duckdns.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mbk3mi1taj6dwnjzrw4f7spdhg591pyz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18nBXHjvtBjf+K6llzuugcMTtLDij9gGXE=
X-HE-Tag: 1778724098-787495
X-HE-Meta: U2FsdGVkX1/CYoPqUihcJaV3qC7V2023hPKl7ENWqUTy2vztmCrlPzvLX60k52e8JwxCYxJxj6d4bCtPRdjN5xpZd3xa28c4imhHQSS42/5JPQhMH8u1qqvcbjZhCeG+u9Q29J/+zhYLNbknqpw0ynYkDg1NG5rH79FTIil0KY26T8s8znsfg67AnyvBgn1alC/LqrKIQ4w+zTDWlwKzC1DIpESEYMP1U7rXl56bB7KosznNos4QcLIZxzahX1ymN0LgfleqYQGEiwvksxLgkf0ScnAw60MSVxOggd00fvn8jKUuqrOdxQIXbZBac3NRV8db3G2keKzkLEQtYxJ0+WoljYWweZhs
X-Rspamd-Queue-Id: B47DE53CE96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247088-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 15:42:14 -1000
Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On Wed, May 13, 2026 at 09:31:08PM -0400, Steven Rostedt wrote:
> > OK, this is what I was missing. The fact that the CPU was running a
> > softirq at the time that was running for a very long time that prevents
> > the schedule from happening.  
> 
> Right, although, in prod case, I don't think each softirq invocation is that
> long. It's maybe a few msecs, if that. However, there's a constant stream of
> them and if you slow down the CPU enough with IPIs, the CPU can't ever clear
> pending softirq although it only runs a short time each time it enters
> softirq.
> 
> > So if the current task running is SCHED_OTHER we still need to handle
> > the case where the next task is pinned, as it will cause a warning
> > again if it tries to move the fair task, especially since that doesn't
> > fix the overloading.
> > 
> > I think this requires a bit more complex fix. Perhaps if the current
> > task is fair and the next task is pinned, it needs to look for the task
> > after that one to move.  
> 
> I see. You know the code and history a lot better than I do. Wanna take
> over?

I could try, but there are still some things that I don't understand.
One is that to send more IPIs due to the RT pull request, there needs
to be RT tasks constantly sleeping. Is that happening in this use case?
Are the softirqs waking up RT tasks that run for a short time and go
back to sleep, causing the pull IPI to trigger again?

-- Steve


