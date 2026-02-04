Return-Path: <stable+bounces-214339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFR2DzqRg2lCpQMAu9opvQ
	(envelope-from <stable+bounces-214339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 19:34:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93573EBB14
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 19:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D90309A1C8
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9A4279FE;
	Wed,  4 Feb 2026 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="I0BY7Y2K"
X-Original-To: stable@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93FD426ED6;
	Wed,  4 Feb 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770229837; cv=none; b=FWFZaL3RHlnZk1YmTwvIG67JSn2qpHleYUDy59h7/ghzvWSMeVY63vf8JiLVgoKGJX3eKuZj/hKjHc3IvHFfm75Rf3RmjOXa1HVoQ0sL3F8fC8Lp9Wpp1gJOkRwT9ndH1zEB7g3fGoLCKyR7iP3LWzt1k3lmPgjbW4uQj9u7iwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770229837; c=relaxed/simple;
	bh=OdUb25hwDf7Td6RZQE9eems/6ez37ij9pWo0A8i9afc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NbNBWg45wdoRvJjCVzKEsTJ1FIXgRoN8t77rjpUs8tSY5J2GhLjYh3qjnZa+jmrZ7vjIGmBc/l9NLlv4OceKlgmzdYzo0rTXavgM9E0cfzI9K9Kb4m9O2vhOXaRentD6U05iXTrLpqJXda9n/KXQMsOtV2HH+lgGAobQBeocKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=I0BY7Y2K; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1770229486;
	bh=OdUb25hwDf7Td6RZQE9eems/6ez37ij9pWo0A8i9afc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=I0BY7Y2Ka/1RFhZQ0vnJeovKXCgV64QfqBLB20+WoAG393kfyRXpGop8523cdl0VA
	 dzsVy17LbKM3hf65ipzajQZTot0/H11NeCXwD+vyWP8lZnbpMvbf/NHRoS+yVYF7YQ
	 Z/izDqFw7B8V9Orz+bH1Ur0dya3OhhPoiq7Axm1k=
Received: by gentwo.org (Postfix, from userid 1003)
	id 98963401E2; Wed, 04 Feb 2026 10:24:46 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 95C19400CA;
	Wed, 04 Feb 2026 10:24:46 -0800 (PST)
Date: Wed, 4 Feb 2026 10:24:46 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Hao Li <hao.li@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
    Petr Tesarik <ptesarik@suse.com>, David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Uladzislau Rezki <urezki@gmail.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
    bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
    kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org, 
    "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 00/22] slab: replace cpu (partial) slabs with
 sheaves
In-Reply-To: <665ff739-73d8-4996-95e0-f09c3e5b6552@suse.cz>
Message-ID: <2abde505-1e35-8d74-2806-7a3cd430e306@gentwo.org>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz> <imzzlzuzjmlkhxc7hszxh5ba7jksvqcieg5rzyryijkkdhai5q@l2t4ye5quozb> <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz> <pdmjsvpkl5nsntiwfwguplajq27ak3xpboq3ab77zrbu763pq7@la3hyiqigpir>
 <665ff739-73d8-4996-95e0-f09c3e5b6552@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gentwo.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gentwo.org:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,suse.com,google.com,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	TAGGED_FROM(0.00)[bounces-214339-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gentwo.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cl@gentwo.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gentwo.org:mid,gentwo.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93573EBB14
X-Rspamd-Action: no action

On Wed, 4 Feb 2026, Vlastimil Babka wrote:

> > So I think the performance of the percpu partial list and the sheaves mechanism
> > is roughly the same, which is consistent with our expectations.
>
> Thanks!

There are other considerations that usually do not show up well in
benchmark tests.

The sheaves cannot do the spatial optimizations that cpu partial lists
provide. Fragmentation in slab caches (and therefore the nubmer of
partial slab pages) will increase since

1. The objects are not immediately returned to their slab pages but end up
in some queuing structure.

2. Available objects from a single slab page are not allocated in sequence
to empty partial pages and remove the page from the partial lists.

Objects are put into some queue on free and are processed on a FIFO basis.
Objects allocated may come from lots of different slab pages potentially
increasing TLB pressure.



