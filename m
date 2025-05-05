Return-Path: <stable+bounces-139680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE96AA9320
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 14:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6949D16E088
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C8D24E4A4;
	Mon,  5 May 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F85HpI1F"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05C24BBF0;
	Mon,  5 May 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448164; cv=fail; b=D1VQJJ86gD9eJmnIaKp7MGu2ni3k5r02SfRrONMpvkXXtR+ZJ6eNOGbMN0RxdkfkTJ3RGoVZf0X13a2ku700jdBlGv+lvuma9yhzMa/nLqfExTUoaO2mvIpW4BrCc/ZA6nqKbprFdEmmGQLj6Ksbdy61aYN+4O7oM3TSokhfmYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448164; c=relaxed/simple;
	bh=+0XOuofkXwKbb+DLVEwpQ6HLWAyliWrfL4IFQH0Ow/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ni9T3qhImeM8oAUbqyEPVjQECNVFX2qKkJjmUP4Fqyf1hGYvwq1x/rrs8uQZMbuVOM9r6j560Xv9ZdYGLhJpwgh47CjWR5f9ULMrBaeDbF1qFcbTKbvVfzIhk99f5L2xInK30gOJFEbH6ukRjHNnlRjPNj1nl8sQbh8QtPLPrsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F85HpI1F; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZV3+mx6em+WaN6ugw1CODWDiKikpIDGsPnN0iEBgiIGLprQ9bEKr5gqpkVL+WMBsSfpbMW73L7tHlc7OCbjTRx7wvCojPfG8y7+b2bcm2Y/GAhsXfim4D5YmpAHgVohdw07xSNLGGZPL0NxaqrNsJCGCQpcvEhhDc8CPmirG/E2yUa9EdYkGD5KLqps9U/yPdQgJDeaZP4T19yWsK4WxC4MYoC23ESfF/26u9Ms2BsscW6Xd3VoSoLK8dzZl+mBx9MRO71RYek8J38PqfjmZTl5xE9tkxEtOETwOQbLC7sQhA9tQfwcqYTmJ6FEFtZvz2efsp+s6ojboLSYmj8awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4dXeCZ9++pOr+rfjEA+/zxyNm1En2RtTKwzhFta2H4=;
 b=g549s+WBtG3QgFOIW4/NjE76/HrqwRvZpsBQnATp1QTi0a85+G2ufMx73AXaVo1E634eLg5MEADRX6JgoXlhIvLAHCUzYvUoukVbeIWq9o5X+32cKBmE8WjNQcNS3VAnNVSLwkuZnhRjRWCuMQ7bVC0x63Y1K2AEjWoteRh6x+pXdwqRBMAb704kkLjOsBZn1PhztMPR7D6fHpCIhmaHmmiPZJ4mQdC40UjLh4ito8DVs2OdqvgIjshbzPAW/o0FSSZT6PGvtJ0qtDj/Nhb1jPiVRVP9aXjSovFZvrw1bgoYC+1omOHvTptlGwiSR0acO5tPmn84uVVXGJg4ZJiZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4dXeCZ9++pOr+rfjEA+/zxyNm1En2RtTKwzhFta2H4=;
 b=F85HpI1FmKz8Ssrn/HHpAvQlxNiMEWvCTzwCvxiu9PdwlT0Em2cKbObfUGtDVHCCO5fZfmCGF16SsqtOdT+yqQbXaTjkK9LEUtN/0USSm/2XTB2Qb4VCpAuNbUJawD/Ofc/NpQGXyTZE34fs293gETt/fOWuIyR0qVKe7imK2jc=
