Return-Path: <stable+bounces-224807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJS8ATlgsmlmMAAAu9opvQ
	(envelope-from <stable+bounces-224807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:42:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB1826E020
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78ABF302630D
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 06:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331F381AFB;
	Thu, 12 Mar 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FS1f+GoP"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F02C0F95;
	Thu, 12 Mar 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297717; cv=none; b=ONZ5Jp1GnsqgPg57fy05TMcLL8Ff9RnTPvMjX9WpqDAmVCqQjWhEXuexCDyKDns/eBohsXBAD5i0RLdItInh1nUS8TNkb8VN/yjDMhmluEGl9BU8DclJHYAKQLNScLLqK19NEt6lr9LuL6z5P+1B/rDW1Q2ppVK29n+aZ612kAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297717; c=relaxed/simple;
	bh=ieXwVMsa1JULHNMCna/UPTqelKNLC+WH8Gi5DHjK8/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4dJgRClDnwbMyeJhy8F+B43Ax1bh9QMgfQ3QguP1OKyyPpucNplmvMfUhOVxTO4RuQZ9JDTrWQwCbawhv0Rkyu6y+KnkDoyyxw0CpwfapFZE578sqSKL8VbY+jI4YQUjZibPAW+VifLm7LOxOlCO2QXhDaFSSFJTgZI348lYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FS1f+GoP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mG0deg7lI5kvB+jSR8Z38LAurxmuNdJ2FFz5T8i0pPQ=; b=FS1f+GoPLxTL0BhGS5w+c2TDsz
	IlQ3oIo9kv6NXZabmpYciVXQuQu+P09DyeMYdflHkvkUswskI94hhkMnsn2QWfXHeUUBPI7hzvEH8
	ypYO1gW19Dt4XGX9ULrbMaHgDMjYV9kk+iBp6VW6ivE9LjGd69g/B0ySXO7/Ax0dKKX+55iXUwgQS
	QBP4nuOI36oI7hojcvjtoIdoZh0XP1XTThBJeoIlb3BG+WULD3Pag4xkhsVF40T8RSv92N5lwtUCT
	N7KZ1+dwbXbES3ovwLIR72+i7i92q4d24/4GzUGv5tzKHxr4N1LThfwstBlIiEY/agdrUoVqjA53O
	B1HRdQ0w==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Zjv-00000000buK-0hg6;
	Thu, 12 Mar 2026 06:41:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D18B5301150; Thu, 12 Mar 2026 07:41:45 +0100 (CET)
Date: Thu, 12 Mar 2026 07:41:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
Subject: Re: [RESEND Patch 2/2] perf/x86/intel: Add missing branch counters
 constraint apply
Message-ID: <20260312064145.GA606826@noisy.programming.kicks-ass.net>
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
 <20260228053320.140406-2-dapeng1.mi@linux.intel.com>
 <20260311201625.GW606826@noisy.programming.kicks-ass.net>
 <0a720411-0b24-42eb-9897-856b1175aa82@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a720411-0b24-42eb-9897-856b1175aa82@linux.intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224807-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DB1826E020
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 10:31:28AM +0800, Mi, Dapeng wrote:
> 
> On 3/12/2026 4:16 AM, Peter Zijlstra wrote:
> > On Sat, Feb 28, 2026 at 01:33:20PM +0800, Dapeng Mi wrote:
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> >> index 4768236c054b..4b042d71104f 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -4628,6 +4628,19 @@ static inline void intel_pmu_set_acr_caused_constr(struct perf_event *event,
> >>  		event->hw.dyn_constraint &= hybrid(event->pmu, acr_cause_mask64);
> >>  }
> >>  
> >> +static inline int intel_set_branch_counter_constr(struct perf_event *event,
> >> +						  int *num)
> >> +{
> >> +	if (branch_sample_call_stack(event))
> >> +		return -EINVAL;
> >> +	if (branch_sample_counters(event)) {
> >> +		(*num)++;
> >> +		event->hw.dyn_constraint &= x86_pmu.lbr_counters;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int intel_pmu_hw_config(struct perf_event *event)
> >>  {
> >>  	int ret = x86_pmu_hw_config(event);
> >> @@ -4698,21 +4711,18 @@ static int intel_pmu_hw_config(struct perf_event *event)
> >>  		 * group, which requires the extra space to store the counters.
> >>  		 */
> >>  		leader = event->group_leader;
> >> +		if (intel_set_branch_counter_constr(leader, &num))
> >>  			return -EINVAL;
> >>  		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
> >>  
> >>  		for_each_sibling_event(sibling, leader) {
> >> +			if (intel_set_branch_counter_constr(sibling, &num))
> >> +				return -EINVAL;
> >> +		}
> >> +
> > Do the new bit is this, right?
> 
> Actually not, the key change is the below one. The last event in the group
> is not applied the branch counter constraint.
> 
> Assume we have a event group {cycles,instructions,branches}. When the 3rd
> event "branches" is created and the function intel_pmu_hw_config() is
> called for the "branches" event to check the config.  The event leader is
> "cycles" and the sibling event has only the "instructions" event at that
> time since the 3rd event "branches" is in creation and still not added into
> the sibling_list. So for_each_sibling_event() can't really iterate the
> "branches" event.
> 
> 
> >
> >> +		if (event != leader) {
> >> +			if (intel_set_branch_counter_constr(event, &num))
> >>  				return -EINVAL;
> >>  		}
> > The point being that for_each_sibling_event() will not have iterated the
> > event because its not on the list yet?
> 
> Yes. 
> 
> 
> >
> > That wasn't really clear from the changelog and I think that deserves a
> > comment as well.
> 
> Sure. I would add comment and enhance the changelog to make it clearer. Thanks.
> 

I already fixed everything up. Should be in queue/perf/urgent.

