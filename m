Return-Path: <stable+bounces-246680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPL2L6GbA2p27wEAu9opvQ
	(envelope-from <stable+bounces-246680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:29:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C6C52A4AC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20F86302DF9A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B38382F00;
	Tue, 12 May 2026 21:28:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1EE366831;
	Tue, 12 May 2026 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621339; cv=none; b=nCMTK6b3nMmUlZlvMuvTsQhm7rrXqPoHHmgRjpRXy0IEr0bnz8EHHUPR3ih0nsUCP9RD8oqfV7eqxGMPVGvZSyMwSShdEEXDJWbzC3eNmNHib6Fkvz08VI1EI7iwGVdmMHPEqQYmLRNi2DZqVK7tuTSmGQCWVjNFvqmdBk0T0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621339; c=relaxed/simple;
	bh=4C6pvIOAVQbukdwjKbK+qiW+/2zL51bFxyPW5XZJiyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBFsaiKLAnAiSV7impVwrMMvEivu+qObzr3F49a84WqsZb6VcdXRBvyIoS7FYsf/cSdCb6GC7rrtoplbwQMNEQtYskuz5VGMa08z2DVbtshgCO00Ro4up4CwDpfbmDq1s2ub6wPPWHZA0GyrqBO2rYCxnqqeIgH2y2hvCcj8xhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 93792140604;
	Tue, 12 May 2026 21:28:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 14EBC6000B;
	Tue, 12 May 2026 21:28:50 +0000 (UTC)
Date: Tue, 12 May 2026 17:28:47 -0400
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
Message-ID: <20260512172847.5024e5e8@gandalf.local.home>
In-Reply-To: <056f95bc5805f7e161458984fff4b3cb@kernel.org>
References: <20260506235716.2530720-1-tj@kernel.org>
	<20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
	<20260512113754.448c1f5b@gandalf.local.home>
	<056f95bc5805f7e161458984fff4b3cb@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 8qy5uhfwsxeapkmuuepq1oazmbkn8p8b
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//6atTrnTg2GrIa9eEi1vvCQ3Nm8vM5uI=
X-HE-Tag: 1778621330-773637
X-HE-Meta: U2FsdGVkX19tsj67avr6NdZ5Fn/QWcaOKZ5UlYE0wn9jp9KehtkYY9VbvhkeEymnFHFe916J3Qr4L1b3DwQBf1Yc10Ss8h9VknViUKxANUwMlgwaQO2/wdyFjYLud5aAEhSO4gaJNwqr4JARx+AZmGYrk5SejYJhVX3gnwMdLFQVKbDbBFrDFuoXeqOSlwT1pX98HWhFknjwxQi3+EcPlLwA0AQOT/TbzLQx6DFCJ8DC8UPMzD8PHl5xqDPVTc7it7lf11YexmyveFTql6qvfJYRvuNp7T3Vee6vK2IGq/BWAKgfV1UvAnjDvR8Z9Zy/PDyuG0jsLVxWMzcFtCLY5w7T/4Cd87kP
X-Rspamd-Queue-Id: 57C6C52A4AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246680-lists,stable=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 08:07:58 -1000
Tejun Heo <tj@kernel.org> wrote:

> Hello,
>=20
> Looking at 49bef33e4b87 ("sched/rt: Plug rt_mutex_setprio() vs
> push_rt_task() race"), the prio bail looks like it was already there
> and only got moved up to retry:. For non-migration-disabled next_task
> the bail fires at the same effective point both before and after, and
> rto_push_irq_work_func() + rto_next_cpu() were already in their
> current shape, so the loop seems reachable before the move too -
> b6366f048e0c ("sched/rt: Use IPI to trigger RT task push migration
> instead of pulling") looks like the actual origin.
>=20
> Am I reading it wrong?
>=20

No, I missed the movement of that code. Which means I need to understand
the problem better.

I'm still wondering about the trigger of this. That shortcut means the
current process is of lower priority than the waiting tasks and a simple
schedule should happen. From your tests, can you see why a lower process
was running on the CPU instead of a higher priority process?

Also, the IPIs only happen when another CPU is about to schedule something
of lower priority where it tries to pull a task to it.

=46rom your description, you are seeing a storm of IPIs from all these CPUs
before the first CPU could return from hard interrupt and schedule?

I'm thinking there may be something else wrong here.

Note, the RT_PUSH_IPI logic only has a single iteration happening. If it is
happening and another CPU wants to do a "push", it simply ups the counter
to try again. It doesn't send another IPI.

Do you have a trace that shows what is happening?

 # trace-cmd start -e sched_switch -e sched_waking -e irq -e workqueue
 # echo 1 > /proc/sys/kernel/traceoff_on_warning
 # trace-cmd extract

may be enough.

May need to add some trace_printk()s into the IPI logic code too.

-- Steve


