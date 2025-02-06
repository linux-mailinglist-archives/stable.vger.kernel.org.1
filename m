Return-Path: <stable+bounces-114046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 042DFA2A3E3
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264B07A19B8
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12399225A36;
	Thu,  6 Feb 2025 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JzJUkNfY"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105C15B10D;
	Thu,  6 Feb 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738833027; cv=fail; b=Ptl9NJk++sDce2EuxdoGVL6apWQbEpaR6rbWHlG2HrtVkEzOtWj90CuPChSBunkPKyM0MjmztSUgc5/nIOXGryhnRJJ5PSSI9R8WtS3pQiEvkJbYKO41NjRlwlPwskuKBJKJqLXZhE8HVD3wyQMYi094KpAOUoircixFRd2es/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738833027; c=relaxed/simple;
	bh=TisIJJ7B+QWgWyIqJWnFQNgDsOwFsBnzWyg9Ok6G7EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jkRLaw9S4j7V7+xXnISc4Fh4VugbKh0tRWGRXxEt6TEKVCFiROAod2fmmMzCTEDy/utzdb29CLqScGDs0AyXjsB/ehlB/CxVo2VAypt3CFceyirX+Cf43lbtWUxX16b5kt9EJ0wdYdsFUzeidPGXhsvz4PNLx8OOI7Xs4paZpJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JzJUkNfY; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dhv9WO06c5zPMfU7EAhh9w/KF5fOmL/vXKQ1/NuORVTRlv87FRzQabIlQw+ds0zGS8+6La9+A30qJCR631O0KV8jFsGnM9jPgSdU9Gn+CZzIK1jlGsItG/ENx6Idw89z8XMsdxpbQA2CrmI5cV0gDPHumWEKQ+lP90kBOAxvuy25MF3A5kjeVcTg2mngGXV+qQVdZWYQAv49cYnVgrraSM7qQrSTjbsWrB2dWrfuKm+JyrXJYzKeYPWITA4zMftZeOeWtAHAF/yhVeZfq0abnvkEshhJ7lIpPb3g6KLjOLGRQaXbQPQRVW0oDW9PBJqNzVEp/LMl33xk1B6UwyDLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lWoxvtR8uuM4TGD/+tc8u78p7wIOWut/6iFqrUU0v0=;
 b=CI3+XJKfLCeTlzPF0NdJyRCi1txCIkMdtKrCoq/3j6l4sl25u8CyMIf5uQFPtaiaHLFZseLtsU6xz1bQhF54Q2eK/lbwwlEI6e3IHgvb+S/9x9438hz009WyVoRPxFeU3qXrrYaglyOd68gNL0uMcaNwxye+1DBo+/ZmIpklH2DsDplVHnRpW0s1GHtKRWnzlcl1ffHOu67isDTxEaLQ4txgvJLKGY55L6Gb1p3mLphc9JZ1WmKJIzhCs53fiLQVUdp3oFNy3VpLqPF4FzJJ6ZsILRPZ+blpfybf59/68mcP12eVzCNxzjCflNElC5wRbRy09xX6vQmVYrXkUx4UQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lWoxvtR8uuM4TGD/+tc8u78p7wIOWut/6iFqrUU0v0=;
 b=JzJUkNfY+crA50iLLSinmGhzTTgmH4eaDSbOjQ7JHxz9LOEOUKFXUV5AMkeLecb1QHGtfr2LV4gX/Et/0BHf8rLH+VmebbhLEm4HFnoCVzdiWfkHyLIRul+gdnZk1ClVucDJcVJ2wJxqHXlqeBWNYM1SUZKy5g37FWlyG+eDYe4=
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 09:10:21 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::dc) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Thu,
 6 Feb 2025 09:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 09:10:20 +0000
