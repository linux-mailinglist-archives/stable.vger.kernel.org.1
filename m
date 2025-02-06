Return-Path: <stable+bounces-114062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB10A2A5B1
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF56E1689AF
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D92322617E;
	Thu,  6 Feb 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Clw8Eqt3"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31496214210;
	Thu,  6 Feb 2025 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738837176; cv=fail; b=cj9+fiV+G7AXar9kp4HwB5U8m/a0hAC7uyy5cPqZInpAZjKlxNCbmpKYbaCVrTn1W6PFzi/pCgr1YpAVZ1ztFV8zg0JxJ2JDYhR4Wbj5zvvR7fk1EeAfujBehh60hdYtxt+xD/97C1I50UsEa/aMh+gXzpNZAj7LknxxQ6fnuOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738837176; c=relaxed/simple;
	bh=mxRo0+DmVrHzt5mbpK4UMeFAHyKoPsSgBHQd6LHiUCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JyzimdpZ+4u3Z3oai4qp5vVr6IzLN33iHWhVTeRqWKCOKbsIzi27F6Vju2cR7gir/SQOwE3+ZFrsbUNNmg9wjCJK22W3JicOf3WvTxEi0YXq+NSg/9j2U2K3r8mPPdWc7LQAcCveR0Glx+GRsHs7KH3t/HzBEkxX8bUVqBFUTKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Clw8Eqt3; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+9ED7wGkTp4QQbJ8/eLkIb/a46aZKgQYMhh8AKERL8XL0nfWw1MnLY2BlsMAcW5f56YpXMxvDIX7ocJdpwkGiTxwbQc/P/Qrc4jBYTkbUzVTQSNLIFtSWjEtmLThLLmlQKeJSQ7ZFvWLxTP5J2ndTYM9Gy46zZ2S9P0/rrw50ZmdGJ+7rU2iw/Vv8bhBwiHrLVFXCm3PVX8dlf3vUo1IF8k3u5WWzRgGunS//A4drrMzBFQLOJBVKXSMvbzXNom2s+GXk3JPTqpWc0agVPJyo/OdrVffNReW2/BCw5W6AXzaOJgrkCCJCuCXzvtYa/NoZGpgABGWHz5PTRsrS4RMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8416ztLNWOOOv+jz1FNS2dMXx4ObSG8Zlg5BXWmzL7g=;
 b=Yd6P/rKURGj4giIodPdMNgZkSvUpARXc1QCws+LOAB/677T5D+YAZId0UPnpjpJ75vyfVmXcplKqnqU9XC/+zNwTnBgkSSAdP0bGFENRp2xolW0nz366HWiR13DEE8ieO8UMppCRHTh7t2oZmZIBSfYRu4PTF3SdyEVwzFUdde2ksdL59eXWE8akIyIsLyEnq0DJ03huxWSCCvonrA8bT1JwcbD7FEdmRAUmBQOXEUL+5Dg4oDnlh14nxWPFOiTpaWcVhRt7e+o56h5VomA2JGgE2zf10MNQJ2JCpK5ntzEsv54ZKAs/j4LA3d0CajY46LYR2SUlaSQ9tBhw1MWNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8416ztLNWOOOv+jz1FNS2dMXx4ObSG8Zlg5BXWmzL7g=;
 b=Clw8Eqt3yuE8S241OFElnIsLa5gKBKvsZuDuvd87KH5GxcYRxMvslxB7xHTNDU6mOOIZreIFV3or6/x1PwIrcsX54BcLmeLfS5RyXGd4aptj/1UqKXG1LgOfJTrTPuutnIRtj/EvPAqQef9PnnftSs4UY6DNbZo026IQu/zHxUM=
