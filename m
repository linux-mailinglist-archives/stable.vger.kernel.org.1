Return-Path: <stable+bounces-185756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F39BDCB94
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 08:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2ED3C8138
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 06:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB36303A02;
	Wed, 15 Oct 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eOAmWuIK"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0B29D26E;
	Wed, 15 Oct 2025 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509651; cv=fail; b=abWbTA2AU2YJPipB8iesualdOho4T7jcKX/oTbkl1WMv2kVJuT+7LPa4jsPYvneM5t/LjhQ+hQYVJ4tdZYXQsmBcb0EuysuSB8Vm06wgkSd9L7lyTjr5GP0okmkk295uHJAFT9I9vRYYnQGjoq2m7kMGZwZxK8AKl2Mk5J0HKLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509651; c=relaxed/simple;
	bh=tBmflYVQ3OYbaC4Xj4Gyl4kmbkXzBsJ6VTHIgIomcWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bs9xZ7CdlEe1A6+zgBNgRaKkAtZbkNCEo/LFlGOy4HgfZqpzF2du7S618IcUmDNGgwgK8za604YnVvwAHyF1cGuYjB4kEpaJgP1DVHzcESV3HJupMVYc93IFaMoBsAo25h3kXK5A7WVLNWjJfSaRJad3BZAXlC/3gEIY/7hAqeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eOAmWuIK; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhPBAWB01U6wGlQV03exkKq33ti8rVbAOsis8PzxMZr7B2qjjtE+XjXIfUbWqwfUOji5iZYMsZEfr5/NOnKrvU0XpAK8gfIBgCrqVu6ohKbd+nN/KKSZCBDtxmqKDWnnm3plHo8wbZRWHPqIOBsLhwTBA6TJFC4kJBvOrgCNZDD5XSaIy632dtznN2oKN3kLnhtJ6o34Blkq2GQ+MchI0vguwMZDPEccyPSLH7ad6NQd778mZkwDj4Ar26R/tWmGi+AQcixbTddQo1QhDnFwM4EBsBsBK5ZYF0UZl2OcbWerW4EZF2iR9BRmOmWnORqSCe7g3IHF9tjbqmM9KSFxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5U97JVDeJ8BFOj3SpWqYyCaslwkcG6gV/ZxXWSYAPl8=;
 b=VGwtwZZAsU2YxHlU0hSaa2hb8mpOT8ApmDmMR5mdgBpX5/CJwBd8Azp8xEU2q8NfRieevS8tqNsFKeLLczXaiCtOZPmuIxVlZH7SbiDgP/hwQl3UPNTbx/7A6WYrPWn9fNJt3yMD5NMJ07Jbi5LpCE3jvKaKX+I1JXDEKdt14vJTEcICl3cZ9rOXt3BsTwqv/Q+OBoQyzuYjpwPeLz4qJIA0eRLwS2nDAoTNRcLiNZXJU7PnAb0zHMNoXP5ehNU8Q0G6XY7+4aVwuGODsbBZMs1eZZn7/lsdIxbTFk49rgOl4D74yY/SDAFvOb2uwqgI1/wH+ohj8xwDrBmt7DTZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U97JVDeJ8BFOj3SpWqYyCaslwkcG6gV/ZxXWSYAPl8=;
 b=eOAmWuIKbKWmvYeUvzqmZZJF4zER0s6v7QDOxArT+YHFPJUpzfytgT9UGY6nLJmFp+nw77Xt81gsjOwTPphhKDVNABiSfNqY5NKXxJ8CyM4tIUHeU0meB3TLqQ892eMAE+hVFSBt2pXnwQES++eFQoo+632ISR90m7qXfLrvPUQ=
Received: from DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) by
 BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 06:27:25 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::73) by DM6PR01CA0004.outlook.office365.com
 (2603:10b6:5:296::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Wed,
 15 Oct 2025 06:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 06:27:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 23:27:24 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 23:27:24 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 23:27:20 -0700
Message-ID: <fe9320d4-9da0-4de8-8e1e-ec03ecf582a1@amd.com>
Date: Wed, 15 Oct 2025 11:57:19 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.12] sched/fair: Block delayed tasks on throttled
 hierarchy during dequeue
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>, Matt Fleming
	<matt@readmodwrite.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, <kernel-team@cloudflare.com>, Matt Fleming
	<mfleming@cloudflare.com>, Oleg Nesterov <oleg@redhat.com>, John Stultz
	<jstultz@google.com>, Chris Arges <carges@cloudflare.com>
