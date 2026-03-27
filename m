Return-Path: <stable+bounces-230637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOoMLNloxmnTJwUAu9opvQ
	(envelope-from <stable+bounces-230637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:24:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5BC3435FA
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0510B30BA796
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FADA34A76A;
	Fri, 27 Mar 2026 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS0dUb2l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C78386429;
	Fri, 27 Mar 2026 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610490; cv=none; b=pyYCWXOor8mHH3qkCdMxdZRo3DinXVwMKnzawg6E4ULLIWXfyEZNJjQJQ8DS4/lF1fQf8yVHF23QpfuKJRhTYS1W4xuF6FkUqZb0zvrxOLtAXa+hMZd076q1fZ5gP9oomj0U3HkchPJLpDfojf6Xhr2dBhBgjJCsqg5LXgsyOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610490; c=relaxed/simple;
	bh=swcohrFbsQ9OatkiOSOTSr2Oxhk0CH56KvYFD2WN+Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGVeBERbDGV5kQAFif50TQh33Cyj1iPohM08qEQO8/nNf55rLqSjFZG853ZLKHpFt1K2KXChQzc9fy90h/oriKj1cw0NuBwlrQSczOF3asvEy5DxaKtU+TS0cFDgNVUXusxAhKG1cZ8B0KpgrqFVgICHV4JW1PRX2+WViZvs7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS0dUb2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD33C19423;
	Fri, 27 Mar 2026 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774610490;
	bh=swcohrFbsQ9OatkiOSOTSr2Oxhk0CH56KvYFD2WN+Ys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IS0dUb2l6dq/UKuQvOxjZqoanLCXjZM37R1bc4wCScoCJe4XW8j2TvJ+wLupL5zn4
	 /5+ULZLFGH97Bb84dwDA6SaV6wum4iCZYiVl7bAMK5c9/zGxj1Pcpqx6qj4m1ELKw7
	 tTo5wVnT//ihfdMz19PopHmuv+Wtie7OyKTk8UCqowLlxFHq6C7dH/6DgA+NI4XW0s
	 MqGDbpHnUvkRsy9SlPdgGLyxftYSB5tdhn7ou2al0Bu7ezYiGcyMWJ5AtgSEarW4Q+
	 1z2fKkkmgqsYj1iQ0dDmcE/+ChBUdBwUSGZeTlyt4g/w0pBwbutvb8OsV1/oWSEZQk
	 uQ4PspkZSd0hg==
Message-ID: <d120d8d3-f785-47ec-9c6b-b28d42ebb1f7@kernel.org>
Date: Fri, 27 Mar 2026 12:21:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] slab: replace cpu (partial) slabs with sheaves
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
 Aishwarya Rambhadran <aishwarya.rambhadran@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Petr Tesarik <ptesarik@suse.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com,
 kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <afe9ba0a-1924-42a8-a9c5-34eec709f883@arm.com>
 <ed58493b-0369-4729-bcf7-bc89f72a7913@kernel.org> <acV36oPNFMgL4puz@milan>
 <ea1cb2a1-b674-4d69-bbf6-00051a0e11df@kernel.org>
 <eafefe7a-a33b-4102-93cf-fecc33ddf49e@arm.com>
 <0f441d8f-d84c-470a-a4cb-0249b15220a2@kernel.org>
 <f100305b-6c56-4499-98a4-6a22f8c49443@arm.com> <acZVS-ehXCtvcA9s@hyeyoo>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <acZVS-ehXCtvcA9s@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230637-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,arm.com,suse.cz,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,oracle.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D5BC3435FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 11:00, Harry Yoo (Oracle) wrote:
> On Fri, Mar 27, 2026 at 08:58:36AM +0000, Ryan Roberts wrote:
>> >>>>> On 3/26/26 13:43, Aishwarya Rambhadran wrote:
>> >>> Right so there should be just the overhead of the extra is_vmalloc_addr()
>> >>> test. Possibly also the call of kfree_rcu_sheaf() if it's not inlined.
>> >>> I'd say it's something we can just accept? It seems this is a unit test
>> >>> being used as a microbenchmark, so it can be very sensitive even to such
>> >>> details, but it should be negligible in practice.
>> >>
>> >> The perf/syscall cases might be a bit more concerning though? (those tests are
>> >> from "perf bench syscall fork|execve"). Yes they are microbenchmarks, but a 7%
>> >> increased cost for fork seems like something we'd want to avoid if we can.
>> > 
>> > Sure, I tried to explain those in my first reply. Harry then linked to how
>> > that explanation can be verified. Hopefully it's really the same reason.
>> 
>> Ahh sorry I missed your first email. We only added that benchmark from 6.19 so
>> don't have results for earlier kernels, but I'll ask Aishu to run it for 6.17
>> and 6.18 to see if the results correlate with your expectation.
>> 
>> But from a high level perspective, a 7% regression on fork is not ideal even if
>> there was a 7% improvement in 6.18.

In retrospect it was an oversight not to disable the pre-existing cpu
caching layer immediately for sheaf-enabled caches in 6.18. Can't undo that
mistake now, unfortunately.

> If that improvement comes from the number of objects cached per CPU,
> I'm not sure if determining the default value (# of cached objs) based on
> "a point when microbenchmarks stop improving" is a reasonable measure
> because the default value affects all slab caches and will inevitably
> increase overall memory usage.

Yeah that's the thing, some workloads might just keep improving as you throw
more caching at them, but there's a memory usage cost to that.
A case of stress test doing nothing but forks might also not be
representative of performance of forks under normal workload where other
operations also happen, returning the related slab objects, so in the end it
doesn't expose the batch size that much.

> Hopefully we could discuss what a reasonable heuristic that
> "works for most situations" looks like, and allow users to tune it further
> based on their needs.
> 
> As a side note, changing sheaf capacity at runtime is not supported yet
> (I'm working on it) and targeting at least before the next LTS.
> 


