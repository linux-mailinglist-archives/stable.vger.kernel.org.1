Return-Path: <stable+bounces-230475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLMbKNlJxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:59:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5C0337304
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76A73303655C
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681FE388383;
	Thu, 26 Mar 2026 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJGW7ISV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AC212550;
	Thu, 26 Mar 2026 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536130; cv=none; b=iFU0oceovkKqKU7dVqIoW3JpJrb9TW5jqGG8q5qe9j+qQbM/uY5n9XoV1abKIgNodhWIOda/r2PUukgWKeA1bLWHJrh13dxknRtWIbGUBNjQ1jfnHgXhtQPA/SOoKRXVW0LPgvnECPKVdcPAa0FRiDCGdlTrZTF//nsdbUuvL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536130; c=relaxed/simple;
	bh=7TlnbERDNjc6uhJyi+oMJD2jmKqEDwbDwVIc+hkUZEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVy8faZRYNoq9BwGHtC8hE89IhM8Yfl/58KzOiEBEA6o78iApG2p3BR8oGQavK+bdK031uW4sa6AlMWLcwjhgLVO1K1lWL3y85NgkmXsmc/AVSXjrrpeuuLPYKw1b8RkkR3FtP0hUCyPOM0D1GCF6Q1068k/t3na3WJC4Aot740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJGW7ISV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649AFC116C6;
	Thu, 26 Mar 2026 14:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774536129;
	bh=7TlnbERDNjc6uhJyi+oMJD2jmKqEDwbDwVIc+hkUZEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oJGW7ISVLU2YiYHfmF5uSo+2vBsV7P+HyOWUTkVjZKUT8dhqGFtnzWEi1id2M6bFl
	 zK2k2qodpuiHzPdLVNhbAiq+eG4LedGvj7suugTlzkwLpNVM/aRx0DtHBy1Puv4mm9
	 0PxiWYbPDTa4UokhoT/9S0hIDIDFNuZ3u/6XGd2ESe1YfWRmfaJnflgbQSCMy64REw
	 VOIDaZ67yv0TFyxmgLT7qvHEudIoKJLA5ZmtsQlItctgitEOhgrPZmXjdFZn2hksMt
	 xnA6j1oErvGfId4Rp7xhgzQ1rOBxU+44fHaS8yWqpLw0uQUMCHFyZz1rQUveRi3uBg
	 1TNLNwaxYFUiQ==
Message-ID: <ed58493b-0369-4729-bcf7-bc89f72a7913@kernel.org>
Date: Thu, 26 Mar 2026 15:42:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] slab: replace cpu (partial) slabs with sheaves
Content-Language: en-US
To: Aishwarya Rambhadran <aishwarya.rambhadran@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com,
 kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, ryan.roberts@arm.com
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <afe9ba0a-1924-42a8-a9c5-34eec709f883@arm.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <afe9ba0a-1924-42a8-a9c5-34eec709f883@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230475-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com,arm.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9E5C0337304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 13:43, Aishwarya Rambhadran wrote:
> Hi Vlastimil, Harry,

Hi!

> We have observed few kernel performance benchmark regressions,
> mainly in perf & vmalloc workloads, when comparing v6.19 mainline
> kernel results against later releases in the v7.0 cycle.
> Independent bisections on different machines consistently point
> to commits within the slab percpu sheaves series. However, towards
> the end of the bisection, the signal becomes less clear, so it's
> not yet certain which specific commit within the series is the
> root cause.
> 
> The workloads were triggered on AWS Graviton3 (arm64) & AWS Intel
> Sapphire Rapids (x86_64) systems in which the regressions are
> reproducible across different kernel release candidates.
> (R)/(I) mean statistically significant regression/improvement,
> where "statistically significant" means the 95% confidence
> intervals do not overlap”.
> 
> Below given are the performance benchmark results generated by
> Fastpath Tool, for different kernel -rc versions relative to the
> base version v6.19, executed on the mentioned SUTs. The perf/
> syscall benchmarks (execve/fork) regress consistently by ~6–11% on
> both arm64 and x86_64 across v7.0-rc1 to rc5, while vmalloc
> workloads show smaller but stable regressions (~2–10%), particularly
> in kvfree_rcu paths.
> 
> Regressions on AWS Intel Sapphire Rapids (x86_64) :

The table formatting is broken for me, can you resend it please? Maybe a
.txt attachment would work better.