References: <CAENh_SRj9pMyMLZAM0WVr3tuD5ogMQySzkPoiHu4SRoGFkmnZw@mail.gmail.com>
 <20251015060359.34722-1-kprateek.nayak@amd.com>
 <2025101516-skeletal-munchkin-0e85@gregkh>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <2025101516-skeletal-munchkin-0e85@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 88716db4-f92d-4d20-3ef4-08de0bb3e823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nis4SzgvU1lTd2ZjaHd1Wks5cHo1Skt0QURxV0xJZVp2aVQwUlRscHJEcEJW?=
 =?utf-8?B?RERPaEhJa3F6OWQ4Y3V4MkxWdXFGZjd6aHI2SU9UUGQ2eUtMSUhRd1pwbzM1?=
 =?utf-8?B?YUptcmhXL1R6N1pJTHZqNyt2Rkd6R1BBNVpOc0p4eWo1ckdnUFc1Z05ma2Q4?=
 =?utf-8?B?ODB6eGRUSXN6WUw2YkI5RjlPSm9CZUxRcCt1VWdhS3c2OVB3SjhhQjJCWHBn?=
 =?utf-8?B?N3BPOHVFZ3hSMThrbVlQcDdaMmI2UHRzQzNEWGtQcnZkTThKYTdoNmVkTkxT?=
 =?utf-8?B?eGF3dHBaZUxoOHpmbVRPTC96Y25MMVlrVjVtSlpZQ1FMVnQ5NTBndm1sUklS?=
 =?utf-8?B?OSs5TjRNNU1lYVFabnR3QXhGbEhqeHp4SkdYNXFhK0lQTXlSMVBsRjBqOXJU?=
 =?utf-8?B?Y3lkWHlxREgweFpJNVlJS2VZbjdTVGU5VUVFdStOcCsrS3lHN0FLTXArcFVu?=
 =?utf-8?B?Rk9vMGFPWGYzM3V2QWJkL2VSY1RBQ1RnQlhMQ0FMejF0WVdicTBlVGtZOVpK?=
 =?utf-8?B?eGVNaGV3ajh4VnJ0TUlCWU81c0EvRWlrVXMrRG9mU0NsRDdFaDF2VlNlaVpD?=
 =?utf-8?B?VVNDWHg2M2owZlQ1bTllWVo1VmxJMis5TjlIa0dZMDgzYkxqTmYxNS85N3pX?=
 =?utf-8?B?WFl0aU52SEZzNEZQUUlCdTZZeVlwZTNYVEhrRk9MZUxjd0pUR3FtRWhxN05o?=
 =?utf-8?B?R3BPZXBoZmpvS2hkaklpQ2NSYVI2cUFybVdWZ0hvSEhSQ2MxOVM1UjBpQ1ll?=
 =?utf-8?B?UmNFS2lkN015RUQvclVsbHBVdVVRemdNOFNaWmNKRmtla1pkd09KaDVRM1B6?=
 =?utf-8?B?dlBDSkpvVnFoZmVjWjg4MkwvTGh0VW5CZk5YY01QcjBuVDhndVlyd1hWV1Fw?=
 =?utf-8?B?TWxxMkNZRVVuczhMWEh4M0NWaWRXK1d1UktoeXovekhxY3RGNk04UnNMQlRo?=
 =?utf-8?B?OFM4bDVwUENEcC8wMkd2N09NMFNnajNuWjkvd3JPVWZ0TUtCZkE1d2ZXcFlM?=
 =?utf-8?B?VHVRR2Z1OHkvZExORUttMThUdFdqMGZydXhYVXE0d3VhM1J5ejFXaS9QVkRB?=
 =?utf-8?B?WC84TlVzNHNUQ3B3U2dFV0F6SlM4V3ZOVXhXTG9FdiswYkVTSm5UY2o2VlZW?=
 =?utf-8?B?QzNjbEFIZENoUWZwZGZDRHVvbllYajFLSFZ6dC9FV0hWN3ZWUEFVV0J1MVJC?=
 =?utf-8?B?RzlQZEsvVkpUNjZmVWxqRmR6K1JhUWF1c1BOWUcvaktJMXZpcmF1ZzhlSTZj?=
 =?utf-8?B?a0M1Y2tMbWRUVW9Nc3l0dlh4REV2YTB5dmtkeThVUk0rc3NlZ2kxdmRBa2xO?=
 =?utf-8?B?dFQ4WWN4SVhpbEx1UXAyNUNRMEREd2xjY0xDSFpXeXFNc095R1lmb3hpOWhn?=
 =?utf-8?B?Z3kyTkpkSXVvOFpLbzFwS1AyZ2VBTVF5TXNUSDczaWNQUjJ6bkRCTmkyUjc0?=
 =?utf-8?B?bHVLd3lGbzJDT3N2UHNKc1BRbnZyTnl4anVkZEtGc3Y0ZVl3RzJjZEtuZjZk?=
 =?utf-8?B?MXRFKytuV1J4clQyVjlvcXFDejJ1NVpmNjh3K3lQQXBPQmd0SDV6V05BazJJ?=
 =?utf-8?B?bkN3cXUyZi9ZWGVHMEFtNWxZUWtHM2hUaHFBVHZwN3JCWkNsWmt3ekxxZE9C?=
 =?utf-8?B?ZEJFblh6Um5wYytlQUJGUUdhd3lZdFl3VFE4VkphWkpkMDZUWTgyRjVpazB4?=
 =?utf-8?B?aWxsN2xiTjBQNUo2cVNsRnJxOGxpeXFZbGlLTXQrR21INkgyU3lQbE9wRjh5?=
 =?utf-8?B?RmRKSk91MUlQa3g4amRuYTd4WmQrS3RTcEJGZHpFbWM0bHY2R09haTZoeWVU?=
 =?utf-8?B?aWpHMWpmR1h5UmtzSzFVeVdqZWVYMXhxcjFJQ2JJc0dTQlAzb1JPTWsxMTFS?=
 =?utf-8?B?YlYyR3czazEwVEo2RDYxNkxOcndrODJQbTZkS3FBTTZRVHgzUEFKYXJwWWRR?=
 =?utf-8?B?bWJVWDJpTHBHMFYyRWtqSDNGbFJGdVBqVzFNMDA2RjdoRVpYVVBGTEFhQ0gy?=
 =?utf-8?B?YXdRYWw4TEY4NnB4ak0rT1FPMHh0NTl1L3I3bmxVUEJkcm5JdEJ6SVIxZXNm?=
 =?utf-8?B?N2EwVFpYMWdreTlCdHdLeGw5eWhnTktjeGYvNTdTVXJMVnVQTU5HOEdnMmg2?=
 =?utf-8?Q?SrlI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 06:27:25.3978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88716db4-f92d-4d20-3ef4-08de0bb3e823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801

