Return-Path: <stable+bounces-112288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F55A286EF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 10:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF2C7A1FB5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F1122A4E8;
	Wed,  5 Feb 2025 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TGy0IHkM"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F12288CA;
	Wed,  5 Feb 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748917; cv=fail; b=H7jpSpoOVoieeEEM04XiVBQwi8WxB3DMakpb1m8PrFhFRhkMaVI0V9/QagDNCkfyg21BIPufsGy3IHSwIlDJuMjsfW61+LHPjYBSOf4Qrgs9abYv/3d4MUyb/9KsIPaJhNQCk2yUrl24xamaBi3mz+WH9EJ6MTNrBrbZivbjE28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748917; c=relaxed/simple;
	bh=9+K7gXHWpe0WXEwR90hSxSTHXgx9JDkqtrCw9b3W73A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JDYQKWIMhfGavEk5iG9hd8+Pr3cPc1hyw4YcKp9AlcZgrxEdL/sdfaqI3pH3/WA5Ppxu00FO3XZEf9nDESt4GTvLTrffg3N+NCXVUrDbws8/8O4xvMWFMjJzlroxou41xsDGDjjOoOx7hb1bSrCM4Lz26lBXOTnOWh1pqhudFnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TGy0IHkM; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3+/B1O8lyHAYqRhiDEt3ETPOLgXSDr6LYbWmOZEkEwdSaj3TaTV+buF/JGVnol5+hEBka7XluRR2eFsnr1TeeeIVJFlAHNE7spQv376F4rwH/TwGVumZkOt03yLbnF1Z+NZEHgCv6b6cUkqCdVUiZ9STNMlcZeNv0jdoTKqHXWoOuu7MXjz2B2dqb1lcMypQOFHuRwecJBem7+RrQ+5KlFqhn/gwwQNK8kSs9+lZHsQHd83t0qkCZPmjaoMesVtlFWJk+DucpBbxjGUOEELD+IXoSJX191T8CEgPP/zo+ViKLMZbBtplFYeJdiQq62yI/gy8Jslc/pYDnN+9ogRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+uFo5SRl3siEkCEcu7QwMDtg06GPecIJNglgqoo4bA=;
 b=DR7WCo2DyGnuxpgV6Xk1ar2C2Fi9lRR2I7uaT1vrgJ+vNd96uYf/VpurIalLPyTbaxuVeiITLl0NAJ6LgeBNHuJtK2vBcuIUYV5XJyC9snoot3IWRxTYaSTCsGEWibutTtbUx4zyYNzWq+bSJMQTXj3naJizZ0Xfdm2CZ4EInmgpTahh88Wr8DjaMK6/96nz36IFkH8jxwqKkojGzWY36wb0jvLMAHpKgJLu4HZb21sdaMS+HMv1OYyte9OnTGy/I4kmaazpXZs4ah/OT+3qjE9Xa/gYdXwr3D8vyAE/4qGs0kCNDsu8JWo04PVRRv5daqMAjlfsWVjwW5M6J+lueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+uFo5SRl3siEkCEcu7QwMDtg06GPecIJNglgqoo4bA=;
 b=TGy0IHkM0xumuvVHqkkGKOHihSE8VeBbD6D2gHli9jLosEqGEPFKBE8ouHBquPRcumjOUk7Emkff5NO6m941+9nR7FgqNk43584OsIwDKXd32dhyMsuc/8Pmifo4nw0NN0A0LhFi2OtlQ5Qo0X09jGBqqxJ5V1dU0hRSMAAajE0=