> +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> | Benchmark       | Result Class            |   6-19-0 (base) |  
>   7-0-0-rc1 |   7-0-0-rc2 |  7-0-0-rc2-gaf4e9ef3d784 |   7-0-0-rc3 |  
>   7-0-0-rc4 |   7-0-0-rc5 |
> +=================+==========================================================+=================+=============+=============+===========================+=============+=============+=============+
> | micromm/vmalloc | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 
> (usec) |       262605.17 |      -4.94% |      -7.48% |             (R) 
> -8.11% |      -4.51% |      -6.23% |      -3.47% |
> |                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 
> (usec) |       253198.67 |      -7.56% | (R) -10.57% |            (R) 
> -10.13% |  (R) -7.07% |      -6.37% |      -6.55% |
> |                 | pcpu_alloc_test: p:1, h:0, l:500000 (usec)           
>   |       197904.67 |      -2.07% |      -3.38% |             -2.07% |  
>      -2.97% |  (R) -4.30% |      -3.39% |
> |                 | random_size_align_alloc_test: p:1, h:0, l:500000 
> (usec)  |      1707089.83 |      -2.63% |  (R) -3.69% |               
> (R) -3.25% |  (R) -2.87% |      -2.22% |  (R) -3.63% |
> +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> | perf/syscall    | execve (ops/sec)            |         1202.92 |  (R) 
> -7.15% |  (R) -7.05% |         (R) -7.03% |  (R) -7.93% |  (R) -6.51% |  
> (R) -7.36% |
> |                 | fork (ops/sec)            |          996.00 |  (R) 
> -9.00% | (R) -10.27% |         (R) -9.92% | (R) -11.19% | (R) -10.69% | 
> (R) -10.28% |
> +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> 
> Regressions on AWS Graviton3 (arm64) :
> +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> | Benchmark       | Result Class            |   6-19-0 (base) |  
>   7-0-0-rc1 |   7-0-0-rc2 |  7-0-0-rc2-gaf4e9ef3d784 |   7-0-0-rc3 |  
>   7-0-0-rc4 |   7-0-0-rc5 |
> +=================+==========================================================+=================+=============+=============+===========================+=============+=============+=============+
> | micromm/vmalloc | fix_size_alloc_test: p:1, h:0, l:500000 (usec)      
>       |       320101.50 |  (R) -4.72% |  (R) -3.81% |               (R) 
> -5.05% |      -3.06% |      -3.16% |  (R) -3.91% |
> |                 | fix_size_alloc_test: p:4, h:0, l:500000 (usec)      
>       |       522072.83 |  (R) -2.15% |      -1.25% |               (R) 
> -2.16% |  (R) -2.13% |      -2.10% |      -1.82% |
> |                 | fix_size_alloc_test: p:16, h:0, l:500000 (usec)      
>      |      1041640.33 |      -0.50% |  (R) -2.04% |                 
> -1.43% |      -0.69% |      -1.78% |  (R) -2.03% |
> |                 | fix_size_alloc_test: p:256, h:1, l:100000 (usec)    
>       |      2255794.00 |      -1.51% |  (R) -2.24% |             (R) 
> -2.33% |      -1.14% |      -0.94% |      -1.60% |
> |                 | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 
> (usec) |       343543.83 |  (R) -4.50% |  (R) -3.54% |             (R) 
> -5.00% |  (R) -4.88% |  (R) -4.01% |  (R) -5.54% |
> |                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 
> (usec) |       342290.33 |  (R) -5.15% |  (R) -3.24% |             (R) 
> -3.76% |  (R) -5.37% |  (R) -3.74% |  (R) -5.51% |
> |                 | random_size_align_alloc_test: p:1, h:0, l:500000 
> (usec)  |      1209666.83 |      -2.43% |      -2.09% |                 
>    -1.19% |  (R) -4.39% |      -1.81% |      -3.15% |
> +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> | perf/syscall    | execve (ops/sec)            |         1219.58 |      
>         |  (R) -8.12% |         (R) -7.37% |  (R) -7.60% |  (R) -7.86% 
> |  (R) -7.71% |
> |                 | fork (ops/sec)            |          863.67 |        
>       |  (R) -7.24% |         (R) -7.07% |  (R) -6.42% |  (R) -6.93% |  
> (R) -6.55% |
> +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> 
> 
> The details of latest bisections that were carried out for the above
> listed regressions, are given below :
> -Graviton3 (arm64)
>   good: v6.19 (05f7e89ab973)
>   bad:  v7.0-rc2 (11439c4635ed)
>   workload: perf/syscall (execve)
>   bisected to: f1427a1d6415 (“slab: make percpu sheaves compatible with
>   kmalloc_nolock()/kfree_nolock()”)
> 
> -Sapphire Rapids (x86_64)
>   good: v6.19 (05f7e89ab973)
>   bad:  v7.0-rc3 (1f318b96cc84)
>   workload: perf/syscall (fork)
>   bisected to: f1427a1d6415 (“slab: make percpu sheaves compatible with
>   kmalloc_nolock()/kfree_nolock()”)
> 
> -Graviton3 (arm64)
>   good: v6.19 (05f7e89ab973)
>   bad:  v7.0-rc3 (1f318b96cc84)
>   workload: perf/syscall (execve)
>   bisected to: f3421f8d154c (“slab: introduce percpu sheaves bootstrap”)

Yeah none of these are likely to introduce the regression.
We've seen other reports from e.g. lkp pointing to later commits that remove
the cpu (partial) slabs. The theory is that on benchmarks that stress vma
and maple node caches (fork and execve are likely those), the introduction
of sheaves in 6.18 (for those caches only) resulted in ~doubled percpu
caching capacity (and likely associated performance increase) - by sheaves
backed by cpu (partial) slabs,. Removing the latter then looks like a
regression in isolation in the 7.0 series.

A regression of vmalloc related to kvfree_rcu might be new. Although if it's
kvfree_rcu() of vmalloc'd objects, it would be weird. More likely they are
kvmalloc'd but small enough to be actually kmalloc'd? What are the details
of that test?

> I'm aware that some fixes for the sheaves series have already been
> merged around v7.0-rc3; however, these do not appear to resolve the
> regressions described above completely. Are there additional fixes or
> follow-ups in progress that I should evaluate? I can investigate
> further and provide additional data, if that would be useful.

We have some followups planned for 7.1 that would make a difference for
systems with memoryless nodes. That would mean "numactl -H" shows nodes that
have cpus but no memory, or that memory is all ZONE_MOVABLE and not ZONE_NORMAL.

Thanks,
Vlastimil

> Thank you.
> Aishwarya Rambhadran
> 
> 
> On 23/01/26 12:22 PM, Vlastimil Babka wrote:

