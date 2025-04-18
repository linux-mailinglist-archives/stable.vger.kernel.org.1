Return-Path: <stable+bounces-134530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0A1A93229
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 08:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8A1446CAE
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 06:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76D72512FC;
	Fri, 18 Apr 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VGqIyXFF"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC62690CB;
	Fri, 18 Apr 2025 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744958405; cv=fail; b=VvtOOBxfE2lH7cVOEMJBDlmbbPBec2TA/42pIJDpTiD97+FH0IzJRFfjzMdAfU0ySlRfCdeRoqNq8BtmiPgHo/xhyPDMBEI7VpFVf8UcKYBy1usbX5knJMinHT6l9CtxcfNUEROsDed6z66Xfw26N3UIqyPV3oJAABQR0tWP4GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744958405; c=relaxed/simple;
	bh=U3R4YrcSDiHTEzwQtgdCycP+K0d5yIeX2SaWfVE+Co4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WDitHCflUji4e5iBz3NDjV43aLAeT/HqhI7BEMVO8BRBGjsIayDLvhrzXW4YOUCWTRzZdRSf57To/Ceyj+gO2OCTp2ilG9joZD8sqUYPqkwPvVATJTyH1Fw824vG8jfr2VpArQpF2K+/1NBENS4pkWzwWej9qW06V4CkboePC7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VGqIyXFF; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnnBxPmKy/w/HwqWLOMXKPyPBt5/aty3/vaNk3GH2ooU5ixnBsvWl+usSehNm/qPJJDAfID2uQS64hXAA+T1vA+Ky2FyazH249m7ghoQcoILMmRqKb5IFMyaieJyHCJWGeQMQdFB5ojHJKwhl7Rq0XxtdTuHnLN3BmTGLomcPqO9K2F8m7D3zIJPokYmyFRjYnEuNAReNn8NmELyL+cnqY0124gDSp9//LwJdWrJWXjwIvyf0l0DktHn4jE6pu8M7DuQnaef4p+f4yN4spVkNuVW111ad39FNSgphug3F2HwoEO6ltA+kGFt0PCXrmIya+DOJGOFxmhNxA7lzRmsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgC2sEPHg/0A+WZEIVr+5JM5+l8jSPHzEQS6g2KJcHk=;
 b=aaDV9kJeE2siKEqzjjOLdRWwa1zjiz9uqDQv6foXX0qggGwAChXeTbxZUDcreJzvp2CYKgpZxIKs76k7gN46Kt5wBvSQiOtj8rfxdOiFelTBCj2L/6yKo/QIp4GPPiF2H+VPIZpeWDanvO1n1AuNciQlF0reVKge8s81t9YjdGBndaimhGvJ0CyXxRiQbTAlffCKp3ehDEkh8rNzYrDB7rIqaHBjuRzCpK1MGbwC4DSiqCpIAnQNs53imeBp5XXgVMgxbuMSYzCxtlkNwZLoYV/RB7Dv5Dnec3nIHT2TgA5zXuMV0fah40jJr5hf2CxWfeNb5YCKBU83RNAGVWM+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ateme.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgC2sEPHg/0A+WZEIVr+5JM5+l8jSPHzEQS6g2KJcHk=;
 b=VGqIyXFFu6UDMkZ3JvZ4R59P4Mez+YQWwezZdMtWuFNvkhH1eU9DK47auNMw2ekkoLAIHPYoGu/CIvdy/ecJWSrUjbZG0806vOQmGrxSwh1TOCXK2dSqws5NDFG/ESWmfUq8A6Xj7qYXCMYTlGr1obCkFVEmbujoBFDUNBCUXJo=