Hello Greg,

On 10/15/2025 11:44 AM, Greg Kroah-Hartman wrote:
>> Greg, Sasha,
>>
>> This fix cleanly applies on top of v6.16.y and v6.17.y stable kernels
>> too when cherry-picked from v6.12.y branch (or with 'git am -3'). Let me
>> know if you would like me to send a seperate patch for each.
>>
>> As mentioned above, the upstream fixes this as a part of larger feature
>> and we would only like these bits backported. If there are any future
>> conflicts in this area during backporting, I would be more than happy to
>> help out resolve them.
> 
> Why not just backport all of the mainline changes instead?  As I say a
> lot, whenever we do these "one off" changes, it's almost always wrong
> and causes problems over the years going forward as other changes around
> the same area can not be backported either.
> 
> So please, try to just backport the original commits.

Peter was in favor of backporting just the necessary bits in
https://lore.kernel.org/all/20250929103836.GK3419281@noisy.programming.kicks-ass.net/

Backporting the whole of per-task throttle feature is lot more heavy
handed with the core changes adding:

 include/linux/sched.h |   5 +
 kernel/sched/core.c   |   3 +
 kernel/sched/fair.c   | 451 ++++++++++++++++++++++++------------------
 kernel/sched/pelt.h   |   4 +-
 kernel/sched/sched.h  |   7 +-
 5 files changed, 274 insertions(+), 196 deletions(-)

And a few more fixes that will add to the above before v6.18. I'll defer
to Peter to decide the best course of action.

-- 
Thanks and Regards,
Prateek


