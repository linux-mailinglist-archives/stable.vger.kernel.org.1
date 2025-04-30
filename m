Return-Path: <stable+bounces-139135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA205AA4A0F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB241895C53
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E2B25A2A1;
	Wed, 30 Apr 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tsjpdR+T"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751A258CCD;
	Wed, 30 Apr 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012604; cv=fail; b=c8CBdz2tVPSMMOzyyUG+azHfoVsDRX+wB2vRlGaCszjdYnNdED7PALAEH3DJcigjW8aQOe7QCL8eJ4P95N+WeMzQLid1YShtwkRqQGwMl5mrluFvUcppMpDMtW/JZOtjvuD3bANjvOurqCjdiunk8Zgir3Xf5+AxXuNpwgW7ZGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012604; c=relaxed/simple;
	bh=xixQgAS7Gns+zVcB/KwV8qQ45hTU8EMCrfbUTA+OzxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZMy9MSeQlt6Bgr6N5/7H4ksP8WUjaxVkWH8SIKVOZN4p3tMaP9fIBn/X6dbJP0iqHarhL/4xX5rlMXnfNZ/NgIpsPEQJ6F+HF8I+ycHnZdMJtpPKrau3VReaGVrt8Y84TSVnU2trqOJBNrz3RZCO/2ha6iUA+/eVL2ZpgB3gy1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tsjpdR+T; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6xyPKl1GTJQAtw5NTa5PVRQZKSihcKoKcZJx1c4a4ujIF0RzIGkIt2YaIbujnT1MqIzHbnlmFNme1udZ2MwTdUKhdNf/VLfGvNEO68JJndjRSqe1xWpj9QikHphSPymiE2TM1ldAWQlQbvhUCbQ/l81ZuJxH1bJF7GsdLXOHoX/vA2jvqB56Nc9YZCScHU3FzWMnTBvRBIE0naUMvEAbq51tIoChuHmRbEnaLsO28hgZMV7O+kn+31sCo0y49n7DNDf7lWh/e7jQSkGK0FGMSOHLmWW9QzkkcR/BpRF7dYkJLxoG9lINc0ICe45jw4w3a5MzW4uUO4dNHzss10SjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+CSL9bsXLIVsOP9UUGlYX7l+YbpYRwv1MUfUwYdxoI=;
 b=zDGZEleUvTyEjtQTlit80H+E4KDi1BIod5UHdaGTlY/zlWgL9P3BVFfoMywSk8/f+U3DnqR2AB5xrUOQoyT3SuMsrV4YhS9GX+LfZVrOQ3BIuDXSX6uS40ROdbrrO+Lpo4OI6sP0PyG2Y7XltclrPVxfojUnojBdUbDwIMPTpJl9yKGaFBn2+5hA/UYEvdBbn6qXvu5UPndt+IbpSaCagKhw8QEh8lxPtOoTyz18MR4Uq6XmRPq9IEKCeut5XEE1nEAmpAFVtxUs9O9xqK2MAJ7QtCBBK8aUjfjIlmnAnWjKhmQyRix1BMgyCO3XU1rWYwU807wgojh8eTMYCyehzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+CSL9bsXLIVsOP9UUGlYX7l+YbpYRwv1MUfUwYdxoI=;
 b=tsjpdR+TkE3skkEbdJGcaH0yzVzgms6dQugV1iXNi1LwAsqyqT67ogcRY/RyH5eFOkfhb65+n7+XmiSC1XilYPyTySmFqbRO7HKjYsgGnxNSd2I9+BauDaYrNVFn7KTswv8SW+zX6F4OB01/GhXheHBT+lxK+IhqjNTPW5f9/bw=
