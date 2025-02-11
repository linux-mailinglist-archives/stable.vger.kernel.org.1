Return-Path: <stable+bounces-114838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA239A30310
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 06:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA5D16250E
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 05:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4CF1E3DFD;
	Tue, 11 Feb 2025 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qxiaXSm6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B402F5E;
	Tue, 11 Feb 2025 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253151; cv=none; b=GdWKYyoAqgujzMkxIg218XDBNMPEvYYcsJ8bJS8lzpRT2y/N0c9iX5TPrMmjy/z/UtjbZqKprNAa/2QIAGx8M2mDTlbT1sidsZav1OoJNjVnYuZOeNYm0q0K5J2vYnBqag/JcjpO1yvQSbGHpSeexBfIh4S8O1wZ7R8AgviIwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253151; c=relaxed/simple;
	bh=DMj4tGjqvdwlOWVYu751iDm64XxUeKhelGN+iiTLpy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zj3QXgbaVJNTkDk41UOAvMCV4t/58DyNiH5ho8cG8w3BwoNlGdZ32lP+EZVVQJqsNsIztVQT4Ghl6sNJq6CZtTUDsinrTphrwncy5VII4G8g+HBI+66n4EN+hQ/zVWHuP8y04/mpS0gnaa04bfdLgVh7LyLi63jZfpaky0CsgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qxiaXSm6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B5Npiv026470;
	Tue, 11 Feb 2025 05:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GeG+IR
	YEQe8WhAr26yLfnzlYVVSr/sGxKC+T2ap15wo=; b=qxiaXSm62+mCTT2B6HP90u
	M5GGbpaxLZIdC3B6Yc821AM9JeneJoVn26JtXzMixyfrJXox6XbOHPSho8P70uLp
	54AaTobJWVGfAITiH4BiWkwaiOgWGRygWVUyR1vf21rG5EJSDbVy3fuwsasWh9cj
	kf0F9+HlpTEh1YVEY8ptjBJRB+nwnfx62Hc8w2o2HZZP8IQiD/DKMJozO0eJsYP/
	K48j+BKuXvGB8EqvmIZZ4nS2txCp0pzVNnDHDqRyy0kAEkYOeRVQuq5vRjutngmP
	U8URpYjlot0SCh3/wfjdPL5SdT3k1ab5nnW3KXX5+wPVcYjIXzhHXBZ9WQwv83oQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44r0c982v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 05:52:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51B5qAnu016222;
	Tue, 11 Feb 2025 05:52:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44r0c982v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 05:52:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51B4NF9S000978;
	Tue, 11 Feb 2025 05:52:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjkn1v33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 05:52:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51B5q7hs45744536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 05:52:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 630D920043;
	Tue, 11 Feb 2025 05:52:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1287820040;
	Tue, 11 Feb 2025 05:52:04 +0000 (GMT)
Received: from [9.39.23.89] (unknown [9.39.23.89])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Feb 2025 05:52:03 +0000 (GMT)
Message-ID: <ef199f2a-f970-4c86-a3f2-ddb6ad7abc96@linux.ibm.com>
Date: Tue, 11 Feb 2025 11:22:02 +0530
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
        Naman Jain <namjain@linux.microsoft.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve Wahl <steve.wahl@hpe.com>,
        Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        srivatsa@csail.mit.edu, Michael Kelley <mhklinux@outlook.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bMfAI1L77PO9FH8o7n75SFHSR45_0yUC
X-Proofpoint-GUID: 4MyL44aK95Al_BclWaWWvmbvBw_vRMCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_02,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110031



On 2/5/25 15:18, K Prateek Nayak wrote:
> Hello all,
> 
> On 2/3/2025 5:17 PM, Naman Jain wrote:
>> [..snip..]
>>
>> Adding a link to the other patch which is under review.
>> https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/
>> Above patch tries to optimize the topology sanity check, whereas this
>> patch makes it optional. We believe both patches can coexist, as even
>> with optimization, there will still be some performance overhead for
>> this check.
> 
> I would like to discuss this parallelly here. Going back to the original
> problem highlighted in [1], the topology_span_sane() came to be as a
> result of how drivers/base/arch_topology.c computed the
> cpu_coregroup_mask().
> 
> [1] https://lore.kernel.org/all/1577088979-8545-1-git-send-email- 
> prime.zeng@hisilicon.com/
> 
> Originally described problematic topology is as follows:
> 
>      **************************
>      NUMA:               0-2,  3-7
>      core_siblings:   0-3,  4-7
>      **************************
> 
> with the problematic bit in the handling being:
> 
>      const struct cpumask *cpu_coregroup_mask(int cpu)
>      {
>              const cpumask_t *core_mask = 
> cpumask_of_node(cpu_to_node(cpu));
> 
>              ...
> 
>              if (last_level_cache_is_valid(cpu)) {
>                      /* If the llc_sibling is subset of node return 
> llc_sibling */
>                      if (cpumask_subset(&cpu_topology[cpu].llc_sibling, 
> core_mask))
>                              core_mask = &cpu_topology[cpu].llc_sibling;
> 
>                      /* else the core_mask remains cpumask_of_node() */
>              }
> 
>              ...
> 
>              return core_mask;
>      }
> 
> For CPU3, the llc_sibling 0-3 is not a subset of node mask 3-7, and the
> fallback is to use 3-7. For CPUs 4-7, the llc_sibling 4-7 is a subset of
> the node mask 3-7 and the coremask is returned a 4-7.
> 
> In case of x86 (and perhaps other arch too) the arch/x86 bits ensure
> that this inconsistency never happens for !NUMA domains using the
> topology IDs. If a set of IDs match between two CPUs, the CPUs are set
> in each other's per-CPU topology mask (see link_mask() usage and
> match_*() functions in arch/x86/kernel/smpboot.c)
> 
> If the set of IDs match with one CPU, it should match with all other
> CPUs set in the cpumask for a given topology level. If it doesn't match
> with one, it will not match with any other CPUs in the cpumask either.
> The cpumasks of two CPUs can either be equal or disjoint at any given
> level. Steve's optimization reverses this to check if the the cpumask
> of set of CPUs match.
> 
> Have there been any reports on an x86 system / VM where
> topology_span_sane() was tripped? Looking at the implementation it
> does not seem possible (at least to my eyes) with one exception of
> AMD Fam 0x15 processors which set "cu_id" and match_smt() will look at
> cu_id if the core_id doesn't match between 2 CPUs. It may so happen
> that core IDs may match with one set of CPUs and cu_id may match with
> another set of CPUs if the information from CPUID is faulty.
> 
> What I'm getting to is that the arch specific topology parsing code
> can set a "SDTL_ARCH_VERIFIED" flag indicating that the arch specific
> bits have verified that the cpumasks are either equal or disjoint and
> since sched_debug() is "false" by default, topology_span_sane() can
> bail out if:
> 
>      if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
>          return;
> 

it would simpler to use sched_debug(). no?

Since it can be enabled at runtime by "echo Y > verbose", if one one 
needs to enable even after boot. Wouldn't that suffice to run 
topology_span_sane by doing a hotplug?

> In case arch specific parsing was wrong, "sched_verbose" can always
> be used to double check the topology and for the arch that require
> this sanity check, Steve's optimized version of
> topology_span_sane() can be run to be sure of the sanity.
> 
> All this justification is in case folks want to keep
> topology_span_sane() around but if no one cares, Naman and Saurabh's
> approach works as intended.
> 


