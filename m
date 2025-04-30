Return-Path: <stable+bounces-139123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688E6AA469F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 11:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE7A4E2327
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D302222AB;
	Wed, 30 Apr 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VtrotqZx"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659032222DE;
	Wed, 30 Apr 2025 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004397; cv=fail; b=UpcicR1w+tm5TvI5VogGEivuBTmm53XxbhFYkCm1EwC4hyGXF1AKwHUl7yyYI26/Kx32rdIlngXYrMcxEX7OQ85XI48Xi6DUSFdE8iMMfD53RsG+jL/paW6xVEqHxVG71zQiJmFdqLcnwhDtYMGM3EB72jnQ1vSiv7ijCvel5R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004397; c=relaxed/simple;
	bh=OmvDgsNtUV3yWzcXlPfpBBv0bS4q9+orv4WRnFJ4cy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LlEIf4lOUv1lKlkrL0Q91QDHXUbbhZKNi+viU8nzoqD9C1o3yAO9O3D6py/efjZ1A31QqnqGdrxBWMm0DjTiTPFA7BluXj9mcfOdi2yTMmJUP1/1L98HGH6ZfAGKScXUJ/eyYzMvxijdOY3wUWtXDxtKn1mM3HrZoS/4tuaa8vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VtrotqZx; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsgDEVLaD5YbeUuU9XqiEpxYEl0r+HK/eipqfuTmpRBBrRDFIMqA6DNzS7Fu6p3NIgSn+GmDd7xsz2Rp9rUifpfaXNCujG5IuPg27enxwASIdWv2vyCSNxEnDfKGNgMI+yI+FKNUIlXeILzpfSBpzxDE/wqGvia4uwrd6e8zpVvN4U0ZXfSfEKL3fZ5PVASgqKFZS4QN/+v3YRMpoE7bwYL/g72IBsNdzDiFoAt36ezaREeA6poKec110fjkYiVt9nHmzBJFpj4E2MVPxXeaxP5k4mACUmdhQxxFcqa3uXwPgSzsMlWZfhnWYXbKOlx30/LEmSZRWhrqgvvxX+GWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+3R0AS6aEcD4p4txMhpl01/HgzGBPgIsEljoCH11SI=;
 b=gkeIvi9Ui1HRU7biJIQxBcABpT+5AvuYtKHEmYRqIww09uHm2z7XeG3CQhpS+pPps18uEwwApKh+Z7qVMnxil++tIxyUhJGT+2rfxeZ70uVBs2QdTxcI+yD7XErlKtH94kFScwkxGzl4Njqgyb7jOmTEnxYfCbjlFPKb7JXH/liNMU9NLCW3RhMEF9qYvB/1IpICe/m0vpeYoEqbe+6kidnMOM1MXYoKwofqpP3MyVUJrCQ43PJ90bllWHM4Y8d6A6WaaBQvGv5qcl/02ogdaw6ssv/dqwuP3aTnm1UhjOuwdRH57UGX7+5/n44EjkSuih/uuzTySUmA1V8yNqEmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ateme.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+3R0AS6aEcD4p4txMhpl01/HgzGBPgIsEljoCH11SI=;
 b=VtrotqZxhDKDff8hZirLRsJVHsD4DL7OE3UULyqFExBcHOVJJ7WyEGwxbr0dp7E39liDxIiORNzeGB0sxVDHogwcPSBI7aeVf8evrwFIwDxYQax6b8i7Uu1aYCo4YceRi14putp8sHLmiZIOw1u+Hx4ACOS8u/RVlvBLsbOhUQM=