Received: from CH2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:610:50::40)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Mon, 5 May
 2025 12:29:20 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::73) by CH2PR16CA0030.outlook.office365.com
 (2603:10b6:610:50::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Mon,
 5 May 2025 12:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 12:29:19 +0000
Received: from [10.143.196.137] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 07:29:14 -0500
Message-ID: <de22462b-cda6-400f-b28c-4d1b9b244eec@amd.com>
Date: Mon, 5 May 2025 17:59:13 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPC drop down on AMD epyc 7702P
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Jean-Baptiste Roquefere <jb.roquefere@ateme.com>, Peter Zijlstra
	<peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Valentin Schneider <vschneid@redhat.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com>
 <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
 <CAKfTPtBovA700=_0BajnzkdDP6MkdgLU=E3M0GTq4zoLW=RGhA@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtBovA700=_0BajnzkdDP6MkdgLU=E3M0GTq4zoLW=RGhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: bfed2a28-5c6e-4d9a-464a-08dd8bd0758f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDRDVkhCNm40aERscWwvZmhySSsrUWVCRVNyWFp0b1NkUUJlT2J6NGRDbGJI?=
 =?utf-8?B?WktvSjN6bFZwRGt1Q3pmM2lvQ2cvYWxDcDJtNDBaZWFaSEhmUkl5Ty9Qem16?=
 =?utf-8?B?Ym9UdlhxbXlEbUVpenZLYmU4cFNkK25BWmFjNzJYdE5IMTkxcHhvcnZKWWpZ?=
 =?utf-8?B?UW5NaVlUeXB4UWJid0NLdTFqZ1NUbnV3QjFaaDVYbFVYUVdqcm5HTnJHZjNm?=
 =?utf-8?B?dGFxbXNEbEhZUjFtMTVkcnlTZ2xCMEZWbUNpU3c5SjZNUTEvOTIzakJBSWhU?=
 =?utf-8?B?ZTE0d2MvSzhaRUtoUVpNVlpsekJjQklVUHV4L3JPaEE4a2N4RGZNcG9KVjZS?=
 =?utf-8?B?K3N4VnI5cFQ0Zld1NzRYS3pSemh2OWJFc3crcTZ0d0w4NW44bGU1OXBLVGFJ?=
 =?utf-8?B?TmdCMVBKNGxXbmk5K2RhRjk3QWdwbkxoVWkvc2FLT09KSlJHM1pnTDdnS0Nj?=
 =?utf-8?B?UlNRdVp0Z3NGSzNFbFMyS2t2QmdSUjQ5a1NmeUVJampTUkhxSlFMZnBaWjlh?=
 =?utf-8?B?cWh1TkpCQ2h1QkRZN3ozVXEwMXZRQTBuak5ZUTYyQ0xJOURqYm94RzVjUmYr?=
 =?utf-8?B?M0lxYkN2SENKZmhib1JuMktxZGhEQ2VsS2lkNHMrYUE5Um1MaVkwSXRxNEEy?=
 =?utf-8?B?S1owSnJma0VrWTJlSXJuU3RJSzFNZUU2RmdBeWtOOFNxMDAwOWwxalRGN05O?=
 =?utf-8?B?V2RTaTh6MncyVVNvOS9ZNkRRaFFvTjhBZFRNeGxyODBTT0ZpMGdhYVhSZkZT?=
 =?utf-8?B?NUs0RTd0NUQyRUsrQkx0blgxUW42MnhvSWs3Q3E4M1h5dEh5SXZsWkxqdHhy?=
 =?utf-8?B?cVUwRHRkaDQrc0dCWmk1dDFHRWkrNlhrdjdNWFVBcStaM3NjOTNIYlhWUXBJ?=
 =?utf-8?B?T25Bd2N3MXVQZkdZb2NlL01BOGpRcys0ZkdySkhxSm5WdldvK3hPOVpUcDNv?=
 =?utf-8?B?QTY4bnZxUVZSVnBKeTI2bmsvNXdsdEdJb00zU0pOZjJaUkxFWSs5RnMyNFpK?=
 =?utf-8?B?ZTF0ZmVmcHROK3Y5RW9mVGY0c3Q3UktXOXpJcjViZ2FOdjBwQ2FzeHNPNnp2?=
 =?utf-8?B?VU5xSUxiTXNJUEVBeVZsRklzeUM5OEFFVy85ZzJTUE94QlNrQUYxdzhKVUZ5?=
 =?utf-8?B?eURHbFQrQnQxM2FrZys3eFlsODdJL0hPQkFSN2VoRWk4bVEwdmQva3FWblZq?=
 =?utf-8?B?cGlhUXVIVi9oNGt5Uk1BODM2V3FRamlxTnlyeUU2VElvT1czcTY2cFVZNDdM?=
 =?utf-8?B?aHBHdzdzZzFDdFF4aUxlSTRaSUdFK3ZyRGJjajJQUFdhL2NQS2tzblJxYVRx?=
 =?utf-8?B?a0VYR3ZYdjNQNHhqMDdUZnhva1QreVRBSjRudGFONDVXeDVOdmFSWWRraVZ0?=
 =?utf-8?B?VmRYOVNhbWtXVmZUWHAzbVRhV0VPdzdnaW1pWWczd3VLN2ZDbFZOZldpR0Vq?=
 =?utf-8?B?ZzNGWnQ2dXpXWmVpdlIvbnZiU01ERGlOYXE1dE1vTHhqYW5WN04rOUh6c2hi?=
 =?utf-8?B?a3hKTG1FN3VzNGRVRkFic3Q3UHdOb2g0MWNWNHB5aGJJOE93ekNxTXd0RUU2?=
 =?utf-8?B?THB4VEQvU3ExOTExeTg3NmZsblRUOXozMDNjMEJLUUFoZkQ5blR1dktlY28v?=
 =?utf-8?B?c3NyMmZIRHlpQXQxaGNDcFNHdDVmVk1meXdJOWpvZ1ZQTW9qc1dubVV0b0t5?=
 =?utf-8?B?cmdOYzZsc0xEL0hPaTdtYVBuQzhzNFd0VnV4RXg1bzlITlZ4TVFDZmxjUkto?=
 =?utf-8?B?Tm5uWEplRG1wQlUvTFRIcTFNYW5uVTV4VXZKRGthN0ZBUVUwbE1ueEl2dUtQ?=
 =?utf-8?B?M0NXVWVmb0Y0TnRRa3QzS1krK292US80MjZ5Mk9vTlRQWkUwTGdPN3NqUTVz?=
 =?utf-8?B?WTdwMnNPd1BDZ2NYdEhyMExRcWFwek5FZXJqVGRKU0dWQmFWNW1zdk4rOEh0?=
 =?utf-8?B?TlBnN1U3TnFmanZvVFVJRVYrOCtnbFFkMWlJNjBxTUMydG9KYk5pNUpzanFM?=
 =?utf-8?B?dTB4d0s4bWRsVHBsWTAxaEpFMTlwT1V0b0JVUFViM0E4QXRlTkhtODBBOENL?=
 =?utf-8?Q?3KWzuN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 12:29:19.7601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfed2a28-5c6e-4d9a-464a-08dd8bd0758f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223

Hello Vincent,

On 5/5/2025 3:58 PM, Vincent Guittot wrote:
> On Wed, 30 Apr 2025 at 11:13, K Prateek Nayak<kprateek.nayak@amd.com> wrote:
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
> commit 16b0a7a1a0af  ("sched/fair: Ensure tasks spreading in LLC
> during LB") eases the spread of task inside a LLC so It's not obvious
> for me how it would increase "a lot of CPU migrations go out of CCX,
> then L3 miss,". On the other hand, it will spread task in SMT and in
> LLC which can prevent running at highest freq on some system but I
> don't know if it's relevant for this SoC.

I misspoke there. JB's workload seems to be sensitive even to core to
core migrations - "relax_domain_level=2" actually disabled newidle
balance above CLUSTER level which is a subset of MC on x86 and gets
degenerated into the SMT domain.

> 
> commit c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
> condition") makes newly idle migration happen more often which can
> then do migrate tasks across LLC. But then It's more about why
> enabling newly idle load balance out of LLC if it is so costly.

It seems to be very workload + possibly platform specific
characteristic where re-priming the cache is actually very costly.
I'm not sure if there are any other uarch factors at play here that
require repriming (branch prediction, prefetcher, etc.) after a task
migration to reach same IPC.

Essentially "relax_domain_level" gets the desired characteristic
where only the periodic balance will balance long-term imbalance
but as Libo mentioned the short term imbalances can build up
and using "relax_domain_level" might lead to other problems.

Short of pinning / more analysis of which part of migrations make
the workload unhappy, I couldn't think of a better way to
communicate this requirement.

> 
>> "relax_domain_level" helps but cannot be set at runtime and I couldn't
>> think of any stable / debug interfaces that JB hasn't tried out
>> already that can help this workload.
>>
>> There is a patch towards the end to set "relax_domain_level" at
>> runtime but given cpusets got away with this when transitioning to
>> cgroup-v2, I don't know what the sentiments are around its usage.
>> Any input / feedback is greatly appreciated.

-- 
Thanks and Regards,
Prateek


