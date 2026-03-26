Return-Path: <stable+bounces-230459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIoiGaIrxWnb7gQAu9opvQ
	(envelope-from <stable+bounces-230459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:50:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4FB335797
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFE0F301914D
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935413F87E5;
	Thu, 26 Mar 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bCtaJne+"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CB364E8E;
	Thu, 26 Mar 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529005; cv=none; b=sWJcCq2z1nEJ1/dzrW/VBC4FbJG/2mrSTQT0ac4GpdFyi7PfkULcd0NMqt50ZGzzAHQsixmYhLfzE7AVWXQhmwS2jSJLmxqueNMG3+97DGZBGuD7twULmHAYmEDDSo8K/lcZh3ykfILkDB4uCsu8OxyCXLbImXKGY7T9MwC+SHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529005; c=relaxed/simple;
	bh=ezgYEtb3s3eMwdi/vpYeeeN3GfCmCpHq3Lr9/CE5zkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrE0NyRz2wRkvox9tnvlK8jJIJFgS7TDZTHq/JpFmmB37Fp32JLE+qC6GUN99RC9JOfp0Bha1TTKREN9E8fu5IFY+JzYsFTohPUbhy2xyBhgfRkFffsRBg5TUQ8C4YVaxzEJcvxRQwVi7lI+etOn0kyN2h2Met1jm7ZNSVFs1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bCtaJne+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AABD4175A;
	Thu, 26 Mar 2026 05:43:15 -0700 (PDT)
Received: from [10.163.180.31] (unknown [10.163.180.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACF9D3FB90;
	Thu, 26 Mar 2026 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774529001; bh=ezgYEtb3s3eMwdi/vpYeeeN3GfCmCpHq3Lr9/CE5zkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bCtaJne+gV11OuDXbXnU3WdUE43cGOfz2lttCvq33Asfu1kM2mofBv55xFLamnJzZ
	 0/Di/YTw9i/DhUd4736CEpw/8+q9uKmhsk3rNmpgD6aymocprtwCVhYdQvx1pYm73M
	 3zilmdWgkkIWAG/rWlShFTapnNPU1YWZyxamw1nU=
Message-ID: <afe9ba0a-1924-42a8-a9c5-34eec709f883@arm.com>
Date: Thu, 26 Mar 2026 18:13:11 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION] slab: replace cpu (partial) slabs with sheaves
To: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
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
Content-Language: en-US
From: Aishwarya Rambhadran <aishwarya.rambhadran@arm.com>
In-Reply-To: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com,arm.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230459-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aishwarya.rambhadran@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,msgid.link:url,arm.com:dkim,arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA4FB335797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vlastimil, Harry,

We have observed few kernel performance benchmark regressions,
mainly in perf & vmalloc workloads, when comparing v6.19 mainline
kernel results against later releases in the v7.0 cycle.
Independent bisections on different machines consistently point
to commits within the slab percpu sheaves series. However, towards
the end of the bisection, the signal becomes less clear, so it's
not yet certain which specific commit within the series is the
root cause.

The workloads were triggered on AWS Graviton3 (arm64) & AWS Intel
Sapphire Rapids (x86_64) systems in which the regressions are
reproducible across different kernel release candidates.
(R)/(I) mean statistically significant regression/improvement,
where "statistically significant" means the 95% confidence
intervals do not overlap”.

Below given are the performance benchmark results generated by
Fastpath Tool, for different kernel -rc versions relative to the
base version v6.19, executed on the mentioned SUTs. The perf/
syscall benchmarks (execve/fork) regress consistently by ~6–11% on
both arm64 and x86_64 across v7.0-rc1 to rc5, while vmalloc
workloads show smaller but stable regressions (~2–10%), particularly
in kvfree_rcu paths.

Regressions on AWS Intel Sapphire Rapids (x86_64) :
+-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
| Benchmark       | Result Class            |   6-19-0 (base) |  
  7-0-0-rc1 |   7-0-0-rc2 |  7-0-0-rc2-gaf4e9ef3d784 |   7-0-0-rc3 |  
  7-0-0-rc4 |   7-0-0-rc5 |
+=================+==========================================================+=================+=============+=============+===========================+=============+=============+=============+
| micromm/vmalloc | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 
(usec) |       262605.17 |      -4.94% |      -7.48% |             (R) 
-8.11% |      -4.51% |      -6.23% |      -3.47% |
|                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 
(usec) |       253198.67 |      -7.56% | (R) -10.57% |            (R) 
-10.13% |  (R) -7.07% |      -6.37% |      -6.55% |
|                 | pcpu_alloc_test: p:1, h:0, l:500000 (usec)           
  |       197904.67 |      -2.07% |      -3.38% |             -2.07% |  
     -2.97% |  (R) -4.30% |      -3.39% |
|                 | random_size_align_alloc_test: p:1, h:0, l:500000 
(usec)  |      1707089.83 |      -2.63% |  (R) -3.69% |               
(R) -3.25% |  (R) -2.87% |      -2.22% |  (R) -3.63% |
+-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
| perf/syscall    | execve (ops/sec)            |         1202.92 |  (R) 
-7.15% |  (R) -7.05% |         (R) -7.03% |  (R) -7.93% |  (R) -6.51% |  
(R) -7.36% |
|                 | fork (ops/sec)            |          996.00 |  (R) 
-9.00% | (R) -10.27% |         (R) -9.92% | (R) -11.19% | (R) -10.69% | 
(R) -10.28% |
+-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+

Regressions on AWS Graviton3 (arm64) :
+-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
| Benchmark       | Result Class            |   6-19-0 (base) |  
  7-0-0-rc1 |   7-0-0-rc2 |  7-0-0-rc2-gaf4e9ef3d784 |   7-0-0-rc3 |  
  7-0-0-rc4 |   7-0-0-rc5 |
+=================+==========================================================+=================+=============+=============+===========================+=============+=============+=============+
| micromm/vmalloc | fix_size_alloc_test: p:1, h:0, l:500000 (usec)      
      |       320101.50 |  (R) -4.72% |  (R) -3.81% |               (R) 
-5.05% |      -3.06% |      -3.16% |  (R) -3.91% |
|                 | fix_size_alloc_test: p:4, h:0, l:500000 (usec)      
      |       522072.83 |  (R) -2.15% |      -1.25% |               (R) 
-2.16% |  (R) -2.13% |      -2.10% |      -1.82% |
|                 | fix_size_alloc_test: p:16, h:0, l:500000 (usec)      
     |      1041640.33 |      -0.50% |  (R) -2.04% |                 
-1.43% |      -0.69% |      -1.78% |  (R) -2.03% |
|                 | fix_size_alloc_test: p:256, h:1, l:100000 (usec)    
      |      2255794.00 |      -1.51% |  (R) -2.24% |             (R) 
-2.33% |      -1.14% |      -0.94% |      -1.60% |
|                 | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 
(usec) |       343543.83 |  (R) -4.50% |  (R) -3.54% |             (R) 
-5.00% |  (R) -4.88% |  (R) -4.01% |  (R) -5.54% |
|                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 
(usec) |       342290.33 |  (R) -5.15% |  (R) -3.24% |             (R) 
-3.76% |  (R) -5.37% |  (R) -3.74% |  (R) -5.51% |
|                 | random_size_align_alloc_test: p:1, h:0, l:500000 
(usec)  |      1209666.83 |      -2.43% |      -2.09% |                 
   -1.19% |  (R) -4.39% |      -1.81% |      -3.15% |
+-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
| perf/syscall    | execve (ops/sec)            |         1219.58 |      
        |  (R) -8.12% |         (R) -7.37% |  (R) -7.60% |  (R) -7.86% 
|  (R) -7.71% |
|                 | fork (ops/sec)            |          863.67 |        
      |  (R) -7.24% |         (R) -7.07% |  (R) -6.42% |  (R) -6.93% |  
(R) -6.55% |
+-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+


The details of latest bisections that were carried out for the above
listed regressions, are given below :
-Graviton3 (arm64)
  good: v6.19 (05f7e89ab973)
  bad:  v7.0-rc2 (11439c4635ed)
  workload: perf/syscall (execve)
  bisected to: f1427a1d6415 (“slab: make percpu sheaves compatible with
  kmalloc_nolock()/kfree_nolock()”)

-Sapphire Rapids (x86_64)
  good: v6.19 (05f7e89ab973)
  bad:  v7.0-rc3 (1f318b96cc84)
  workload: perf/syscall (fork)
  bisected to: f1427a1d6415 (“slab: make percpu sheaves compatible with
  kmalloc_nolock()/kfree_nolock()”)

-Graviton3 (arm64)
  good: v6.19 (05f7e89ab973)
  bad:  v7.0-rc3 (1f318b96cc84)
  workload: perf/syscall (execve)
  bisected to: f3421f8d154c (“slab: introduce percpu sheaves bootstrap”)

I'm aware that some fixes for the sheaves series have already been
merged around v7.0-rc3; however, these do not appear to resolve the
regressions described above completely. Are there additional fixes or
follow-ups in progress that I should evaluate? I can investigate
further and provide additional data, if that would be useful.

Thank you.
Aishwarya Rambhadran


On 23/01/26 12:22 PM, Vlastimil Babka wrote:
> Percpu sheaves caching was introduced as opt-in but the goal was to
> eventually move all caches to them. This is the next step, enabling
> sheaves for all caches (except the two bootstrap ones) and then removing
> the per cpu (partial) slabs and lots of associated code.
>
> Besides (hopefully) improved performance, this removes the rather
> complicated code related to the lockless fastpaths (using
> this_cpu_try_cmpxchg128/64) and its complications with PREEMPT_RT or
> kmalloc_nolock().
>
> The lockless slab freelist+counters update operation using
> try_cmpxchg128/64 remains and is crucial for freeing remote NUMA objects
> without repeating the "alien" array flushing of SLUB, and to allow
> flushing objects from sheaves to slabs mostly without the node
> list_lock.
>
> Sending this v4 because various changes accumulated in the branch due to
> review and -next exposure (see the list below). Thanks for all the
> reviews!
>
> Git branch for the v4
>    https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=sheaves-for-all-v4
>
> Which is a snapshot of:
>    https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/sheaves-for-all
>
> Based on:
>    https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-7.0/sheaves-base
>    - includes a sheaves optimization that seemed minor but there was lkp
>      test robot result with significant improvements:
>      https://lore.kernel.org/all/202512291555.56ce2e53-lkp@intel.com/
>      (could be an uncommon corner case workload though)
>    - includes the kmalloc_nolock() fix commit a4ae75d1b6a2 that is undone
>      as part of this series
>
> Significant (but not critical) remaining TODOs:
> - Integration of rcu sheaves handling with kfree_rcu batching.
>    - Currently the kfree_rcu batching is almost completely bypassed. I'm
>      thinking it could be adjusted to handle rcu sheaves in addition to
>      individual objects, to get the best of both.
> - Performance evaluation. Petr Tesarik has been doing that on the RFC
>    with some promising results (thanks!) and also found a memory leak.
>
> Note that as many things, this caching scheme change is a tradeoff, as
> summarized by Christoph:
>
>    https://lore.kernel.org/all/f7c33974-e520-387e-9e2f-1e523bfe1545@gentwo.org/
>
> - Objects allocated from sheaves should have better temporal locality
>    (likely recently freed, thus cache hot) but worse spatial locality
>    (likely from many different slabs, increasing memory usage and
>    possibly TLB pressure on kernel's direct map).
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Changes in v4:
> - Fix up both missing and spurious r-b tags from v3, and add new ones
>    (big thanks to Hao Li, Harry, and Suren!)
> - Fix infinite recursion with kmemleak (Breno Leitao)
> - Use cache_has_sheaves() in pcs_destroy() (Suren)
> - Use cache_has_sheaves() in kvfree_rcu_barrier_on_cache() (Hao Li)
> - Bypass sheaf for remote object free also in kfree_nolock() (Harry)
> - WRITE_ONCE slab->counters in __update_freelist_slow() so
>    get_partial_node_bulk() can stop being paranoid (Harry)
> - Tweak conditions in alloc_from_new_slab() (Hao Li, Suren)
> - Rename get_partial*() functions to get_from_partial*() (Suren)
> - Rename variable freelist to object in ___slab_alloc() (Suren)
> - Separate struct partial_bulk_context instead of extending.
> - Rename flush_cpu_slab() to flush_cpu_sheaves() (Hao Li)
> - Add "mm/slab: fix false lockdep warning in __kfree_rcu_sheaf()" from
>    Harry.
> - Add counting of FREE_SLOWPATH stat to some missing places (Suren, Hao
>    Li)
> - Link to v3: https://patch.msgid.link/20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz
>
> Changes in v3:
> - Rebase to current slab/for-7.0/sheaves which itself is rebased to
>    slab/for-next-fixes to include commit a4ae75d1b6a2 ("slab: fix
>    kmalloc_nolock() context check for PREEMPT_RT")
> - Revert a4ae75d1b6a2 as part of "slab: simplify kmalloc_nolock()" as
>    it's no longer necessary.
> - Add cache_has_sheaves() helper to test for s->sheaf_capacity, use it
>    in more places instead of s->cpu_sheaves tests that were missed
>    (Hao Li)
> - Fix a bug where kmalloc_nolock() could end up trying to allocate empty
>    sheaf (not compatible with !allow_spin) in __pcs_replace_full_main()
>    (Hao Li)
> - Fix missing inc_slabs_node() in ___slab_alloc() ->
>    alloc_from_new_slab() path. (Hao Li)
>    - Also a bug where refill_objects() -> alloc_from_new_slab ->
>      free_new_slab_nolock() (previously defer_deactivate_slab()) would
>      do inc_slabs_node() without matching dec_slabs_node()
> - Make __free_slab call free_frozen_pages_nolock() when !allow_spin.
>    This was correct in the first RFC. (Hao Li)
> - Add patch to make SLAB_CONSISTENCY_CHECKS prevent merging.
> - Add tags from sveral people (thanks!)
> - Fix checkpatch warnings.
> - Link to v2: https://patch.msgid.link/20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz
>
> Changes in v2:
> - Rebased to v6.19-rc1+slab.git slab/for-7.0/sheaves
>    - Some of the preliminary patches from the RFC went in there.
> - Incorporate feedback/reports from many people (thanks!), including:
>    - Make caches with sheaves mergeable.
>    - Fix a major memory leak.
> - Cleanup of stat items.
> - Link to v1: https://patch.msgid.link/20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz
>
> ---
> Harry Yoo (1):
>        mm/slab: fix false lockdep warning in __kfree_rcu_sheaf()
>
> Vlastimil Babka (21):
>        mm/slab: add rcu_barrier() to kvfree_rcu_barrier_on_cache()
>        slab: add SLAB_CONSISTENCY_CHECKS to SLAB_NEVER_MERGE
>        mm/slab: move and refactor __kmem_cache_alias()
>        mm/slab: make caches with sheaves mergeable
>        slab: add sheaves to most caches
>        slab: introduce percpu sheaves bootstrap
>        slab: make percpu sheaves compatible with kmalloc_nolock()/kfree_nolock()
>        slab: handle kmalloc sheaves bootstrap
>        slab: add optimized sheaf refill from partial list
>        slab: remove cpu (partial) slabs usage from allocation paths
>        slab: remove SLUB_CPU_PARTIAL
>        slab: remove the do_slab_free() fastpath
>        slab: remove defer_deactivate_slab()
>        slab: simplify kmalloc_nolock()
>        slab: remove struct kmem_cache_cpu
>        slab: remove unused PREEMPT_RT specific macros
>        slab: refill sheaves from all nodes
>        slab: update overview comments
>        slab: remove frozen slab checks from __slab_free()
>        mm/slub: remove DEACTIVATE_TO_* stat items
>        mm/slub: cleanup and repurpose some stat items
>
>   include/linux/slab.h |    6 -
>   mm/Kconfig           |   11 -
>   mm/internal.h        |    1 +
>   mm/page_alloc.c      |    5 +
>   mm/slab.h            |   65 +-
>   mm/slab_common.c     |   61 +-
>   mm/slub.c            | 2689 ++++++++++++++++++--------------------------------
>   7 files changed, 1031 insertions(+), 1807 deletions(-)
> ---
> base-commit: a66f9c0f1ba2dd05fa994c800ebc63f265155f91
> change-id: 20251002-sheaves-for-all-86ac13dc47a5
>
> Best regards,

