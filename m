Return-Path: <stable+bounces-112280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CEDA284E2
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 08:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA1E1887FFE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 07:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB0228387;
	Wed,  5 Feb 2025 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BhLp7zQh"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122B21C16F;
	Wed,  5 Feb 2025 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738740054; cv=fail; b=QR+SFBPlKnYlmVtFuAyfpChzGMKP12blvW17wwIMOW5X+iiwVzhCuDsjc7SEznyXdZoDbxy/49ZpBOC2ngOChqpfgEHQoywvQrRi1f0R3k3Mn+guabSlceLzMgHXsMNBW8dnQvuQoxPba94CRIs6EWhQrwlHKXvVl1QcqFV1wio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738740054; c=relaxed/simple;
	bh=ZSRnPRC7WN3x9+Sx+YLrN17Bt6gVXHmt1Kl3bqsj9jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ajFvWXB6SOojv3GxYc+wRoX75nvZTmQGkWv5xYwBNnF274dGZ3atnIPmjE+yfgMuz1kk+xU6FTCz3gn+tJnRqvCXixx/zd0iLulWuKIVRqGk01gC5/L+FGSxahKUETyDLvCk7cXL/s7Jao1fBV2gBqcVYhNZ1wsppqg8lihMIZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BhLp7zQh; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbgYwo6gjbe/2hKGH3qhSskXNu3BMwr5NQuUy5lO4ioaFXuMCIaK+1C2OivCXj5I3MBcpEeCIfm3VDBg3vNZMamht+2Kb39KZ1PBuW19tRHiLYum2Q235OBGnzQoDtC5JVH1hgkr1pJtSW6+l2bWO0y7V65yKyiDWccbLryyr7u33wb6hr/ng0xRumwiOnL5Dt4PMylfrpQRZZ+IsUsn79fTAHIxTUsLYMbYploKKZ8neP3kxNiq2vWVU3k8k6Tk94Xo/WFrhLPusFvLPqwIQuxaAs0mObBOZiT25ziBDM9eg5ORGfd+WhGIAqfrgbpAaieB18Rh0vJlawLtwcE/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2iI9Phpr+xd5rjNGvVWgNzBD/pzji8oftqdBNF6Bso=;
 b=oiffP9U2UilcVukyCS0hMCez8bvj6tSGPXY9UsS5nbuhCmS0rALw/cf9tRWGiluHRw0QnXBRAyihlY+4gUtvWMBTxIa4r7Ky07udNINI6isClM8WrGaWXtp491HICfr+ueXP4mnbqBOOxigQMUn4wupa/nbGGOH4o0pLvwCT3DTM8SVazVaTUdk4bVwxsSvntv0p/o13n3d/wYQQ+AmRiSeF8mWwHj7dlIIRh3UhlfIBLT6FKbPUxNMONuoo5xDMO710FOHXd+Vklm6x0JXGhD/+3QbacEbft7ohr9gPyUQ7dPN3vdiOGTmvPhwXzMgrSm2dvmwtqpSXl/yp058vGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2iI9Phpr+xd5rjNGvVWgNzBD/pzji8oftqdBNF6Bso=;
 b=BhLp7zQhFq7dUm1RX7pQ7m5c6CCy31yJsiDvb7WDW3HD4jnn451dyPO0bFchX5ph+Ax7kvUa++Su09QBKNUQuSK9+chsL/NFZraGe6CmmF4jtd769GIBDZQhZTkAWQTNEo+1eTUYKX/w5C24B25XI2L36pTx3odrE10HNEOb3Ag=
