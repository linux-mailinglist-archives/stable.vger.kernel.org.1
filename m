Return-Path: <stable+bounces-114845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93445A3042A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D4F188A1F6
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF69A1E9B17;
	Tue, 11 Feb 2025 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NwMaYYUL"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB926BDB6;
	Tue, 11 Feb 2025 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739257615; cv=none; b=Ch2VyusLPN1M74CGsAv8CsjdZsv0SfrF6ZKSD4pMzjFU43/0+N+b9ELe6Z9laLGyDTP8ozMix9uX3s5P/4b+Z8wcNneoXmQMIE1TnfKub6o86thpoGgUBWtWBvHo0ELokyDzccUoXSNNIG7MdcMgHmfWnY3FMwauw7+73MgR4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739257615; c=relaxed/simple;
	bh=/EbPcvy2Ks4O7z5OO90sN9hUCqBRsfOO+uoeDD5KaK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfL6WD/VEZfVzThns8ryPMAPtoMyNnUsumQKY0S/qPlEAbzpfgbq7d7/xxjaUr5u0UyYC7fr2cDbdiIaTLdEHYb+pa4PGLEhwZxFfXahwnYR09DsDXAV6xet3qPkyu0i+HWRk28zkttAvryy/PKoHNvaaZqmc34GCuBPS3CL8Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NwMaYYUL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.65.93] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 291902107A9A;
	Mon, 10 Feb 2025 23:06:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 291902107A9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739257613;
	bh=8IACe/n3PDE/RDA/fza2bOnl6roZ4g/mKKN5hC+OtqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NwMaYYUL6H23TKh4dcXHc6XTzXxLT5DNp+uGchcv8rcpCoRQBBpHcXOruWPZsRSIP
	 AkiCsIx0M6tb/7u1ZuZOTCNeJNR0wAFmOBDqrtII2ZqwchiVuWjZ97fA0uOm/xyQpO
	 jjUtGyAsSxG3VZ7iNyYHmtNE3V1/uYYZw+NJsf6k=
Message-ID: <f6c499c6-c644-4ce1-9ade-7786d29e0a6a@linux.microsoft.com>
Date: Tue, 11 Feb 2025 12:36:46 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu,
 Michael Kelley <mhklinux@outlook.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <ef199f2a-f970-4c86-a3f2-ddb6ad7abc96@linux.ibm.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <ef199f2a-f970-4c86-a3f2-ddb6ad7abc96@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/11/2025 11:22 AM, Shrikanth Hegde wrote:
> 
> 
> On 2/5/25 15:18, K Prateek Nayak wrote:
>> Hello all,
>>
>> On 2/3/2025 5:17 PM, Naman Jain wrote:
>>> [..snip..]
>>>
>>> Adding a link to the other patch which is under review.
>>> https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/
>>> Above patch tries to optimize the topology sanity check, whereas this
>>> patch makes it optional. We believe both patches can coexist, as even
>>> with optimization, there will still be some performance overhead for
>>> this check.
>>
>> I would like to discuss this parallelly here. Going back to the original
>> problem highlighted in [1], the topology_span_sane() came to be as a
>> result of how drivers/base/arch_topology.c computed the
>> cpu_coregroup_mask().
>>
>> [1] https://lore.kernel.org/all/1577088979-8545-1-git-send-email- 
>> prime.zeng@hisilicon.com/
>>
>> Originally described problematic topology is as follows:
>>
>>      **************************
>>      NUMA:               0-2,  3-7
>>      core_siblings:   0-3,  4-7
>>      **************************
>>
>> with the problematic bit in the handling being:
>>
>>      const struct cpumask *cpu_coregroup_mask(int cpu)
>>      {
>>              const cpumask_t *core_mask = 
>> cpumask_of_node(cpu_to_node(cpu));
>>
>>              ...
>>
>>              if (last_level_cache_is_valid(cpu)) {
>>                      /* If the llc_sibling is subset of node return 
>> llc_sibling */
>>                      if 
>> (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
>>                              core_mask = &cpu_topology[cpu].llc_sibling;
>>
>>                      /* else the core_mask remains cpumask_of_node() */
>>              }
>>
>>              ...
>>
>>              return core_mask;
>>      }
>>
>> For CPU3, the llc_sibling 0-3 is not a subset of node mask 3-7, and the
>> fallback is to use 3-7. For CPUs 4-7, the llc_sibling 4-7 is a subset of
>> the node mask 3-7 and the coremask is returned a 4-7.
>>
>> In case of x86 (and perhaps other arch too) the arch/x86 bits ensure
>> that this inconsistency never happens for !NUMA domains using the
>> topology IDs. If a set of IDs match between two CPUs, the CPUs are set
>> in each other's per-CPU topology mask (see link_mask() usage and
>> match_*() functions in arch/x86/kernel/smpboot.c)
>>
>> If the set of IDs match with one CPU, it should match with all other
>> CPUs set in the cpumask for a given topology level. If it doesn't match
>> with one, it will not match with any other CPUs in the cpumask either.
>> The cpumasks of two CPUs can either be equal or disjoint at any given
>> level. Steve's optimization reverses this to check if the the cpumask
>> of set of CPUs match.
>>
>> Have there been any reports on an x86 system / VM where
>> topology_span_sane() was tripped? Looking at the implementation it
>> does not seem possible (at least to my eyes) with one exception of
>> AMD Fam 0x15 processors which set "cu_id" and match_smt() will look at
>> cu_id if the core_id doesn't match between 2 CPUs. It may so happen
>> that core IDs may match with one set of CPUs and cu_id may match with
>> another set of CPUs if the information from CPUID is faulty.
>>
>> What I'm getting to is that the arch specific topology parsing code
>> can set a "SDTL_ARCH_VERIFIED" flag indicating that the arch specific
>> bits have verified that the cpumasks are either equal or disjoint and
>> since sched_debug() is "false" by default, topology_span_sane() can
>> bail out if:
>>
>>      if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
>>          return;
>>
> 
> it would simpler to use sched_debug(). no?
> 
> Since it can be enabled at runtime by "echo Y > verbose", if one one 
> needs to enable even after boot. Wouldn't that suffice to run 
> topology_span_sane by doing a hotplug?
> 

I agree with your point. We are keeping it the same. Thanks.


Regards,
Naman

>> In case arch specific parsing was wrong, "sched_verbose" can always
>> be used to double check the topology and for the arch that require
>> this sanity check, Steve's optimized version of
>> topology_span_sane() can be run to be sure of the sanity.
>>
>> All this justification is in case folks want to keep
>> topology_span_sane() around but if no one cares, Naman and Saurabh's
>> approach works as intended.
>>


