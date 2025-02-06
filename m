Return-Path: <stable+bounces-114146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E30A2AEB3
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B993A8C31
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12667152196;
	Thu,  6 Feb 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UKhIbrAN"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658A239591;
	Thu,  6 Feb 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862299; cv=none; b=jiz9ENf81opL0i5eyI/7hql1kZn41okUV7Sh6q92kTiLoN7A9AVT2Mbc911utaLW/ovjGIt1OUcIMglqHjGLcPTzJTIURe1uh3y700LGaIaaAr1dVG70NcejmyvrmzRmP98cTOozne2XbBDlGWfunVm4Qfcez4CIAzT3ESVSUKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862299; c=relaxed/simple;
	bh=hbP/3x6KEiP/AFfWmMNdmPcO1F6X8N7LZ1IHe/jJEzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4qp9F/7zEbxXuN8FYzD3TglAjKm015SVQ7g8V2ITefYgouDobtbtLbaJ2cIZOKjDdScCcThy2Fk84Ei+3/3jCWABRE8BYpPEiWgqdNodBU5/4pWl142A6WQw2MR7kJNtKdpKe+EaBVxPGPhM8BtCKmgKoXn8UKgF0fBO+pYDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UKhIbrAN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.105] (unknown [49.205.248.75])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2A220203719A;
	Thu,  6 Feb 2025 09:18:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A220203719A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738862296;
	bh=s6TxIZPfRA/UVdazO51m+rXb6j+xtWkHEhy66TbUCJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UKhIbrANHEoAXA85G5cW1059Du8+sBGUDYurIy6LhwELiuJgB7MBmU+7FQD+LB9hx
	 0I+DmMnulba91ppZBCr9J1v7ur/0TNfiZiLz7+RvFCiTrpzJUCKC1LvLuQ1Eal7TF+
	 /PO4Ezk5lwDf0C2cTeh44tyJlgo6HDOiuu1kpR1M=
Message-ID: <464cdd27-464c-423e-b07f-cfb641a6a025@linux.microsoft.com>
Date: Thu, 6 Feb 2025 22:48:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu,
 Michael Kelley <mhklinux@outlook.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <20250205095506.GB7145@noisy.programming.kicks-ass.net>
 <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>
 <20250205101600.GC7145@noisy.programming.kicks-ass.net>
 <e0774ea1-27ac-4aa1-9a96-5e27aa8328e6@amd.com>
 <xhsmhed0bjdum.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <xhsmhed0bjdum.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/6/2025 8:54 PM, Valentin Schneider wrote:
> On 06/02/25 14:40, K Prateek Nayak wrote:
>> What topology_span_sane() does is, it iterates over all the CPUs at a
>> given topology level and makes sure that the cpumask for a CPU at
>> that domain is same as the cpumask of every other CPU set on that mask
>> for that topology level.
>>
>> If two CPUs are set on a mask, they should have the same mask. If CPUs
>> are not set on each other's mask, the masks should be disjoint.
>>
>> On x86, the way set_cpu_sibling_map() works, CPUs are set on each other's
>> shared masks iff match_*() returns true:
>>
>> o For SMT, this means:
>>
>>     - If X86_FEATURE_TOPOEXT is set:
>>       - pkg_id must match.
>>       - die_id must match.
>>       - amd_node_id must match.
>>       - llc_id must match.
>>       - Either core_id or cu_id must match. (*)
>>       - NUMA nodes must match.
>>
>>     - If !X86_FEATURE_TOPOEXT:
>>       - pkg_id must match.
>>       - die_id must match.
>>       - core_id must match.
>>       - NUMA nodes must match.
>>
>> o For CLUSTER this means:
>>
>>     - If l2c_id is not populated (== BAD_APICID)
>>       - Same conditions as SMT.
>>
>>     - If l2c_id is populated (!= BAD_APICID)
>>       - l2c_id must match.
>>       - NUMA nodes must match.
>>
>> o For MC it means:
>>
>>     - llc_id must be populated (!= BAD_APICID) and must match.
>>     - If INTEL_SNC: pkg_id must match.
>>     - If !INTEL_SNC: NUMA nodes must match.
>>
>> o For PKG domain:
>>
>>     - Inserted only if !x86_has_numa_in_package.
>>     - CPUs should be in same NUMA node.
>>
>> All in all, other that the one (*) decision point, everything else has
>> to strictly match for CPUs to be set in each other's CPU mask. And if
>> they match with one CPU, they should match will all other CPUs in mask
>> and it they mismatch with one, they should mismatch with all leading
>> to link_mask() never being called.
>>
> 
> Nice summary, thanks for that - I'm not that familiar with the x86 topology
> faff.
> 
> 
>> This is why I think that the topology_span_sane() check is redundant
>> when the x86 bits have already ensured masks cannot overlap in all
>> cases except for potentially in the (*) case.
>>
>> So circling back to my original question around "SDTL_ARCH_VERIFIED",
>> would folks be okay to an early bailout from topology_span_sane() on:
>>
>>       if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
>>        return;
>>
>> and more importantly, do folks care enough about topology_span_sane()
>> to have it run on other architectures and not just have it guarded
>> behind just "sched_debug()" which starts off as false by default?
>>
> 
> If/when possible I prefer to have sanity checks run unconditionally, as
> long as they don't noticeably impact runtime. Unfortunately this does show
> up in the boot time, though Steve had a promising improvement for that.
> 
> Anyway, if someone gets one of those hangs on a
> 
>    do { } while (group != sd->groups)
> 
> they'll quickly turn on sched_verbose (or be told to) and the sanity check
> will holler at them, so I'm not entirely against it.


Thanks for the feedback :)

Regards,
Naman

