Return-Path: <stable+bounces-114055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EACA2A50B
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E811888D3F
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C86224884;
	Thu,  6 Feb 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s8GTSZbw"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FC0226548;
	Thu,  6 Feb 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835283; cv=none; b=J6O5H8MCRLP0IgYJZ+Yg8NXxRuQ5TL8TgteTEmDN/39lAy3BCPI29NADMKSjtuKzCs4e2o/YCJXFSXEjKKln27irgNMLePRlyeyQIeqFKFdqDqLxyVxvkabo0vA15dAEK+Y8TJXZYn+iM0e3zW7G2K3QQG8Tg+adQo74v4u7tHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835283; c=relaxed/simple;
	bh=KkN8KoXTOeZ8lZ3T82dFaZ8J/Dzj11SUyaxzwofgmG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjgBPC5IIBpoTQEFc6jNCyV4IespliDSZdbxhfh3Zcoo34WHgBMbgkNJzBXtByBWi5/rXpll3lSfs5wb8He4HMDngkCC6Mq10eI4JtgwLVEPjOMWqV+yldM0Pyj9BziQQhV2u0g1QGs1paorecIYwxCUUq3hJtyiO8c1ame0OrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s8GTSZbw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.66.79] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id B681C20BCAF2;
	Thu,  6 Feb 2025 01:47:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B681C20BCAF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738835281;
	bh=YT/fFA4ucxm2xXcs7puYh3xl7FDSSE0Kjemi8yIfrZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s8GTSZbw/RyJkeq6c76yW5KffvRHoaNKXTiPKP4rrNZkF89JXrdX5n2MOSssqh5C7
	 02obP9U3DcyT3AR2o9fS7qA+/FXRIKi1VSiw4WOustYQ6P4425dPhU90mxdEJG7qjK
	 0awnnEo5EOynizMBsnkW4MyQRMgXE8LGjAeOikqg=
Message-ID: <7042c53b-31b6-491d-8310-352d18334742@linux.microsoft.com>
Date: Thu, 6 Feb 2025 15:17:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu,
 Michael Kelley <mhklinux@outlook.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <20250205095506.GB7145@noisy.programming.kicks-ass.net>
 <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>
 <20250205101600.GC7145@noisy.programming.kicks-ass.net>
 <e0774ea1-27ac-4aa1-9a96-5e27aa8328e6@amd.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <e0774ea1-27ac-4aa1-9a96-5e27aa8328e6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/6/2025 2:40 PM, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 2/5/2025 3:46 PM, Peter Zijlstra wrote:
>> On Wed, Feb 05, 2025 at 03:43:54PM +0530, K Prateek Nayak wrote:
>>> Hello Peter,
>>>
>>> Thank you for the background!
>>>
>>> On 2/5/2025 3:25 PM, Peter Zijlstra wrote:
>>>> On Wed, Feb 05, 2025 at 03:18:24PM +0530, K Prateek Nayak wrote:
>>>>
>>>>> Have there been any reports on an x86 system / VM where
>>>>> topology_span_sane() was tripped?
>>>>
>>>> At the very least Intel SNC 'feature' tripped it at some point. They
>>>> figured it made sense to have the LLC span two nodes.
> 
> I'm 99% sure that this might have been the topology_sane() check on
> the x86 side and not the topology_span_sane() check in
> kernel/sched/topology.c
> 
> I believe one of the original changes that did the plumbing for SNC was
> commit 2c88d45edbb8 ("x86, sched: Treat Intel SNC topology as default,
> COD as exception") from Alison where they mentions that they saw the
> following splat when running with SNC:
> 
>      sched: CPU #3's llc-sibling CPU #0 is not on the same node! [node: 
> 1 != 0]. Ignoring dependency.
> 
> This comes from the topology_sane() check in arch/x86/boot/smpboot.c
> and match_llc() on x86 side was modified to work around that.
> 
>>>>
>>>> But I think there were some really dodgy VMs too.
> 
> For VMs too, it is easy to trip topology_sane() check on x86 side. With
> QEMU, I can run:
> 
>      qemu-system-x86_64 -enable-kvm -cpu host \
>      -smp cpus=32,sockets=2,cores=8,threads=2 \
>      ...
>      -numa node,cpus=0-7,cpus=16-23,memdev=m0,nodeid=0 \
>      -numa node,cpus=8-15,cpus=24-31,memdev=m1,nodeid=1 \
>      ...
> 
> and I get:
> 
>      sched: CPU #8's llc-sibling CPU #0 is not on the same node! [node: 
> 1 != 0]. Ignoring dependency.
> 
> This is because consecutive CPUs (0-1,2-3,...) are SMT siblings and
> CPUs 0-15 are on the same socket as a result of how QEMU presents
> MADT to the guest but then I go ahead and mess things up by saying
> CPUs 0-7,16-23 are on one NUMA node, and the rest are on the other.
> 
> I still haven't managed to trip topology_span_sane() tho.
> 
>>>>
>>>> But yeah, its not been often. But basically dodgy BIOS/VM data can mess
>>>> up things badly enough for it to trip.
>>>
>>> Has it ever happened without tripping the topology_sane() check first
>>> on the x86 side?
> 
> What topology_span_sane() does is, it iterates over all the CPUs at a
> given topology level and makes sure that the cpumask for a CPU at
> that domain is same as the cpumask of every other CPU set on that mask
> for that topology level.
> 
> If two CPUs are set on a mask, they should have the same mask. If CPUs
> are not set on each other's mask, the masks should be disjoint.
> 
> On x86, the way set_cpu_sibling_map() works, CPUs are set on each other's
> shared masks iff match_*() returns true:
> 
> o For SMT, this means:
> 
>    - If X86_FEATURE_TOPOEXT is set:
>      - pkg_id must match.
>      - die_id must match.
>      - amd_node_id must match.
>      - llc_id must match.
>      - Either core_id or cu_id must match. (*)
>      - NUMA nodes must match.
> 
>    - If !X86_FEATURE_TOPOEXT:
>      - pkg_id must match.
>      - die_id must match.
>      - core_id must match.
>      - NUMA nodes must match.
> 
> o For CLUSTER this means:
> 
>    - If l2c_id is not populated (== BAD_APICID)
>      - Same conditions as SMT.
> 
>    - If l2c_id is populated (!= BAD_APICID)
>      - l2c_id must match.
>      - NUMA nodes must match.
> 
> o For MC it means:
> 
>    - llc_id must be populated (!= BAD_APICID) and must match.
>    - If INTEL_SNC: pkg_id must match.
>    - If !INTEL_SNC: NUMA nodes must match.
> 
> o For PKG domain:
>    - Inserted only if !x86_has_numa_in_package.
>    - CPUs should be in same NUMA node.
> 
> All in all, other that the one (*) decision point, everything else has
> to strictly match for CPUs to be set in each other's CPU mask. And if
> they match with one CPU, they should match will all other CPUs in mask
> and it they mismatch with one, they should mismatch with all leading
> to link_mask() never being called.
> 
> This is why I think that the topology_span_sane() check is redundant
> when the x86 bits have already ensured masks cannot overlap in all
> cases except for potentially in the (*) case.
> 
> So circling back to my original question around "SDTL_ARCH_VERIFIED",
> would folks be okay to an early bailout from topology_span_sane() on:
> 
>      if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
>          return;
> 
> and more importantly, do folks care enough about topology_span_sane()
> to have it run on other architectures and not just have it guarded
> behind just "sched_debug()" which starts off as false by default?
> 
> (Sorry for the long answer explaining my thought process.)
> 


Thanks for sharing your valuable insights.
I am sorry, I could not find SDTL_ARCH_VERIFIED in linux-next tip. Am I
missing something?

Regards,
Naman