Received: from BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::11)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 09:13:08 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::f0) by BY1P220CA0023.outlook.office365.com
 (2603:10b6:a03:5c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 09:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 09:13:08 +0000
Received: from [10.85.37.104] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 04:13:03 -0500
Message-ID: <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
Date: Wed, 30 Apr 2025 14:43:00 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPC drop down on AMD epyc 7702P
To: Jean-Baptiste Roquefere <jb.roquefere@ateme.com>, Peter Zijlstra
	<peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Valentin
 Schneider" <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com>
 <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4f5435-dda3-496e-f97d-08dd87c73915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTJMc2YwNGJGL3ZWbFNIUGdNNEc5d1EyTzYwTzdybHJNbnNkNGRxK3VSNEVj?=
 =?utf-8?B?NDNRSVh2WlN4VFpyODdnbEFTVXRscGZOSjNCRDhSZDRQUWluaFE4L3BCUUlM?=
 =?utf-8?B?V1RqUXdQMGV3bmExTEZsLzRKU3NxY2MrS240Sjg0Mm1kQUsvdkhNdTQvVElO?=
 =?utf-8?B?azhFSTRGMTFEWGEwMFJGWkFZb3d5NC9ITUhMd1VqdVUwdTJrRDY4cXdPelRs?=
 =?utf-8?B?eldhN045ZEhHM2N4V3c1M1lYT1hhazFFcERZNXF6aC9LK1VrZVJQendTVEh0?=
 =?utf-8?B?eUt2TExMbzN6bDdMRWRyR3h4NWFyVWlBTFBGZGxlMlhHZFZLUlI4eFlrV1JP?=
 =?utf-8?B?TVdGdlFCZHdTZTc2dnBWSzZTTDE3SVc4OG80SUtHK1N1cFNobFBJTTZpdFNP?=
 =?utf-8?B?dTJTZTVLaC9oMFRGdzRVZSswUTZSRjNTamhkVTJtZUc5OGUrdFNsOWJra2tM?=
 =?utf-8?B?TnNoZjlEYUhIbDBvV2xyTWZSaFp0azJJTm9oY1FYN3liMllldmJQZzhyam5r?=
 =?utf-8?B?eFRXazRSa0xZYVpsbk9MU09jM1ZseERhKzFTWmVCN0lIbFpOWkF0VE1ETGRL?=
 =?utf-8?B?cUM5c3AyeU5rMVNaYThta29kLzlvUTkvOEQ0cXVnOHZQa0RERmJaMmJUc20v?=
 =?utf-8?B?K2xMODRLbWxaNEdrU09pYnVhT0g5bDBsQUZQVkNHZlBSQjdtUlVDcStmL08v?=
 =?utf-8?B?NmpSeGZVaExzdDQvYWM1TlJhUTBEOCtnYWVxK2lOdktrNU9lNzRiVHEvVSsz?=
 =?utf-8?B?cStNMTlPd1A5OTFRZDRqZVloVGd1S3U5bGxGR29KRUIvdXZDQVpZdTJyQ21B?=
 =?utf-8?B?SFpJWEpUaHI5TWRyZjZEODduQUtpMFQrU3JIbURnZkg1SVFVNHdOWFZXTXlq?=
 =?utf-8?B?NGZLRk9nVFJ0bWhMR3RrRjRnM2YwNHQ2TUMrWmNYclpUZnNidS94S0RIRXZO?=
 =?utf-8?B?T2p6VmZwNE5UWEd5RS9seTdxK1N4aFluWlBOK0QyNnEvdlpXb2FMdjFsSzlk?=
 =?utf-8?B?M2t2dXhGT1U1YjM2N2RlTis2Rm42Ty9OR2lQaG9YbkV5cnpSSzdJaXdPd0pP?=
 =?utf-8?B?d3BvYkdXdm1wdkxSSktQMW8wa3hJaWRIUDRHVTh3YytBRDU2a25oNVp0N0Jn?=
 =?utf-8?B?a2ZUV2ROMkdmZ1VwelRyUVdnWFBycENCTnJGcmRyRTRoTkorYy94TXUwSFpH?=
 =?utf-8?B?eTZXOXRSU0RxT0NYM0kvUUcxd1p1ZiszVGVSN2FzQVIrd2lnQ2tPWTF1UC9F?=
 =?utf-8?B?MGRMNUNsaEYyWGhJVkJUS2JIUllCTEZ5dFJ2M1lOSk1HZ0d3ZmVOQjhuVXAx?=
 =?utf-8?B?WlM0bmRHZnRLVXZPdFZ5RWpCTFN0eGM2VGl4b1JwZm9SbzljcmVXRXk5a0J6?=
 =?utf-8?B?aGc1d0VKcjFNWW1YT2VvazNwY09lWllaOFBWeHdnZjRiaUN1WDhkbVYzZVB3?=
 =?utf-8?B?aWF1UU5jOSs3Vng4bGM5amxrcG5oY3ozdDVNcEtvRTJEckV3OGpyVzJsdkVV?=
 =?utf-8?B?UjFzZU8ybmUwYjM5cHN2TDRWMFlWb2pvQ1UwRndLTC9GUkpXbDJBSDN3Yloy?=
 =?utf-8?B?Q3VXZWJpNXNtbGNZWmFTa0k4TXgyTjNQV0twOEk1TnBxdjZWRTdxa1NFWTlC?=
 =?utf-8?B?Vy9tOVcwdkxaUWpLQlBDaXNuUXAvQWcwOFVLU3VjcnhCU1I3NWtYbEpnZS80?=
 =?utf-8?B?WExLR2p4L3ZPbTA4T0ZKZmRjMXZvaE9yTlhDTmtZOEk1YnpTdmExQVNQaHJL?=
 =?utf-8?B?ZWpFcDFkMTJuUEc2TzRRckRxK25NeEd6b091dW84bFMwMGU0N3Y2aUFOcjRD?=
 =?utf-8?B?ZkJkZ2NUYlJ1WHExZmk0SUkvcXE1M3IrU3Z1bGNxSmh1emphZExRVGtFR0R0?=
 =?utf-8?B?UytsbzNLRHdFd245Z3lKdjAyakYxSy9tOUUrN001Y1dKb2ZXRk94WU41Tkk5?=
 =?utf-8?B?MFBDSCs4Yms0NVF4SEdadksrOGRySXFiQitHRkw2YUY1a1VVNUVheTRkVjMw?=
 =?utf-8?B?L0p3dlJvaVQxc0hHK3NRem04a1JlNTIrTUlYREFGWXJYbEJBcjhyQXFpWUJz?=
 =?utf-8?B?LzlMNDN3aEVsU2cyZW5xSUZzZG9INy8xdlpaUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 09:13:08.1045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4f5435-dda3-496e-f97d-08dd87c73915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

(+ more scheduler folks)

tl;dr

JB has a workload that hates aggressive migration on the 2nd Generation
EPYC platform that has a small LLC domain (4C/8T) and very noticeable
C2C latency.

Based on JB's observation so far, reverting commit 16b0a7a1a0af
("sched/fair: Ensure tasks spreading in LLC during LB") and commit
c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
condition") helps the workload. Both those commits allow aggressive
migrations for work conservation except it also increased cache
misses which slows the workload quite a bit.

"relax_domain_level" helps but cannot be set at runtime and I couldn't
think of any stable / debug interfaces that JB hasn't tried out
already that can help this workload.

There is a patch towards the end to set "relax_domain_level" at
runtime but given cpusets got away with this when transitioning to
cgroup-v2, I don't know what the sentiments are around its usage.
Any input / feedback is greatly appreciated.

On 4/28/2025 1:13 PM, Jean-Baptiste Roquefere wrote:
> Hello Prateek,
> 
> thank's for your reponse.
> 
> 
>> Looking at the commit logs, it looks like these commits do solve other
>> problems around load balancing and might not be trivial to revert
>> without evaluating the damages.
> 
> it's definitely not a productizable workaround !
> 
>> The processor you are running on, the AME EPYC 7702P based on the Zen2
>> architecture contains 4 cores / 8 threads per CCX (LLC domain) which is
>> perhaps why reducing the thread count to below this limit is helping
>> your workload.
>>
>> What we suspect is that when running the workload, the threads that
>> regularly sleep trigger a newidle balancing which causes them to move
>> to another CCX leading to higher number of L3 misses.
>>
>> To confirm this, would it be possible to run the workload with the
>> not-yet-upstream perf sched stats [1] tool and share the result from
>> perf sched stats diff for the data from v6.12.17 and v6.12.17 + patch
>> to rule out any other second order effect.
>>
>> [1]
>> https://lore.kernel.org/all/20250311120230.61774-1-swapnil.sapkal@amd.com/
> 
> I had to patch tools/perf/util/session.c : static int
> open_file_read(struct perf_data *data) due to "failed to open perf.data:
> File exists" (looked more like a compiler issue than a tool/perf issue)
> 
> $ ./perf sched stats diff perf.data.6.12.17 perf.data.6.12.17patched >
> perf.diff (see perf.diff attached)

Thank you for all the information Jean. I'll highlight the interesting
bits (at least the bits that stood out to me)

(left is mainline, right is mainline with the two commits mentioned by
  JB reverted)

total runtime by tasks on this processor (in jiffies)            : 123927676874,108531911002  |   -12.42% |
total waittime by tasks on this processor (in jiffies)           :  34729211241, 27076295778  |   -22.04% |  (    28.02%,     24.95% )
total timeslices run on this cpu                                 :       501606,      489799  |    -2.35% |

Since "total runtime" is lower on the right, it means that the CPUs
were not as well utilized with the commits reverted however the
reduction in the "total waittime" suggests things are running faster
and on overage there are 0.28 waiting tasks on mainline compared to
0.24 with the commits reverted.

---------------------------------------- <Category newidle - SMT> ----------------------------------------
load_balance() count on cpu newly idle                           :      331664,      31153  |   -90.61% |  $        0.15,        1.55 $
load_balance() failed to find busier group on cpu newly idle     :      300234,      28470  |   -90.52% |  $        0.16,        1.70 $
*load_balance() success count on cpu newly idle                  :       28386,       1544  |   -94.56% |
*avg task pulled per successful lb attempt (cpu newly idle)      :        1.00,       1.01  |     0.46% |
---------------------------------------- <Category newidle - MC > ----------------------------------------
load_balance() count on cpu newly idle                           :      258017,      29345  |   -88.63% |  $        0.19,        1.65 $
load_balance() failed to find busier group on cpu newly idle     :      131096,      16081  |   -87.73% |  $        0.37,        3.01 $
*load_balance() success count on cpu newly idle                  :       23286,       2181  |   -90.63% |
*avg task pulled per successful lb attempt (cpu newly idle)      :        1.03,       1.01  |    -1.23% |
---------------------------------------- <Category newidle - PKG> ----------------------------------------
load_balance() count on cpu newly idle                           :      124013,      27086  |   -78.16% |  $        0.39,        1.78 $
load_balance() failed to find busier group on cpu newly idle     :       11812,       3063  |   -74.07% |  $        4.09,       15.78 $
*load_balance() success count on cpu newly idle                  :       13892,       4739  |   -65.89% |
*avg task pulled per successful lb attempt (cpu newly idle)      :        1.07,       1.10  |     3.32% |
----------------------------------------------------------------------------------------------------------

Most migrations are from newidle balancing which seems to move task
across cores ( > 50% of time) and the LLC too (~8% of the times).

> 
>> Assuming you control these deployments, would it possible to run
>> the workload on a kernel running with "relax_domain_level=2" kernel
>> cmdline that restricts newidle balance to only within the CCX. As a
>> side effect, it also limits  task wakeups to the same LLC domain but
>> I would still like to know if this makes a difference to the
>> workload you are running.
> On vanilla 6.12.17 it gives the IPC we expected:

Thank you JB for trying out this experiment. I'm not very sure what
the views are on "relax_domain_level" and I'm hoping the other
scheduler folks will chime in here - Is it a debug knob? Can it
be used in production?

I know it had additional uses with cpuset in cgroup-v1 but was not
adopted in v2 - are there any nasty historic reasons for this?

> 
> +--------------------+--------------------------+-----------------------+
> |                    | relax_domain_level unset | relax_domain_level=2  |
> +--------------------+--------------------------+-----------------------+
> | Threads            |  210                     | 210                  |
> | Utilization (%)    |  65,86                   | 52,01                |
> | CPU effective freq |  1 622,93                |  1 294,12             |
> | IPC                |  1,14                    | 1,42                 |
> | L2 access (pti)    |  34,36                   | 38,18                |
> | L2 miss   (pti)    |  7,34                    | 7,78                 |
> | L3 miss   (abs)    |  39 711 971 741          |  33 929 609 924       |
> | Mem (GB/s)         |  70,68                   | 49,10                |
> | Context switches   |  109 281 524             |  107 896 729          |
> +--------------------+--------------------------+-----------------------+
> 
> Kind regards,
> 
> JB

JB asked if there is any way to toggle "relax_domain_level" at runtime
on mainline and I couldn't find any easy way other than using cpusets
with cgroup-v1 which is probably harder to deploy at scale than the
pinning strategy that JB mentioned originally.

I currently cannot think of any stable interface that exists currently
to allow sticky behavior and mitigate aggressive migration for work
conservation - JB did try almost everything available that he
summarized in his original report.

Could something like below be a stop-gap band-aid to remedy such the
case of workloads that don't mind temporary imbalance in favor of
cache hotness?

---
From: K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH] sched/debug: Allow overriding "relax_domain_level" at runtime