Received: from [10.136.39.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 03:10:16 -0600
Message-ID: <e0774ea1-27ac-4aa1-9a96-5e27aa8328e6@amd.com>
Date: Thu, 6 Feb 2025 14:40:13 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: Peter Zijlstra <peterz@infradead.org>
CC: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Steve Wahl
	<steve.wahl@hpe.com>, Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	<srivatsa@csail.mit.edu>, Michael Kelley <mhklinux@outlook.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <20250205095506.GB7145@noisy.programming.kicks-ass.net>
 <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>
 <20250205101600.GC7145@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250205101600.GC7145@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c1b160-0b5f-4806-64a4-08dd468e152f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|32650700017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enAwYUhDakcyeGFBVit3cjUweVduYnpuSVd3c0EzNGd1Y09YTWU1UEEyd2RV?=
 =?utf-8?B?YVZPME52dVJid3lSWURSbWN3LzVlQjFlM2FlTWhLTitsTmdIZ0hzNUZxOU5k?=
 =?utf-8?B?eGN3MitBQzZ0TGljdVhCbURCTDlsQ0cvYnQyZkFYK1Z1UGZtRjZCMnFBcTBv?=
 =?utf-8?B?QnN4ODBMZkx4ZXpFNU5idis1WFNmdmMvd3JYWmtwU3JBeVh2QlJSejVqUWdp?=
 =?utf-8?B?dFNwNkVvMzVleDRlK2lwSHJzYUtVRVNoeis1d0ZTTW5WYXc0UnFIc2JjUzl6?=
 =?utf-8?B?Z3FFNU83VkVuTkRKblVRZmdsb1Vkd3kraVFkOWFmSUJpYXgrLzZGV2Y0Mm5R?=
 =?utf-8?B?dXYzZEVGUmRDamd1SW5SYytWWnNqODNXNE9vYlNwdU1KNDhSYk9UZ0svdzU1?=
 =?utf-8?B?eEZCM2F0c3ZnMXNVbEYyRW41Ymg4cFVySHJMb2oxSUVVRUkxamZDY1pmQTYr?=
 =?utf-8?B?c0VzQVl6ZndNYzk5YUNDRmcvaHR0OUNhbjM0NjZXSlJ2SU0ybkxxdkExSlgw?=
 =?utf-8?B?ZUgxWFd5U0hERDlhTjdxeW1ValNFZHM2OWI2Q040V0F3dkttdnNQNkc2TUxj?=
 =?utf-8?B?Q2xtZDU0bmZZcEhSWGx6NWNaeVZ4b3J4eVQ4NERPeE9OUW1EeUQrbTRkU0tM?=
 =?utf-8?B?dzVhdWJlV1JBcjB1YnAwVllwSVZlOXFveGRoNjZhSFJ4SHIzdVRSTlR2SWFv?=
 =?utf-8?B?QzhiWXpxc0IvMEZGdkNUY0xPbi9wU25SNkQ3ZlNmYytrblhkcVpUVXQyS1Ur?=
 =?utf-8?B?OGwrbmE2QlYrdmQ1a1M1UmtsVzF2Q3V0T3kva1QrRkg1YWRPSE03TncvU3Z2?=
 =?utf-8?B?aHZmVHU4OHVZOFdvV2FJdG9qRjlqczhmSUF1UFNVZlU5aWE4VEFNdkpSdXNF?=
 =?utf-8?B?cXBSelNLYkExTG43QzhrWHdVV2hqY29SSFJCR2YzWTkvR0hEeG14ZVdWVk9N?=
 =?utf-8?B?eHdDTUxjMEV1WE9uYVgvclZrMEFuMWx3T0VncERKM2srenBtNGdKbzdIWkZi?=
 =?utf-8?B?Rzd5S2cwWjdFcXpBK3RCMG9YY2dlS296QTJtaUx5aGlxdTI1czQ5U0gwZVIz?=
 =?utf-8?B?N0ZycE5rOUFEbFdya2N6eFBlbHVTOHhWRnd3WXArc2VEWWtDRjEvelBaRklZ?=
 =?utf-8?B?RlpDSmpQMWZTWm9FMWJveUZhbzdmY0xqNEkxcXMxNmNwWlA3UGRMeHVjWS9G?=
 =?utf-8?B?bk5LbEE3SGtiK3I1RitVWlFLYzRId2hKSVFwWGMwa2w1OVNXd1B3cGhmajVM?=
 =?utf-8?B?Ym1temxiUkRqQUFaS2dGaU5vbFo5anNFNE9JdG1jQXFEd3ZhRU1xR0RWZTVL?=
 =?utf-8?B?clNJQnNkbEZqR3l1Y3NObmVPdzNYYmNpZ0s5TDN1b2VZOHljOGtIaFVsYUxm?=
 =?utf-8?B?VlJ5cmZOZERpSFM3V1MrV1ZaM0pkUXhHTEp6OWgxVEEwZFRXR0JFU3pNM0lR?=
 =?utf-8?B?RnZjNGU5elM2dmFqKzFtSjZuYXkzTGVOVmRKZVpyVW5rd3hlUU5sV1BydUs3?=
 =?utf-8?B?YUlSdkptelkyZmdGeUs5MzhKQWo3bzlvZFl1N3VNVWZhY0dXUU9oUXVVclpu?=
 =?utf-8?B?WjV2TktDRzlHV2RNaWZ2TDZLZHVjRGJ6d0FHWHVLNEVldGx3ZDBoWVd0OWNh?=
 =?utf-8?B?UTlYT1JabjRLbUNSUnNJM3lOYnJoV1NVUHdkYzljVHdNRndsanFoSEtwTEND?=
 =?utf-8?B?clN0NEczdi95YWZzQlZyTlZUVkFhRDE5S3ArWVJRM01Bc0ZneElmTE5SMGJN?=
 =?utf-8?B?V01qaW1RUSs4RUNGd3RNOTNMNmUzT01kbWc0cnFMUUEwTVRZOWY2YjJPcWtU?=
 =?utf-8?B?RWZZVkZacFdQSEZucUR3S2RjVDZZY21GaDc2cER1ZW9aaEhaNEZlbzMxbHVQ?=
 =?utf-8?B?Y0daa1N2eTI2Qys5aEE1amp1VXZTTDR2R0Q0NGUxd1BaSWVyY1dmQVBabDAz?=
 =?utf-8?B?NmZsOVZZRHNqSXdSOVFzbDNxalJWSEZNS0RhVFkyMytSTXRGQmFsMnY1d0FK?=
 =?utf-8?Q?rzlb1AAUoMPr+0QUKTimV3xcVlcpuU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(32650700017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 09:10:20.9643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c1b160-0b5f-4806-64a4-08dd468e152f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991

Hello Peter,

On 2/5/2025 3:46 PM, Peter Zijlstra wrote:
> On Wed, Feb 05, 2025 at 03:43:54PM +0530, K Prateek Nayak wrote:
>> Hello Peter,
>>
>> Thank you for the background!
>>
>> On 2/5/2025 3:25 PM, Peter Zijlstra wrote:
>>> On Wed, Feb 05, 2025 at 03:18:24PM +0530, K Prateek Nayak wrote:
>>>
>>>> Have there been any reports on an x86 system / VM where
>>>> topology_span_sane() was tripped?
>>>
>>> At the very least Intel SNC 'feature' tripped it at some point. They
>>> figured it made sense to have the LLC span two nodes.

I'm 99% sure that this might have been the topology_sane() check on
the x86 side and not the topology_span_sane() check in
kernel/sched/topology.c

I believe one of the original changes that did the plumbing for SNC was
commit 2c88d45edbb8 ("x86, sched: Treat Intel SNC topology as default,
COD as exception") from Alison where they mentions that they saw the
following splat when running with SNC:

     sched: CPU #3's llc-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.

This comes from the topology_sane() check in arch/x86/boot/smpboot.c
and match_llc() on x86 side was modified to work around that.

>>>
>>> But I think there were some really dodgy VMs too.

For VMs too, it is easy to trip topology_sane() check on x86 side. With
QEMU, I can run:

     qemu-system-x86_64 -enable-kvm -cpu host \
     -smp cpus=32,sockets=2,cores=8,threads=2 \
     ...
     -numa node,cpus=0-7,cpus=16-23,memdev=m0,nodeid=0 \
     -numa node,cpus=8-15,cpus=24-31,memdev=m1,nodeid=1 \
     ...

and I get:

     sched: CPU #8's llc-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.

This is because consecutive CPUs (0-1,2-3,...) are SMT siblings and
CPUs 0-15 are on the same socket as a result of how QEMU presents
MADT to the guest but then I go ahead and mess things up by saying
CPUs 0-7,16-23 are on one NUMA node, and the rest are on the other.

I still haven't managed to trip topology_span_sane() tho.

>>>
>>> But yeah, its not been often. But basically dodgy BIOS/VM data can mess
>>> up things badly enough for it to trip.
>>
>> Has it ever happened without tripping the topology_sane() check first
>> on the x86 side?

What topology_span_sane() does is, it iterates over all the CPUs at a
given topology level and makes sure that the cpumask for a CPU at
that domain is same as the cpumask of every other CPU set on that mask
for that topology level.

If two CPUs are set on a mask, they should have the same mask. If CPUs
are not set on each other's mask, the masks should be disjoint.

On x86, the way set_cpu_sibling_map() works, CPUs are set on each other's
shared masks iff match_*() returns true:

o For SMT, this means:

   - If X86_FEATURE_TOPOEXT is set:
     - pkg_id must match.
     - die_id must match.
     - amd_node_id must match.
     - llc_id must match.
     - Either core_id or cu_id must match. (*)
     - NUMA nodes must match.

   - If !X86_FEATURE_TOPOEXT:
     - pkg_id must match.
     - die_id must match.
     - core_id must match.
     - NUMA nodes must match.

o For CLUSTER this means:

   - If l2c_id is not populated (== BAD_APICID)
     - Same conditions as SMT.

   - If l2c_id is populated (!= BAD_APICID)
     - l2c_id must match.
     - NUMA nodes must match.

o For MC it means:

   - llc_id must be populated (!= BAD_APICID) and must match.
   - If INTEL_SNC: pkg_id must match.
   - If !INTEL_SNC: NUMA nodes must match.

o For PKG domain:
   
   - Inserted only if !x86_has_numa_in_package.
   - CPUs should be in same NUMA node.

All in all, other that the one (*) decision point, everything else has
to strictly match for CPUs to be set in each other's CPU mask. And if
they match with one CPU, they should match will all other CPUs in mask
and it they mismatch with one, they should mismatch with all leading
to link_mask() never being called.

This is why I think that the topology_span_sane() check is redundant
when the x86 bits have already ensured masks cannot overlap in all
cases except for potentially in the (*) case.

So circling back to my original question around "SDTL_ARCH_VERIFIED",
would folks be okay to an early bailout from topology_span_sane() on:

     if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
     	return;

and more importantly, do folks care enough about topology_span_sane()
to have it run on other architectures and not just have it guarded
behind just "sched_debug()" which starts off as false by default?

(Sorry for the long answer explaining my thought process.)

> 
> That I can't remember, sorry :/

-- 
Thanks and Regards,
Prateek


