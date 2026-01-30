Return-Path: <stable+bounces-212838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFT3OLQ4fGnSLQIAu9opvQ
	(envelope-from <stable+bounces-212838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 05:51:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5654BB7295
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 05:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00FF430166F6
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 04:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A513148A6;
	Fri, 30 Jan 2026 04:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MTZFazTp"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602A2F12D6
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769748639; cv=none; b=ALvsr9UwCnoo+jEfwZl2Sa1dNlffJuHSPMxsQLz80vLzlU1tgPjRAUss7ScnterSOv3O1jfoSppbSVb7eKftVkgD6MD84o0LWh8DwThkEiCXnPtjfME8awpbeJngKyFXQHl5angbsHIK+7bM/ozErzkzYud+H+CvDUPxYfe2u3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769748639; c=relaxed/simple;
	bh=7K/XRomBO5tGOJNCNL9IdnL/8/ejIP4nyJZzLwfzat4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8c9w9V93cbG6fsTWiVYh8DiTdO7uH4urWok23uif/asdyyKISgJtcESXsqeV0IR1d+x+udnbuJW13oZAui0MsJWgf4gJA9p6g5A+itS3m5iWytbI0uO8Q1Irr7aN7KfI6SQKJmczi4Lx643+x8ZeLKLlGOElYkDH2cdJAh9GDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MTZFazTp; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 30 Jan 2026 12:50:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769748624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0LolDkIeVgydx+lUvvnJuU5rTPe49ECMjoBW0cqVvs=;
	b=MTZFazTpwQLBt1p5zzHs+rma+lbyv5QWgJkSiS9D4crkD4svGk6zMNRkBBOlfbtGIM7EBl
	x3t9H03Th8ZE0Qej3gyM1d7zBQMDVKS4xaOXnWVv32LGA+bR+zq9bmeU3zks099YfXMfZN
	kTbWJy/VQ4TwieXIANt3LxLHCreyKqM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 00/22] slab: replace cpu (partial) slabs with sheaves
Message-ID: <pdmjsvpkl5nsntiwfwguplajq27ak3xpboq3ab77zrbu763pq7@la3hyiqigpir>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <imzzlzuzjmlkhxc7hszxh5ba7jksvqcieg5rzyryijkkdhai5q@l2t4ye5quozb>
 <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212838-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim]
X-Rspamd-Queue-Id: 5654BB7295
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:28:01PM +0100, Vlastimil Babka wrote:
> 
> So previously those would become kind of double
> cached by both sheaves and cpu (partial) slabs (and thus hopefully benefited
> more than they should) since sheaves introduction in 6.18, and now they are
> not double cached anymore?
> 

I've conducted new tests, and here are the details of three scenarios:

  1. Checked out commit 9d4e6ab865c4, which represents the state before the
     introduction of the sheaves mechanism.
  2. Tested with 6.19-rc5, which includes sheaves but does not yet apply the
     "sheaves for all" patchset.
  3. Applied the "sheaves for all" patchset and also included the "avoid
     list_lock contention" patch.


Results:

For scenario 2 (with sheaves but without "sheaves for all"), there is a
noticeable performance improvement compared to scenario 1:

will-it-scale.128.processes +34.3%
will-it-scale.192.processes +35.4%
will-it-scale.64.processes +31.5%
will-it-scale.per_process_ops +33.7%

For scenario 3 (after applying "sheaves for all"), performance slightly
regressed compared to scenario 1:

will-it-scale.128.processes -1.3%
will-it-scale.192.processes -4.2%
will-it-scale.64.processes -1.2%
will-it-scale.per_process_ops -2.1%

Analysis:

So when the sheaf size for maple nodes is set to 32 by default, the performance
of fully adopting the sheaves mechanism roughly matches the performance of the
previous approach that relied solely on the percpu slab partial list.

The performance regression observed with the "sheaves for all" patchset can
actually be explained as follows: moving from scenario 1 to scenario 2
introduces an additional cache layer, which boosts performance temporarily.
When moving from scenario 2 to scenario 3, this additional cache layer is
removed, then performance reverted to its original level.

So I think the performance of the percpu partial list and the sheaves mechanism
is roughly the same, which is consistent with our expectations.

-- 
Thanks,
Hao