Received: from MN2PR20CA0009.namprd20.prod.outlook.com (2603:10b6:208:e8::22)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:20:48 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:e8:cafe::d9) by MN2PR20CA0009.outlook.office365.com
 (2603:10b6:208:e8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 5 Feb 2025 07:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.2 via Frontend Transport; Wed, 5 Feb 2025 07:20:47 +0000
Received: from [10.136.39.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 01:20:42 -0600
Message-ID: <bf469858-dedf-490a-abf2-b066aee6077e@amd.com>
Date: Wed, 5 Feb 2025 12:50:40 +0530
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f46608f-4195-4238-9d5f-08dd45b59ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|32650700017|921020|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzRGOUVVTUx1SnRyYXFYQTZaQkFKTnhhZkRTQzZHTkNpVmZpTGFIWnIvNUl5?=
 =?utf-8?B?ZFljbGt0a2tnUkFhZ0RreE03SDBUUDZDOEkvN25jVlE2Wmovc0JCU2ZLblBC?=
 =?utf-8?B?VE1PTXNtRHA5UStUWUlxUDVSdGVIaFY0R3F0eFNvbHFIZGkrQitMZjBkWUs2?=
 =?utf-8?B?bERQVjRBMU4rcXZkSnk4ajlucFl4b1VJZ3hUSE5uMkY3MDdzUk9pbEFrdEFQ?=
 =?utf-8?B?NjZ3eFR0QXFkZnNzQjZkd0tmRjhKbUdXZ28xTm9BZlJHbWoxdjJqRC9iSHZv?=
 =?utf-8?B?WlY5YkUvQjNNVXVoc09iUkFpZEErVDNBUmJxVzF4aHNBbzRGdGdhc20rcUdC?=
 =?utf-8?B?dXZpWkhZVFpvUVBYRWgvdTlzOVE1Q0JmTlRpelY2c0dyRTk0UkM4eGtBYVBW?=
 =?utf-8?B?ZE1kb2Q5NldxaGl0dk5qK2NjMkUvd0w4N3J4QjViRmptRDE3OXR1UU9hOVp0?=
 =?utf-8?B?SW9hMHhzQ0VSbDFpUWtNTHg5bGVuWEVvS3J6d0hHd1plRnB4TGdENzlLRzNB?=
 =?utf-8?B?ai9OWWR0bk5qSHpNb0VPNTc4V21lMk04SFRRUElRZ3JLQTg3bGEwV1VjeDE4?=
 =?utf-8?B?eWJ3V29NVm1kdlIwWEdsRDJ0cVFPNXRwQ1JqTTJYSmw4TEVyM0Q2YVpPdlRx?=
 =?utf-8?B?UjFvMWhQeEtXVExlYUtzSTROVUo3MlQ5V1lJWkNzajNOdU1DQWVBVnZRK2ky?=
 =?utf-8?B?eHBCbmt5azY1VFVBbi9DUWp3SDdIK3NCa05reDI1eFY2VmtDN2JHWUNzdjVN?=
 =?utf-8?B?VmMvdUllalRLYnpEbWNqVTl2bHdSckdpL3p0MjFpaDMyM1VtVE5uSlRnWGl0?=
 =?utf-8?B?d0NlTnEzQVV0VHN2UUx2c3RtRTA5UTIyRVV1dXo4ZTRTUEZQYnhJMnZFQ3JC?=
 =?utf-8?B?TTVSeEpZcGZXRnc3em1mOTNGeXFLQVpMK0ljdW1YWmRoZXVEYVRwdmZnZTUr?=
 =?utf-8?B?bWlSNVVsRGllSC9Yd095a0wxS0lTY29pRTZJZm42clRYQi9xN1Rpdm1EUGhI?=
 =?utf-8?B?bDh3cjZzaXhoTldFVGl5bEthZHJkZnM3WTlyWWpqREl3cHZOVUx0TWppRG1O?=
 =?utf-8?B?WDBKZ0ZqZTlqLzFvY1drcjR1VWhMNFRhUFlpZW0rNVMrci8zcEtKcTBtWVlt?=
 =?utf-8?B?dTdNVmdWYjhYOEdwd2I5UzZCNm9FZXRNUzcyMTJCQ013VXF3WHN3Y2J1bCs3?=
 =?utf-8?B?azF6b2tqZmRlelZDdnhKMTNIaHRKTnVpUkNQWWVMM2JIdFU5N0E1YXVqK2N4?=
 =?utf-8?B?YkxVRlVoT3lmZERHS3laS2dKR0VteUdqeTdJQXgvRGFMR3NPaGpCSWx6amg0?=
 =?utf-8?B?US9ZK2JTYzhDZWIxUWEwNWdQUDBzSFFrVFh1NmxlRW9KSjJXTitESHNLMVk0?=
 =?utf-8?B?RFRLYzkxQitSTUdReW5DdXd4ZUowUGhyRUJuTENHZ1pKaG9yWUVyc3FiNzIy?=
 =?utf-8?B?ODA0T2dRVDg4aTJzYWtRby9KdnJWQmVBTHJqMEI0bndBRzRqMmJTNktuRTFZ?=
 =?utf-8?B?YWpxWWI4SjBzMVBtb3haWjhtbm85NVRUNWpMR1FseVVqOTdwd2Q0Y01GbmFa?=
 =?utf-8?B?RHBTbHdWUG5HK0psbko2VURJcitBVEFHNVBBOXgzWFUwUHZuQXBxNmxzZTRw?=
 =?utf-8?B?WVhaY1ZDS1UyK2ltcmFtTWtyc3lidWpQWmN0Qmo1YW5OZVRqZmhnTmxSbExj?=
 =?utf-8?B?bHJoa1ZaandxUUJrem9obkZKd0huSzFpT0ptTEFBK21vTUx4OUhaaU9tRUpw?=
 =?utf-8?B?UFVFbWQ1aUFqOTZXeHFlNGpyckN0MnNBMEdQa1JEZFU1UEZ0aENXQndNTlNN?=
 =?utf-8?B?YVhKS1lETTdOeWlQWEc5VG9ObzZGRWtpenJoRElGcjVtM1FKd1BwZjRjeGtw?=
 =?utf-8?B?ZVM0RURUVDBDam5OTWc1T1ZJZ3ovQlU0QUtIUDU0ZExsbEdueVhrb2ZhVlls?=
 =?utf-8?B?SXFUblZWU0tuKzVSaEdIaFJ5c0NOT1ZyUXNnT3h0V3kxNTFCLy9tQ3U4TWp6?=
 =?utf-8?B?OVFwSFlFRzdrS3VKM0I2NHV3MytXcXJWSXE4ZjVVazFuS3VBQm5veXRma1Zo?=
 =?utf-8?Q?FSnFo8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(32650700017)(921020)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:20:47.4997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f46608f-4195-4238-9d5f-08dd45b59ca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711

Hello Naman,

On 2/3/2025 5:17 PM, Naman Jain wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> On a x86 system under test with 1780 CPUs, topology_span_sane() takes
> around 8 seconds cumulatively for all the iterations. It is an expensive
> operation which does the sanity of non-NUMA topology masks.
> 
> CPU topology is not something which changes very frequently hence make
> this check optional for the systems where the topology is trusted and
> need faster bootup.
> 
> Restrict this to sched_verbose kernel cmdline option so that this penalty
> can be avoided for the systems who want to avoid it.
> 
> Cc: stable@vger.kernel.org
> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
> 
> Changes since v2:
> https://lore.kernel.org/all/1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com/
> 	- Use sched_debug() instead of using sched_debug_verbose
> 	  variable directly (addressing Prateek's comment)
> 
> Changes since v1:
> https://lore.kernel.org/all/1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com/
> 	- Use kernel cmdline param instead of compile time flag.
> 
> Adding a link to the other patch which is under review.
> https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/
> Above patch tries to optimize the topology sanity check, whereas this
> patch makes it optional. We believe both patches can coexist, as even
> with optimization, there will still be some performance overhead for
> this check. > ---
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

s/operatin/operation/

> +	if (!sched_debug()) {
> +		pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",

This could be broken down as follows:

		pr_info_once("%s: Skipping topology span sanity check."
			     " Use `sched_verbose` boot parameter to enable it.\n",
			     __func__);

Running:

     grep -r -A 5 "pr_info(.*[^;,]$" kernel/

gives similar usage across kernel/*. Apart from those nits, feel
free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com> # x86

if the future version does not change much.

-- 
Thanks and Regards,
Prateek

> +			     __func__);
> +		return true;
> +	}
> +
>   	/* NUMA levels are allowed to overlap */
>   	if (tl->flags & SDTL_OVERLAP)
>   		return true;
> 
> base-commit: 00f3246adeeacbda0bd0b303604e46eb59c32e6e