Received: from CH5P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::10)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 10:19:31 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::c3) by CH5P222CA0021.outlook.office365.com
 (2603:10b6:610:1ee::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 10:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 10:19:31 +0000
Received: from [10.136.39.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 04:19:26 -0600
Message-ID: <f3f850a5-500f-4819-9884-c36e65d498cb@amd.com>
Date: Thu, 6 Feb 2025 15:49:19 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: Naman Jain <namjain@linux.microsoft.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Steve Wahl <steve.wahl@hpe.com>, Saurabh
 Singh Sengar <ssengar@linux.microsoft.com>, <srivatsa@csail.mit.edu>, Michael
 Kelley <mhklinux@outlook.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <20250205095506.GB7145@noisy.programming.kicks-ass.net>
 <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>
 <20250205101600.GC7145@noisy.programming.kicks-ass.net>
 <e0774ea1-27ac-4aa1-9a96-5e27aa8328e6@amd.com>
 <7042c53b-31b6-491d-8310-352d18334742@linux.microsoft.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <7042c53b-31b6-491d-8310-352d18334742@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c824759-8086-4136-3ce5-08dd4697bedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|32650700017|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFlUK2FsRHVadE96Rk40UW41S2ZPOEpyK0Z0a0lYeXZnN25LdTRNVlBMNkZ4?=
 =?utf-8?B?dm5BS0ptSmx6Yzl1VzZ4TXd0Y2JkclJDdFpYSWJFQ3FYajY5aFFUWVFWcG42?=
 =?utf-8?B?RWNJOXkrRCt5bkJvUGxneHhkM250eHByRWJoU1hwMDdEbklqUmh3TGg0aVhT?=
 =?utf-8?B?VW54SE0rMXR5L25UMlVnSWt2K21TYXN4ZVdSZ0NuQ3FEelkvekJvWFJMNk0x?=
 =?utf-8?B?ZmRJTlBRdjRNZ05rcHNPa1h4cEVMVkZKTW5zRVgwY3dUUlVTMlpPVTMzZkdk?=
 =?utf-8?B?QlpDb3huWDYxS2pGSDR3RHlWOVczTnhsVTBBcFhLZ2tXbVM0dXNBT1ZTcWpE?=
 =?utf-8?B?ZlcyRXN5alowWHZYcGVSUmIydlNRRSt4Z3V1cXhqb2ROV1BzOEp3VVQvWS9i?=
 =?utf-8?B?cEdwM2Y0N09LUGlqRzRpa3hqUzZWbm1DQ0IwVEc1TytLd1Rnc01hZzRXeE1O?=
 =?utf-8?B?eDZXY2RqejBoUHZOVHYyTm9ITmZLMXRIbDBIcFJSMVVQRG42MThPb2VCRU9Z?=
 =?utf-8?B?elVIUG1LQ0tHbnhOaE5KL1BHN216TW02NWN5WVRUc3UwcWM5TDYvUHI3TjZL?=
 =?utf-8?B?SjdJSlBtMWNtZXg2dEZzd0l6eCs5NytnQWxGSThCZm1URzNkVldNbjQxdEM4?=
 =?utf-8?B?aStCbm1ZZlNmaEF2MTQzdnFjSUN5eVIrd0RmOXNXRy96Tjd1akRDeFZqSDJv?=
 =?utf-8?B?Zngzd3lPc3gyVWpPc2JzMm1BZFNIMjUxQmdiaW1uZDRvQU9rdXBJZE1NTjVr?=
 =?utf-8?B?T2djdlZ6bVVEamJ6NmsvdTZrYmpkbElyWTlNUzQzTnVqUUl2dnozYVlvNVla?=
 =?utf-8?B?TXE1UzR2bmxuYlZOVURLbjN0OEh2bWg5Y21aVXBoQVkwemxuTlIrS2J2UzY0?=
 =?utf-8?B?TlFoWlVTRHBIb0xzamFCbG0xcFVUSDVVMlhZMmpoQU1HZTRocStrOFpRSHJK?=
 =?utf-8?B?T09Ta0FhbEdXN2Y1RWJ2clZUT1k1OHloZ0UySHFkMWUxa1Bhamt3RzU3YVZ1?=
 =?utf-8?B?RWNwWnhoVE84bkRQd29UUFAvdlJ3U0pscXRBMm01akNjNk1EOTFVZFAwMTNV?=
 =?utf-8?B?WkZMKzdtZGp0VVpKQnNLRkYxa1c4MVVlOGRCdW5hUmwyZnZxRnE2TUVrTDZC?=
 =?utf-8?B?MEdSclVCSUNQdzd4Q1dMNFh6ampsYW9aTFg0blZESU5pRUhIWGNXL2tMYWF3?=
 =?utf-8?B?NTZGVUJkbUs0bjkrNXo2cXpnU2hvZlNjVFRCYWEvK1VncWJId2V5R21ZUVkz?=
 =?utf-8?B?RE5xZ2U4YVJ5UzI4RmY0TXVlTGJlbFhRWTFuaGk2VU5GVzIyNm12dy9jeExD?=
 =?utf-8?B?Wm8zN05tOUZvUzhHdkJXL2d2T043L0cvWDFQbmoxSWN1TldQQXNVYkh1NE1O?=
 =?utf-8?B?SkdGNWJJMTBDajhNUGZ4OW5GZDc5dG1IL1lMWEN2em9aM2FpUlEvMVAwVDZL?=
 =?utf-8?B?YUlHeWYrOHlHR0J1eG5ldXJNQllJSllWQ2dPdG9EWTkxSjZzd1RCSGdLdWlv?=
 =?utf-8?B?VXpkcVUrU09sZktxN2FmWFpvTFBLcklyRURIS0lidlFxVFNLelA2a0htVEpP?=
 =?utf-8?B?WGlKN1RTeks0Q1dQUitaZUx2d0xRVnlQS3lLeGNuUHhCM1lJcGtUVjRMeStO?=
 =?utf-8?B?cktTemlBU1J3dUVldU1ZWEo2Y080RWFnUGFUTEkxcUFMaGxQUFRJTzFveDNU?=
 =?utf-8?B?TFp0b1BaazVJM1FZcC9oTURRT2xzRjZGekkrT3dZWkh4QzdSTE15c3JIZXJ5?=
 =?utf-8?B?b2E4SUZMeW8vbzZTN0ZIckJqVWllVVJZSHRGTWhNVmVmek92V0pyaFZlTzQ5?=
 =?utf-8?B?dVB6dDdMZ1hpM0xoZk4xWG9SKzQ5YytWUjRwdlhDUGVkQ2RJNlEyaXFHaGR0?=
 =?utf-8?B?dy94bVlCQWluenkrc1ZMRjBmbmNycE9VNHpxL3Q5TDV5bzR0YnYrYVVXMmJp?=
 =?utf-8?B?ZWpnaE5QZXRzbmxneGVXZDJPUzBiRG9aTlZoQjJjUmNEd3dVNjhMTVQrWjZ6?=
 =?utf-8?Q?BjvXWuUevi1LwIb49/c6oMMiHtGacs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(32650700017)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 10:19:31.1848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c824759-8086-4136-3ce5-08dd4697bedf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225

Hello Naman,

On 2/6/2025 3:17 PM, Naman Jain wrote:
> [..snip..]
>>
>> This is why I think that the topology_span_sane() check is redundant
>> when the x86 bits have already ensured masks cannot overlap in all
>> cases except for potentially in the (*) case.
>>
>> So circling back to my original question around "SDTL_ARCH_VERIFIED",
>> would folks be okay to an early bailout from topology_span_sane() on:
>>
>>      if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
>>          return;
>>
>> and more importantly, do folks care enough about topology_span_sane()
>> to have it run on other architectures and not just have it guarded
>> behind just "sched_debug()" which starts off as false by default?
>>
>> (Sorry for the long answer explaining my thought process.)
>>
> 
> 
> Thanks for sharing your valuable insights.
> I am sorry, I could not find SDTL_ARCH_VERIFIED in linux-next tip. Am I
> missing something?

It does not exits yet. I was proposing on defining this new flag
"SDTL_ARCH_VERIFIED" which a particular arch can set if the topology
parsing code has taken care of making sure that the cpumasks cannot
overlap. The original motivation for topology_span_sane() discussed in
[1] came from an ARM processor where the functions that returns the
cpumask is not based on ID checks and can possibly allow overlapping
masks.

With the exception of AMD Fam 0x15 processors which populates cu_id
(and that too it is theoretical case), I believe all x86 processors can
set this new flag "SDTL_ARCH_VERIFIED" and can safely skip the
topology_span_sane() since it checks for a condition that cannot
possibly be false as result of how these masks are built on x86.

[1] https://lore.kernel.org/lkml/f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com/

> 
> Regards,
> Naman
> 
> 

-- 
Thanks and Regards,
Prateek


