Return-Path: <stable+bounces-247210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP2OCTnWBWrxbwIAu9opvQ
	(envelope-from <stable+bounces-247210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:03:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A5542B8A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A8A3018D56
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF63C4165;
	Thu, 14 May 2026 14:03:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D863FADF9;
	Thu, 14 May 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767391; cv=none; b=kOhMgAqKjlTBuJAOzQubH65oNfFGH9GAoZRpARlug76eoMZR2jLzAC54P1/zSr+Ag5MGdHqIRmAytRaPM5bQvaYEm6sjWFC4s9Elgqlj9fYZYuCEJ+rGs7OF1v74I9IH5OJwxa2a0MW2DAaEp/qKb3TNTe4gnHeIBVdWS4nKOE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767391; c=relaxed/simple;
	bh=4dgtp24w/ifz2MXIqkWveTTH9LDcFXwnbr3XcBvb5rg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCPxpVGGbtVjkh/ZtqgHZ+R/iqRAItItus5J3jrBXgAiFwG4i27bs7Jc97F/iwQd76Oeg6Cv/0KCVAzXuHtMuEXIgouFa3gsU7O+ZbyxRTxZ40GQ7lYLYwfEwbVesJiKk/SOE9PaO1miWwdUpOTErYJt5JI09Pm7wvrfwYCaWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 80B091205A9;
	Thu, 14 May 2026 14:02:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id E95A020029;
	Thu, 14 May 2026 14:02:54 +0000 (UTC)
Date: Thu, 14 May 2026 10:03:00 -0400
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
Message-ID: <20260514100300.1d594c7a@gandalf.local.home>
In-Reply-To: <agVUH-L503DwAiSW@slm.duckdns.org>
References: <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
	<20260512113754.448c1f5b@gandalf.local.home>
	<056f95bc5805f7e161458984fff4b3cb@kernel.org>
	<20260512172847.5024e5e8@gandalf.local.home>
	<20260513193914.1593369-1-tj@kernel.org>
	<20260513202432.18dd7b9f@gandalf.local.home>
	<agUdAatmlqQc1NS_@slm.duckdns.org>
	<20260513213108.2870a1e7@fedora>
	<agUodtxEi24HQ1Oo@slm.duckdns.org>
	<20260513220136.5a11c740@fedora>
	<agVUH-L503DwAiSW@slm.duckdns.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: io689kdtgyxajypz1t8rpm7dwhj1miwt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19KhBgS9pq3fT6x8+ows0b15Ra5CBzTS6A=
X-HE-Tag: 1778767374-902110
X-HE-Meta: U2FsdGVkX1+SNEWFUrQykZVtVR1VNUSkQq40av+MMAAwUmRo9b8vfla5B8mXzpEyny9k5rRIhoD3lQ8C+3v3fxCm2WH2fUNxuDwpXiFSSOA867xbS05yUxwn/TC1IRf3OAhFkI36QOF7YO4qh/nsK7SAGmEy7gtKGBOuzvXuBXQRnb4erETK1QQANWUYB5ALoCKAnz72L0nEYLiLXwx99lEdVpJHVLMtDXMVKIqhiC9LTZpn1vwBUVd04hlrxgV2NxgStpLODicPTe70dTCE8BIZTqOQZhUtgbhWU78Ot3wCOfC644uvLKKI/gmcWGnC95z9Fx+6mrIALG5fUlLtpydRUU1CEo2w
X-Rspamd-Queue-Id: 6C0A5542B8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247210-lists,stable=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gandalf.local.home:mid]
X-Rspamd-Action: no action

On Wed, 13 May 2026 18:48:31 -1000
Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On Wed, May 13, 2026 at 10:01:36PM -0400, Steven Rostedt wrote:
> > I could try, but there are still some things that I don't understand.
> > One is that to send more IPIs due to the RT pull request, there needs
> > to be RT tasks constantly sleeping. Is that happening in this use case?
> > Are the softirqs waking up RT tasks that run for a short time and go
> > back to sleep, causing the pull IPI to trigger again?  
> 
> Ah, yes, that makes sense. That's why the repro is using FIFO threads too.
> In prod, there's mpi3mr threaded irq handlers that are FIFO. These are
> storage machines so they're also constantly active.

I was thinking about this more and does disabling the RT_PUSH_IPI cause any
problems for you?

  # echo NO_RT_PUSH_IPI > /sys/kernel/debug/sched/features

The reason I ask is that I'm not sure he RT_PUSH_IPI even makes sense to
have enabled when CONFIG_IRQ_FORCED_THREADING is not enabled. The reason
the RT_PUSH_IPI was created in the first place was due to a kind of
"thundering herd" of taking the rq lock of the CPU that has an overloaded
set of RT tasks on it.

When RT_PUSH_IPI is disabled, instead of sending an IPI to the CPU to do a
push, the CPU that is scheduling a lower priority task takes the overloaded
CPU's rq lock and will try to pull tasks from it.

The issue that RT_PUSH_IPI solved was that if you had a 100 CPUs all
scheduling a lower priority task at the same time, they would all try to
take the lock of the overloaded CPU. Only the first one would succeed in
pulling a task. The other 99 would finally get that lock and see that it
has no tasks to pull from. I found that this could cause 500us of latency
or more.

That 500us mattered a lot for PREEMPT_RT, but doesn't really matter if you
have softirqs running uninterruptable and for 500us themselves. I'm
thinking that we could just have the following instead:

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f63b15d309d..0a4f4a212cd6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -829,8 +829,14 @@ static inline int rt_bandwidth_enabled(void)
 	return sysctl_sched_rt_runtime >= 0;
 }
 
-/* RT IPI pull logic requires IRQ_WORK */
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP)
+/*
+ * RT IPI pull logic requires IRQ_WORK and doesn't make sense for uniprocessors.
+ * If CONFIG_IRQ_FORCED_THREADING isn't set, then softirqs do not run as threads
+ * and can cause latency larger than what RT_PUSH_IPI can save, killing the
+ * effect of it.
+ */
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP) &&	\
+	defined(CONFIG_IRQ_FORCED_THREADING)
 # define HAVE_RT_PUSH_IPI
 #endif
 
-- Steve