Jean-Baptiste noted that Ateme's workload experiences poor IPC on a 2nd
Generation EPYC system and narrowed down the major culprits to commit
16b0a7a1a0af ("sched/fair: Ensure tasks spreading in LLC during LB") and
commit c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
condition") both of which enable more aggressive migrations in favor of
work conservation.

The larger C2C latency on the platform coupled with a smaller L3 size of
4C/8T makes downside of aggressive balance very prominent. Looking at
the perf sched stats report from JB [1], when the two commits are
reverted, despite the "total runtime" seeing a dip of 11% showing a
better load distribution on mainline, the "total waittime" dips by 22%
showing despite the imbalance, the workload runs faster and this
improvement can be co-related to the higher IPC and the reduced L3
misses in data shared by JB. Most of the migration during load
balancing can be attributed to newidle balance.

JB confirmed that using "relax_domain_level=2" in kernel cmdline helps
this particular workload by restricting the scope of wakeups and
migrations during newidle balancing however "relax_domain_level" works
on topology levels before degeneration and setting the level before
inspecting the topology might not be trivial at boot time.

Furthermore, a runtime knob that can help quickly narrow down any changes
in workload behavior to aggressive migrations during load balancing can
be helpful during debugs.

Introduce "relax_domain_level" in sched debugfs and allow overriding the
knob at runtime.

   # cat /sys/kernel/debug/sched/relax_domain_level
   -1

   # echo Y > /sys/kernel/debug/sched/verbose
   # cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
   SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
   SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING
   SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING
   SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA

To restrict newidle balance to only within the LLC, "relax_domain_level"
can be set to level 3 (SMT, CLUSTER, *MC* , PKG, NUMA)

   # echo 3 > /sys/kernel/debug/sched/relax_domain_level
   # cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
   SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
   SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING
   SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING
   SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA

"relax_domain_level" forgives short term imbalances. Longer term
imbalances will be eventually caught by the periodic load balancer and
the system will reach a state of balance, only slightly later.

Link: https://lore.kernel.org/all/996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com/ [1]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
  include/linux/sched/topology.h |  6 ++--
  kernel/sched/debug.c           | 52 ++++++++++++++++++++++++++++++++++
  kernel/sched/topology.c        |  2 +-
  3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 198bb5cc1774..5f59bdc1d5b1 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -65,8 +65,10 @@ struct sched_domain_attr {
  	int relax_domain_level;
  };
  
-#define SD_ATTR_INIT	(struct sched_domain_attr) {	\
-	.relax_domain_level = -1,			\
+extern int default_relax_domain_level;
+
+#define SD_ATTR_INIT	(struct sched_domain_attr) {		\
+	.relax_domain_level = default_relax_domain_level,	\
  }
  
  extern int sched_domain_level_max;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 557246880a7e..cc6944b35535 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -214,6 +214,57 @@ static const struct file_operations sched_scaling_fops = {
  	.release	= single_release,
  };
  
