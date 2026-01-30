Return-Path: <stable+bounces-212915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH4eLK0efWlQQQIAu9opvQ
	(envelope-from <stable+bounces-212915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 22:12:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 145ACBEBDA
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 22:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 905783002F9C
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1FE34FF61;
	Fri, 30 Jan 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PxHhylMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660F43074AB
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769807316; cv=none; b=u7VILk+WSHjLqIZ6dTLoywAuHOzr2XefSQvR48OsASfJnCQHXObZSbnRHl2RCsswgpdA0uw3t0PFAppoWX9lJAXyqZG5poS4aOnFZwSGW6+iwSR8v3PQCBvPWvdw65PKGlSIqom/n3t+TAT4Ljakqpa57zIDVm3d+K8/5CkjtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769807316; c=relaxed/simple;
	bh=NpIWKTcK0nElwmNCWQsMcXiocFq60OtqNvc0TmYMhpw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ghdt7RhdbghkfaJe2V6tf+LPidgspO70I4FiNraiBPu/pL1+Fqim75T4Oa9o4vVZ/DVCmB1CFeQM98gMgZKWKKSWPhOHNRm0Y+5+fBIrutOP21g1+TThrxOM4jxnCfEXDtqnqNi6Ygo7foelvv2xRXLXm5iuuqFtMeKGGoYF3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PxHhylMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94782C4CEF7;
	Fri, 30 Jan 2026 21:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769807315;
	bh=NpIWKTcK0nElwmNCWQsMcXiocFq60OtqNvc0TmYMhpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PxHhylMnpGHxaYWvYQVZLPqe6RRG2x2B+ggYwZIU30b3Ew6cQLMcdWnHk4NxUd35q
	 /DWbjjtUbgZoNxYCAIONothAH76NlkNHxJERU6WcPdb0qnRJIzB3EW/0MwUiv5SpA0
	 6Sy9LCXY/OF0lVDCO1Q6CM7gE1uBdrVtvcIGVElA=
Date: Fri, 30 Jan 2026 13:08:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 <intel-xe@lists.freedesktop.org>, Ralph Campbell <rcampbell@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 <linux-mm@kvack.org>, <stable@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] mm/hmm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-Id: <20260130130835.10d004cd79d67c55b10def74@linux-foundation.org>
In-Reply-To: <aX0cJGIU9NLt/OLW@lstrano-desk.jf.intel.com>
References: <20260130144529.79909-1-thomas.hellstrom@linux.intel.com>
	<20260130100013.fb1ce1cd5bd7a440087c7b37@linux-foundation.org>
	<b9dd97e7d9e62ebc33c4dfef53a9fd3f51352d3a.camel@linux.intel.com>
	<20260130123810.61dde600422a8fe01cff8296@linux-foundation.org>
	<aX0cJGIU9NLt/OLW@lstrano-desk.jf.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212915-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 145ACBEBDA
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 13:01:24 -0800 Matthew Brost <matthew.brost@intel.com> wrote:

> > > Unfortunately hmm_range_fault() is typically called from a gpu
> > > pagefault handler and it's crucial to get the gpu up and running again
> > > as fast as possible.
> > 
> > Would a millisecond matter?  Regular old preemption will often cause
> > longer delays.
> > 
> 
> I think millisecond is too high. We are aiming to GPU page faults
> serviced in 10-15us of CPU time (GPU copy time varies based on size of
> fault / copy bus speed but still at most 200us).

But it's a rare case?

Am I incorrect in believing that getting preempted will cause latencies
much larger than this?

> Matt
> 
> > > Is there a way we could test for the cases where cond_resched() doesn't
> > > work and in that case instead call sched_yield(), at least on -EBUSY
> > > errors?
> > 
> > kernel-internal sched_yield() was taken away years ago and I don't
> > think there's a replacement, particularly one which will cause a
> > realtime-policy task to yield to a non-rt-policy one.
> > 
> > It's common for kernel code to forget that it could have realtime
> > policy - we probably have potential lockups in various places.
> > 
> > I suggest you rerun your testcase with this patch using `chrt -r', see
> > if my speculation is correct.

Please?