Received: from PH7PR17CA0043.namprd17.prod.outlook.com (2603:10b6:510:323::9)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 09:48:31 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::b) by PH7PR17CA0043.outlook.office365.com
 (2603:10b6:510:323::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 09:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 09:48:31 +0000
Received: from [10.136.39.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 03:48:27 -0600
Message-ID: <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
Date: Wed, 5 Feb 2025 15:18:24 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>
CC: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Steve Wahl
	<steve.wahl@hpe.com>, Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	<srivatsa@csail.mit.edu>, Michael Kelley <mhklinux@outlook.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250203114738.3109-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b3698b-606f-415d-b01f-08dd45ca401b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|32650700017|82310400026|7416014|1800799024|376014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjROVXJtYXRkSk5kTTUxNjNkQUU4N2hUWWorUTM3RlhVZUhnL1FtNERTQ3Jz?=
 =?utf-8?B?K2F2ZHZrc2JIY3VHdkpoWm1JTW4xNHBmam40b3BJRVJWQWd4RjY1WDhubjRJ?=
 =?utf-8?B?Z1QvTUYzUk5yUmx0NGEvZXFzOWFwWGdqazIxNnFheVVmRk84T0RUN3NQUDY2?=
 =?utf-8?B?OEI5UHNZWG9GaDFlRXU5RXVhVFErNVhtYTU3Zk9sdDRHbitHZE1yaDZ1bDc1?=
 =?utf-8?B?MjRLMWFwUjNrRHZHLzRjTHE5U1hiajhRS1VqZUIwVjNiZWRlQnRIZEhqK3Ev?=
 =?utf-8?B?RE9JSzdBSWRTWER2WG95MG54THdmZ0NtdmtucVFvS0xyTE5yZjZBQTF2MVM5?=
 =?utf-8?B?Y2dZS0l6TnFWZGdCOEJWSUZEczRNdnRjK3BsUnArUVNFeUlGNFlvdG52aWRq?=
 =?utf-8?B?bmlCVk11SjljdjhYdmJsVVg4bTZTUy9rRWJSTjlISG5UUktyZnhsRWI5TTgy?=
 =?utf-8?B?dFVJVW9neUEwNU1EdEFIelVMdktJeTlUSzh6RTlBWE1DR25EYWp5Z0gzdXRN?=
 =?utf-8?B?THBPNjhSQUU1UnptejVVWlQ0Qyt3SjNzdHd2c0Q3L0pKa0hLdkpBVjFsS0c4?=
 =?utf-8?B?cytmQmo4TmhIQnh0R1I0VVl3L0t4SE1wUUN2ZlJBUVYzckQ5c3hueE1GVTE0?=
 =?utf-8?B?QXRYVUQvbmwvKzcrM0NFVFlGa3NBY0dxS0xpakJtQ08wY1hmMWI3cTdhOTNS?=
 =?utf-8?B?RzhpM0tPSkJmREhKdVZXT0J2c1lUaVNwazRhd09JbFdGTUc1YmNMaGZTQVJi?=
 =?utf-8?B?OWoxeHR0WXFTNVVQWmZWUXZFdTE1bTAyWEE3SEtKd3p5aHJxOGZkMUtJbXRB?=
 =?utf-8?B?Qi9vWlFIcDRwMGorb2d0MEt0OXBnSEZxVHUrSVBGWlBBd2htMUVMSFhPMjJ5?=
 =?utf-8?B?b21YSnVtSnN6SnFHZHRKbDJTbWJQTFRzbmJxdVg0T05VSzhseEsyT2pRTHdh?=
 =?utf-8?B?WElvZjJYZXZzaHJCU0M4WVZkcExoWDFyS2VENkNpa3VMVFBmNmEwSmFIT213?=
 =?utf-8?B?ZmQwL3hsYXVERUVReUxpbUFpVU9uMFMybmRacVdKV3hqNFc5NEhkd0g5bXpG?=
 =?utf-8?B?YUxsU3NuUVpBbnlzVEd2OWphSUxkejJBSk8zaVloQmQ1ZUZtNWRqWmxVazNW?=
 =?utf-8?B?d2t0NWR3ZDhoMXhncHVjQjY1OUQwbGQzbHZuTTROUkZSTUhxSnp0REVkSUxY?=
 =?utf-8?B?cG16ZTFkZ1hDc0R3WWtEZEJ5RXFLd0FlSlpyQ1NseFhQMWpKd3dGbnZNZmcy?=
 =?utf-8?B?ZjErUGRDY3VFdmZVS1Y5cFM0cm5WTThXVnlYTWhzVi83S0dtN0paVU1xVThn?=
 =?utf-8?B?N1lNZ1crZkRTT1dnWVdpK3JhYndSV2psVHhvOHBNWXlBa3ErSnpmQXRBMmZw?=
 =?utf-8?B?SlhHYTc3RmM3eVd4bk9RWS9Ra1hwbm5ZVCswM2ZWRmFnd3VXSGJJWDJWMmVL?=
 =?utf-8?B?UE9LZWF0MFRaanJJcDNIQ3ZpMHFXM2JUOGluSXQ0ZEZjeGNRNUNUelcwZVJ3?=
 =?utf-8?B?ZGZGQnR4aTBsaDZiRnpUMHU0VjhHbXBPYTJPT3BBc3E1Q1dpZWFhYU9yZ2FS?=
 =?utf-8?B?UEFkbkx3T1FmZzlTazkrejdJd1BPRi9VdU56aVFsSXJFYzBrcEQ3VVM2bW0y?=
 =?utf-8?B?bUJMVUVQdk0vSlpPSi9iNXEzcERrWGlUbmJjTVNhNy9hR2srQ0kzU3A3MXA5?=
 =?utf-8?B?OWxMKy9YTk8zU0NPeTVmRFJqSmRSM1pqZ1JnNWdQbWxNaGtZRHJXc1hTWUox?=
 =?utf-8?B?cVNmTUI0alp2cVlJNzdyQjdlbk9UejlocHhjd1JKalJjQU40eEh6N090R2Ja?=
 =?utf-8?B?TFltdEdmeDlSRDdDK1ZxaUtxSzg2UHF2c1UrMCtXSnlBcURUUmp5NklNUUhG?=
 =?utf-8?B?RHovZVV4U05DeHVBeVZ4MFdsRk8vR0lIR2ZyK05KcWM3ZmJPQzRNUUpPQWdF?=
 =?utf-8?B?djRDWHhCb1dldEJBMFBTNS9HU0hiVFNDeklJWUluYms5enlCbVlKeXIzSjlV?=
 =?utf-8?B?dFJWa2JlV3o2OUZVTHZvK2JrUnVpZDBmZmNwaDUrakFGVHNHRzkxMWFraldi?=
 =?utf-8?Q?n9/fJk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(32650700017)(82310400026)(7416014)(1800799024)(376014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 09:48:31.6963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b3698b-606f-415d-b01f-08dd45ca401b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061

Hello all,

On 2/3/2025 5:17 PM, Naman Jain wrote:
> [..snip..]
> 
> Adding a link to the other patch which is under review.
> https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/
> Above patch tries to optimize the topology sanity check, whereas this
> patch makes it optional. We believe both patches can coexist, as even
> with optimization, there will still be some performance overhead for
> this check.

I would like to discuss this parallelly here. Going back to the original
problem highlighted in [1], the topology_span_sane() came to be as a
result of how drivers/base/arch_topology.c computed the
cpu_coregroup_mask().

[1] https://lore.kernel.org/all/1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com/

Originally described problematic topology is as follows:

     **************************
     NUMA:      	     0-2,  3-7
     core_siblings:   0-3,  4-7
     **************************

with the problematic bit in the handling being:

     const struct cpumask *cpu_coregroup_mask(int cpu)
     {
             const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));

             ...

             if (last_level_cache_is_valid(cpu)) {
                     /* If the llc_sibling is subset of node return llc_sibling */
                     if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
                             core_mask = &cpu_topology[cpu].llc_sibling;

                     /* else the core_mask remains cpumask_of_node() */
             }

             ...

             return core_mask;
     }

For CPU3, the llc_sibling 0-3 is not a subset of node mask 3-7, and the
fallback is to use 3-7. For CPUs 4-7, the llc_sibling 4-7 is a subset of
the node mask 3-7 and the coremask is returned a 4-7.

In case of x86 (and perhaps other arch too) the arch/x86 bits ensure
that this inconsistency never happens for !NUMA domains using the
topology IDs. If a set of IDs match between two CPUs, the CPUs are set
in each other's per-CPU topology mask (see link_mask() usage and
match_*() functions in arch/x86/kernel/smpboot.c)

If the set of IDs match with one CPU, it should match with all other
CPUs set in the cpumask for a given topology level. If it doesn't match
with one, it will not match with any other CPUs in the cpumask either.
The cpumasks of two CPUs can either be equal or disjoint at any given
level. Steve's optimization reverses this to check if the the cpumask
of set of CPUs match.

Have there been any reports on an x86 system / VM where
topology_span_sane() was tripped? Looking at the implementation it
does not seem possible (at least to my eyes) with one exception of
AMD Fam 0x15 processors which set "cu_id" and match_smt() will look at
cu_id if the core_id doesn't match between 2 CPUs. It may so happen
that core IDs may match with one set of CPUs and cu_id may match with
another set of CPUs if the information from CPUID is faulty.

What I'm getting to is that the arch specific topology parsing code
can set a "SDTL_ARCH_VERIFIED" flag indicating that the arch specific
bits have verified that the cpumasks are either equal or disjoint and
since sched_debug() is "false" by default, topology_span_sane() can
bail out if:

	if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
		return;

In case arch specific parsing was wrong, "sched_verbose" can always
be used to double check the topology and for the arch that require
this sanity check, Steve's optimized version of
topology_span_sane() can be run to be sure of the sanity.

All this justification is in case folks want to keep
topology_span_sane() around but if no one cares, Naman and Saurabh's
approach works as intended.

-- 
Thanks and Regards,
Prateek

> 
> ---
>   kernel/sched/topology.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c49aea8c1025..b030c1a2121f 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2359,6 +2359,13 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>   {
>   	int i = cpu + 1;
>   
> +	/* Skip the topology sanity check for non-debug, as it is a time-consuming operatin */
> +	if (!sched_debug()) {
> +		pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",
> +			     __func__);
> +		return true;
> +	}
> +
>   	/* NUMA levels are allowed to overlap */
>   	if (tl->flags & SDTL_OVERLAP)
>   		return true;
> 
> base-commit: 00f3246adeeacbda0bd0b303604e46eb59c32e6e