Received: from SA1P222CA0178.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::26)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 11:29:59 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:3c4:cafe::26) by SA1P222CA0178.outlook.office365.com
 (2603:10b6:806:3c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 11:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 11:29:58 +0000
Received: from [10.85.37.104] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 06:29:53 -0500
Message-ID: <020e7310-397c-4967-9635-8e197078f333@amd.com>
Date: Wed, 30 Apr 2025 16:59:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPC drop down on AMD epyc 7702P
To: Libo Chen <libo.chen@oracle.com>, Jean-Baptiste Roquefere
	<jb.roquefere@ateme.com>, Peter Zijlstra <peterz@infradead.org>,
	"mingo@kernel.org" <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Valentin
 Schneider" <vschneid@redhat.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Konrad Wilk <konrad.wilk@oracle.com>
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com>
 <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
 <bc016aaa-fed0-4974-8f9d-5bf671920dc7@oracle.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <bc016aaa-fed0-4974-8f9d-5bf671920dc7@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf796db-e2d6-46e1-15d3-08dd87da56de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDJaOWhRaGlkQnNNUVdxM013Y0dRTU16R3RqUHFORHg0N3FPbUh1Y09JYTlM?=
 =?utf-8?B?VTRkb3N4dGVyZWErSFQ2dml5WWtva0EyZWN4NUpsbWMzbkYwNi9xS2h2QW5T?=
 =?utf-8?B?MTB6U1ZjeldrWjdaTFhWYWdySE00MVdPRXA2YUVtS3RoT2tBWWhVVDlENnVv?=
 =?utf-8?B?d0NJSVFQYTJBV0x6S0ZmU3Irc0JzQmJNb1NnclhFaTdkdGs4dzZyQ1ZIbUVz?=
 =?utf-8?B?NC9lcTJPcG81UlhIVERKU1lzdUhJclkvMnl2RVBZTTZQZnZ5L3B3NnZBbGJU?=
 =?utf-8?B?aU9qY05SdDkzM2MvSzRzc2JTU3U4UXZBRDNvN05jdG9NbXUydGdwN1V4dHNX?=
 =?utf-8?B?aWowSzFNNWZlVi90WllVTEJwbFBFclBCSzlENG9FSWJTSGRSa0h4MUZUS01a?=
 =?utf-8?B?UHFKQnhkU2ZIb21TS3ZWK0dPT05Cc2VyWWpneXhHWXNkMnR0Z29Vckpuc3lC?=
 =?utf-8?B?bXZHUmFaNCtMTllIQUY3RFlXN3hhV0lvc1lYVzhPUG5PdHphTEdaVGtsc2xE?=
 =?utf-8?B?WTYzOGE1TVVsWFZyYVFuc0lZZ01PN09MeXNTYm9Ec0pMdEFlRXpUc2M3eHFl?=
 =?utf-8?B?dUsxdHFaTWhsWk9QR3p2THV3eTl1SGRxd0tUQUhwSUEyMjBkQnRyUk9rckcv?=
 =?utf-8?B?cmN5bkZNQ0t5RkJNeFlmUmxDZ1d3Q3dKTGdVKzJaTi9vS2YzVkFOWlkxQmNL?=
 =?utf-8?B?TEo4Sm5OTW0yOGgwYU9qT25JbDE1Q0kreTN6bUh1R3JyNjNBRWdOTHN4b05X?=
 =?utf-8?B?cEhnWHVocit2OU5MN0RFamk4MFkxNTl6RGp3R2FwVzFQMHovbE55N2c2OGlU?=
 =?utf-8?B?MmdWYUg2VEs4MmExTzlsZVdqM1JZZStoY2E1cXJJdGVtQ2JFUVdXN1lONldz?=
 =?utf-8?B?eVZTdWc0dC9zK25mK0drR0RkcURCcld2aXVRaW1CWXRCdEM1YnJlMU56S3cx?=
 =?utf-8?B?aDJHQjlVTWt1RFRqS2szV0Ryb01UazB0c1FOWmtSR01ONHhiS1I2TFRKemlr?=
 =?utf-8?B?Tlozb0pETmRaNytiQS9JbHJwT3c3OTJUcGdycmNTUkt0RHpIY1NZbC9nTmtH?=
 =?utf-8?B?L2pLZWpBYUNMQXI1VmpmdmJQRGpEQlZhN0pLM1RLbkN1bHI5VVQydE1QNHEr?=
 =?utf-8?B?cmVwZ1RwSnlBNTRYYnMrT3NYSWkyM2k3akE0Z3c0WFNBaUxXaUhBZXpQeG1H?=
 =?utf-8?B?N2NxNFpMWHZ5ZHhNaUZodkI4clc1OXlSR2RYclRmdWYrV2RwYkpvU0dxY3Fp?=
 =?utf-8?B?bXByZkxSQzcvN3phMkZaOTdsK1NTNFJjaDBIUWdxTU1TWGtqVlBHa0gvVmpG?=
 =?utf-8?B?YXZraHpUYkZDeVVnRG1ZRGF4QXJadVVKK2JQOVZFbVlJa2ZEcjE1U0NBRWda?=
 =?utf-8?B?c0lqdWF1ZFNDQS9lS2lucTQ4ZWo4QWVNNys0VzFGckV2RGt3WVFUSWdyRnRx?=
 =?utf-8?B?RkJ3UjNWaFhXaGtLdlRmVTFHL1ZRcGU2c1VsbDJ2OEZBWnFmY1ZwZ1k3TUk4?=
 =?utf-8?B?SEszQmdxc1g5b2MzUkR3cHNNdFIrRHNyUDZhUldKcjRnY0NVY1hrdE9DOHVD?=
 =?utf-8?B?UXdvdVhza2VkUG5SbkZnaENnS1c1S2JTM3VERGI3T3EzdDRGRFVKQ0pPVDZQ?=
 =?utf-8?B?dmRFbTNiMkdMYkxialhtQlgwSTJxOVZQc0F1aldiOEhTMTQzVE80TUd3Mld1?=
 =?utf-8?B?c2Z6dEhUNXpkY09URWN6a2RkV011R0M5c2FnemEvN1RCNmpFYW44blBmMHJL?=
 =?utf-8?B?Tmp3QXBZdEZJNlgvWEpjdDcrQmxnWkFkRmVQWC9jUjg5OWtUeWFJclFaVkpD?=
 =?utf-8?B?MDNiNldOZlUyZ2pIMDZCUGZCZGlJTnArMkc4NzR1QnNXMnNWUmxNZC9OQ2Jx?=
 =?utf-8?B?Z2M3SW5QQ3hmYWJvUGFFVythaVhZUUM0SVpibWNaeEtiL3lOY2xONmhRMTd4?=
 =?utf-8?B?dXBLWGpWbUkzY0gyOWNxMGNNN21reVMzTDI4Zm5TeXZWQ0VPREV3N3lZKzVH?=
 =?utf-8?B?OUVXRExmS2dmcEhmTnEzYmt5VzVpSTNzRTBhUGNQWndsY3JxbjMvcTEyRnQr?=
 =?utf-8?Q?JDn+1d?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:29:58.5836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf796db-e2d6-46e1-15d3-08dd87da56de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665

Hello Libo,

On 4/30/2025 4:11 PM, Libo Chen wrote:
> 
> 
> On 4/30/25 02:13, K Prateek Nayak wrote:
>> (+ more scheduler folks)
>>
>> tl;dr
>>
>> JB has a workload that hates aggressive migration on the 2nd Generation
>> EPYC platform that has a small LLC domain (4C/8T) and very noticeable
>> C2C latency.
>>
>> Based on JB's observation so far, reverting commit 16b0a7a1a0af
>> ("sched/fair: Ensure tasks spreading in LLC during LB") and commit
>> c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
>> condition") helps the workload. Both those commits allow aggressive
>> migrations for work conservation except it also increased cache
>> misses which slows the workload quite a bit.
>>
>> "relax_domain_level" helps but cannot be set at runtime and I couldn't
>> think of any stable / debug interfaces that JB hasn't tried out
>> already that can help this workload.
>>
>> There is a patch towards the end to set "relax_domain_level" at
>> runtime but given cpusets got away with this when transitioning to
>> cgroup-v2, I don't know what the sentiments are around its usage.
>> Any input / feedback is greatly appreciated.
>>
> 
> 
> Hi Prateek,
> 
> Oh no, not "relax_domain_level" again, this can lead to load imbalance
> in variety of ways. We were so glad this one went away with cgroupv2,

I agree it is not pretty. JB also tried strategic pinning and they
did report that things are better overall but unfortunately, it is
very hard to deploy across multiple architectures and would also
require some redesign + testing from their application side.

> it tends to be abused by users as an "easy" fix for some urgent perf
> issues instead of addressing their root causes.

Was there ever a report of similar issue where migrations for right
reasons has led to performance degradation as a result of platform
architecture? I doubt there is a straightforward way to solve this
using the current interfaces - at least I haven't found one yet.

Perhaps cache-aware scheduling is the way forward to solve these
set of issues as Peter highlighted.

> 
> 
> Thanks,
> Libo
> 

-- 
Thanks and Regards,
Prateek