Received: from BN9PR03CA0360.namprd03.prod.outlook.com (2603:10b6:408:f6::35)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Fri, 18 Apr
 2025 06:39:59 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::bd) by BN9PR03CA0360.outlook.office365.com
 (2603:10b6:408:f6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Fri,
 18 Apr 2025 06:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 06:39:58 +0000
Received: from [10.85.36.22] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 01:39:55 -0500
Message-ID: <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com>
Date: Fri, 18 Apr 2025 12:09:53 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPC drop down on AMD epyc 7702P
To: Jean-Baptiste Roquefere <jb.roquefere@ateme.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a175e0-2ebe-4177-badb-08dd7e43d6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFlOamhEdUxrYm9pRnJJSDFSb1B3RUZjVFlaajU4SlAySnF6aXJxRVJKWGVv?=
 =?utf-8?B?YjFyc2xEdDU2ZGRQc3FSSHMySU0wYnJZcDdvcFlDY3ZPQkI0OXJWaDNCNVNH?=
 =?utf-8?B?SnhSbjJwSklqTCtrYzFSZnlnVlBtbGllckxDWTk2UzRxYUZudWlBbGYxK1Bw?=
 =?utf-8?B?VXlBcWRydDdJSm5HdFFjR21lSEhydVg1anlxY0h1U01VNW9OS0I2OXRlcGFn?=
 =?utf-8?B?emY4K3A0RnhCamV1a0RCbFQ0K2xDbGNKRHo3c0kxcDdGT3paY0w4cHRVVVNB?=
 =?utf-8?B?MEhoeXZRQ1Y4Y1dYQ1E4cWtpWnpIeUZHZmVKdC82Q2ZyUkkwY2JUd3p6MHpE?=
 =?utf-8?B?Z2w3c3dIN0llOG1XcEZrSldsTTJXNlU3Z3J1OEorSkw0dGpZRVAwMDlhOW53?=
 =?utf-8?B?T0llSlBhWDZweGQvSk1MWnR0N3BQWTkyMFV6YVZrU3ljdm0rT2ZjaGhtWjJH?=
 =?utf-8?B?TS9Tc28rNFQwLzVGeXVvUXk4V1IrdEkvcDJpY3hyamtFT2NQNUF4bDFMZDVP?=
 =?utf-8?B?NjVicSs0L3ZTYlJlNTFoNVluTU0vM3Q0RkV6SFpUUHJrNUVEOW5IYkxxdGJB?=
 =?utf-8?B?YWl4bDYzc0JQazBWYUhNbHUxSm95K0pLMUdoN294anlrM00zQTZOTnZGNHls?=
 =?utf-8?B?ZVJ2V0FyaDVhaDluV0ZjOEpiWEFWVGxoUDM3d1F4eTRQcVl6MDNZWERDeG4v?=
 =?utf-8?B?K3RueHRkMHBhV1hYdUtCdkxrcDE0REsxLzY3VmYxOC9tVnRUei8vOSttcS9y?=
 =?utf-8?B?U0tkY0U5eFlFK012a0hJQmR3VVVaRkE3VTM1V1Z1b1VIRjh3MTQ5YWtFTVFF?=
 =?utf-8?B?dllNU3dFcEsxMXMwejdtRzlZdlRxQ1NPcFlFSUlBaFZIMUdrZThmcjBjZGg1?=
 =?utf-8?B?bUJuQWc3RHVrcU54UnNjK0w3VTMxRVRZcGlrUlUxV1Vwdm9TS1owVEQxK0RF?=
 =?utf-8?B?WG0ydnYxUTVkd3BQbnV1VzgwaGMzWkFyM011TjFWVGhrQXl5MkFNak10NVh4?=
 =?utf-8?B?UUNkUHZFMlV3d3dsNElRTTd0T2UrVGxnb1ovbXB6UzFOSGxVZ3BNY2lCMklH?=
 =?utf-8?B?TFJudTNtbGY5Zm42eGlENnE4YmlickFWbVdEaWhidXVheU01a1lYNXh3TEdl?=
 =?utf-8?B?N3duS0Z2aTdZaGtqUG5oTkZTNTk2cmtIeXh3NnB6Vm82U09FNGc0ZDRWZFQ2?=
 =?utf-8?B?ZGpGMG5jbyswTGtabFJxOXU0OEJDa2oyK3RWc3plb3lVYkRuRWJicDNIcnd1?=
 =?utf-8?B?YzJmUml1YnQ4RGtuZWV0RHFTZzdJeTEyc3NySnI4S0xHc3NKWjFQMTBuczVk?=
 =?utf-8?B?cDhHbVBkL0RiUUxFM0ltaWZubStCdGRJb1lpTWlEOUlVWGRVR1FMcFdKTCtx?=
 =?utf-8?B?Z01UOVpIY2dPOVAreS9vTjFrazA0dlErbm9ZYUlLUmd3WGYwTndIbXF4RUoy?=
 =?utf-8?B?TW9wei94dHdDU1JnZ0ZwcmZuMUVVTGxuaEttSnp6NENkRkRqMk1ZMmlEeVVV?=
 =?utf-8?B?MDdRalp1TkZsQjZVNXdQZUNCd0FqNy9MYW0rTnZtSjAxbFNuTHkzTkdmTG5u?=
 =?utf-8?B?UzdCcllTSUJxYk01WjJyV0lnZEpnakVYK2ozamFldUVWdUZobHYxbFBlUTE2?=
 =?utf-8?B?d3lYRWh1eUZXTXIzbXBrMkg1RnR4dUlTd0MxWXJ4NkNPNCtCVEQ5Nk5uVlUw?=
 =?utf-8?B?MENERzZqczdSY2Y2UCtRZ3BWaGEzdy9LQWtyRjNxSkpzQnZFQnkwY09hOU1S?=
 =?utf-8?B?dkNkRGt2Z284dXQ0WHFKbHVpc0Y4YUZENzBXZVlPNGZINFdDbnZDU2QrTHZx?=
 =?utf-8?B?OUhKSlNQaHA1elM2VU1RZ1VNYXFzOXI2QzhxZndBalB6L1VuclNJM0JNOXRj?=
 =?utf-8?B?WlBLODZ2R3RRWFYvc1pOQUs2b3c5QUpxeW81K0k4VkZYcmJ5RjJ2WWRRb0Ro?=
 =?utf-8?B?cmRzUDhsbXRuOFlXZFA5cWc4OWdEVDZqUkRBY0ZnekxQK1N3VStmTTJBTzFQ?=
 =?utf-8?B?SU1qSG5HN0Vsak1NZ0NuaWF5bzNaMTQybTRtdDdFdEU5bEVqM05wN0U0N0FR?=
 =?utf-8?B?NzhuOHdudXNZSXNXS0RmRUttNmpnbXRRZ2R3QT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 06:39:58.6982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a175e0-2ebe-4177-badb-08dd7e43d6c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

Hello Jean,

On 4/18/2025 2:38 AM, Jean-Baptiste Roquefere wrote:
> ﻿
> 
> Hi,
> We (Ateme, a video encoding company) may have found an unwanted behavior in the scheduler since 5.10 (commit 16b0a7a1a0af), then 5.16 (commit c5b0a7eefc70), then 5.19 (commit not found yet), then maybe some other commits from 5.19 to 6.12, with a consequence of IPC decrease. Problem still appears on lasts 6.12, 6.13 and 6.14

Looking at the commit logs, it looks like these commits do solve other
problems around load balancing and might not be trivial to revert
without evaluating the damages.

> 
> We have reverted both 16b0a7a1a0af and c5b0a7eefc70 commits that reduce our performances (see fair.patch attached, applicable on 6.12.17). Performances increase but still doesnt reach our reference on 5.4.152.
> 
> Instead of trying to find every single commits from 5.18 to 6.12 that could decrease our performance, I chosed to bench 5.4.152 versus 6.12.17 with and without fair.patch.
> 
> The problem appeared clear : a lot of CPU migrations go out of CCX, then L3 miss, then IPC decrease.
> 
> Context of our bench: video decoder which work at a regulated speed, 1 process, 21 main threads, everyone of them creates 10 threads, 8 of them have a fine granularity, meaning they go to sleep quite often, giving the scheduler a lot of opportunities to act).
> Hardware is an AMD Epyc 7702P, 128 cores, grouped by shared LLC 4 cores +4 hyperthreaded cores. NUMA topology is set by the BIOS to 1 node per socket.
> Every pthread are created with default attributes.
> I use AMDuProf (-C -A system -a -m ipc,l1,l2,l3,memory) for CPU Utilization (%), CPU effective freq, IPC, L2 access (pti), L2 miss (pti), L3 miss (absolute) and Mem (GB/s, and perf (stat -d -d -d -a) for Context switches, CPU migrations and Real time (s).
> 
> 
> We noted that upgrade 5.4.152 to 6.12.17 without any special preempt configuration :
> Two fold increase in CPU migration
> 30% memory bandwidth increase
> 20% L3 cache misses increase
> 10% IPC decrease
> 
> With the attached fair.patch applied to 6.12.17 (reminder : this patch reverts one commit appeared in 5.10 and another in 5.16) we managed to reduce CPU migrations and increase IPC but not as much as we had on 5.4.152. Our goal is to keep kernel "clean" without any patch (we don't want to apply and maintain fair.patch) then for the rest of my email we will consider stock kernel 6.12.17.
> 
> I've reduced the "sub threads count" to stays below 128 threads. Then still 21 main threads and instead of 10 worker per main thread I set 5 workers (4 of them with fine granularity) giving 105 pthreads -> everything goes fine in 6.12.17, no extra CPU migration, no extra memory bandwidth...

The processor you are running on, the AME EPYC 7702P based on the Zen2
architecture contains 4 cores / 8 threads per CCX (LLC domain) which is
perhaps why reducing the thread count to below this limit is helping
your workload.

What we suspect is that when running the workload, the threads that
regularly sleep trigger a newidle balancing which causes them to move
to another CCX leading to higher number of L3 misses.

To confirm this, would it be possible to run the workload with the
not-yet-upstream perf sched stats [1] tool and share the result from
perf sched stats diff for the data from v6.12.17 and v6.12.17 + patch
to rule out any other second order effect.

[1] https://lore.kernel.org/all/20250311120230.61774-1-swapnil.sapkal@amd.com/

> 
> But as soon as we increase worker threads count (10 instead of 5) the problem appears.
> 
> We know our decoder may have too many threads but that's out of our scope, it has been designed like that some years ago and moving from "lot of small threads to few of big thread" is for now not possible.
> 
> We have a work around : we group threads using pthread affinities. Every main thread (and by inheritance of affinities every worker threads) on a single CCX so we reduce the L3 miss for them, then decrease memory bandwidth, then finally increasing IPC.
> 
> With that solution, we go above our original performances, for both kernels, and they perform at the same level. However, it is impractical to productize as such.
> 
> I've tried many kernel build configurations (CONFIG_PREMPT_*, CONFIG_SCHEDULER_*, tuning offair.c:sysctl_sched_migration_cost) on 6.12.17, 6.12.21 (longterm), 6.13.9 (mainline), and 6.14.0 Nothing changes.
> 
> Q: Is there anyway to tune the kernel so we can get our performance back without using the pthread affinities work around ?

Assuming you control these deployments, would it possible to run
the workload on a kernel running with "relax_domain_level=2" kernel
cmdline that restricts newidle balance to only within the CCX. As a
side effect, it also limits  task wakeups to the same LLC domain but
I would still like to know if this makes a difference to the
workload you are running.

Note: This is a system-wide knob and will affect all workloads
running on the system and is better used for debug purposes.

-- 
Thanks and Regards,
Prateek

> 
> Feel free to ask an archive containing binaries and payload.
> 
> I first posted onhttps://bugzilla.kernel.org/show_bug.cgi?id=220000 but one told me the best way to get answers where these mailing lists
> 
> Regards,
> 
> 
> Jean-Baptiste Roquefere, Ateme
> 
> 
> 
>   Attached bench.tar.gz :
>   * bench/fair.patch
>   * bench/bench.ods with 2 sheets :
>      - regulated : decoder speed is regulated to keep real time constant
>      - no regul : decoder speed is not regulated and uses from 1 to 76 main threads with 10 worker per main thread
> * bench/regulated.csv :bench.ods:regulated exported in csv format
> * bench/not-regulated :bench.ods:no regul exported in csv format
> 