+DEFINE_MUTEX(relax_domain_mutex);
+
+static ssize_t sched_relax_domain_write(struct file *filp,
+					const char __user *ubuf,
+					size_t cnt, loff_t *ppos)
+{
+	int relax_domain_level;
+	char buf[16];
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+	buf[cnt] = '\0';
+
+	if (kstrtoint(buf, 10, &relax_domain_level))
+		return -EINVAL;
+
+	if (relax_domain_level < -1 || relax_domain_level > sched_domain_level_max + 1)
+		return -EINVAL;
+
+	guard(mutex)(&relax_domain_mutex);
+
+	if (relax_domain_level != default_relax_domain_level) {
+		default_relax_domain_level = relax_domain_level;
+		rebuild_sched_domains();
+	}
+
+	*ppos += cnt;
+	return cnt;
+}
+static int sched_relax_domain_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", default_relax_domain_level);
+	return 0;
+}
+
+static int sched_relax_domain_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_relax_domain_show, NULL);
+}
+
+static const struct file_operations sched_relax_domain_fops = {
+	.open		= sched_relax_domain_open,
+	.write		= sched_relax_domain_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
  #endif /* SMP */
  
  #ifdef CONFIG_PREEMPT_DYNAMIC
@@ -516,6 +567,7 @@ static __init int sched_init_debug(void)
  	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
  	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
  	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
+	debugfs_create_file("relax_domain_level", 0644, debugfs_sched, NULL, &sched_relax_domain_fops);
  
  	sched_domains_mutex_lock();
  	update_sched_domain_debugfs();
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a2a38e1b6f18..eb5c8a9cd904 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1513,7 +1513,7 @@ static void asym_cpu_capacity_scan(void)
   * Non-inlined to reduce accumulated stack pressure in build_sched_domains()
   */
  
-static int default_relax_domain_level = -1;
+int default_relax_domain_level = -1;
  int sched_domain_level_max;
  
  static int __init setup_relax_domain_level(char *str)
-- 

Thanks and Regards,
Prateek


