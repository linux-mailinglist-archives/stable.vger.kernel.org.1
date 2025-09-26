Return-Path: <stable+bounces-181755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96B1BA23B7
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 04:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E5E1890722
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23A261B7F;
	Fri, 26 Sep 2025 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ka3loWHr"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD08414E2E2;
	Fri, 26 Sep 2025 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854601; cv=fail; b=Q4KBAtKPzut4RqUzPzLQArx3+4Pm7oOlkTzWqSvJTVb2qX/Sgk6ySpe82S3TjSATBTdFOKzt1YblcpyL+lZ9x/n8NNn3ttQs9s3KmXL6pogJM+jBq5gmBPV6OG5dC4FrcJrfa9DISQS6mlfBmPenBCbjvLmheQXkdQD0GCmApEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854601; c=relaxed/simple;
	bh=bW+dBhZ4ynCMMIh/Lczwiz4oP4fsNEgVlaVq2V6PoBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kmmuRhYtJg9BUbiBMQ6CZRPh3qOCaKXTUHLxKaBZb/QN1xHGgYTTHaY9tQCiLhvyVofzjBIKDY3a0+HqmnTsZzHw6w3dUxo5Cs5FdRuPIX1/H3YMMUktdBURmxy5PbQZQXIsaCF9XiVnZobdzrUzENUKEoOJeTcsZUX9PLHtpQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ka3loWHr; arc=fail smtp.client-ip=40.107.208.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYfKI3X9w5FrBJ9W6qfcYHieRyEzfIrcyCO9XPCWvFeWu/ioegMV6L0ZUSJ3sGwb3dnunwepVa1p5ZvM7u1nWpcG1renPXnap/pSFHIoiOFTktU5TeYE/FVhtT1XJSOq5madce7sPNJ0Cwvvk27haslA2+ncBMRPJL1/pnXnc3URwTxTWWthYoPeVqMO/p7p9N1bbTqmMcUUnjr2qOg61D74h6ObQZUjAZ891yNbQbpnBAukrOL1P9rCPS3K1+Jab4qKWRGDZcIRz4rDufA0QNQ4UbM2tfed7egKRrb8SWMujT9pJwYkkPNDrTK3tUN8PlpAYFpqRH6Bn0cuvGMlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ntHCoz7KSZ6vwGBeC7gw1wr+yfCwuMvRJNV3eG9qdg=;
 b=ujx0srLx0kofEm/bMl3vCZHyMexpJv8mBcVCsgY2FAv6yj/EUATNdSjsVplj3Pq9vL5CskjorQ+Mcml1G6cP6LWt8rz04haQAR99Z8DQCmuTyU5m5689oCXrH4AHg7Uos6NAUlQG9NTs4bGxlxpNFpCaIFJbO5+A7rFB9bSwP6O3Q+soo3cSG53NVI1zdvhM63SBu9QBy2omiC2XvoMRBiWZfqxkX86R3yzb08elKzzHbWajz6I0lKaSoWyRGo2+/Cj4GwomKOM+KkN50yfzX3heIEjyLxJMGVlCJ8UbZ5l6i0GZQB1gG0U60mIaU36HJvltlowxe/6VcVVXxesoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ntHCoz7KSZ6vwGBeC7gw1wr+yfCwuMvRJNV3eG9qdg=;
 b=ka3loWHrHmc5yEJKKbG8Eyc9ZuUMEzdCKZ+pA4QutbHM8HCxauQWMhVAJ3OOsANoPSA0NafOd7HhQhfiKgFSgvLaYiFNkt4TeurCTkG2Hcy1nYIGDEIc3iA4+8vYBJHmdULY3iIttFubsSZbuPDC9cbvcM7AcYV9dcxtbmPVd80=
Received: from DS7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:3b8::13)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 02:43:16 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::3b) by DS7PR03CA0008.outlook.office365.com
 (2603:10b6:5:3b8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Fri,
 26 Sep 2025 02:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 02:43:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 25 Sep
 2025 19:43:15 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Sep
 2025 21:43:14 -0500
Received: from [10.136.45.215] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Sep 2025 19:43:10 -0700
Message-ID: <105ae6f1-f629-4fe7-9644-4242c3bed035@amd.com>
Date: Fri, 26 Sep 2025 08:13:09 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "sched/core: Tweak wait_task_inactive() to force
 dequeue sched_delayed tasks"
To: John Stultz <jstultz@google.com>, Matt Fleming <matt@readmodwrite.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kernel-team@cloudflare.com>, Matt Fleming
	<mfleming@cloudflare.com>, Oleg Nesterov <oleg@redhat.com>, Chris Arges
	<carges@cloudflare.com>, <stable@vger.kernel.org>
References: <20250925133310.1843863-1-matt@readmodwrite.com>
 <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f249f6-4e7a-43b7-aa73-08ddfca671cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckNYWEFMQjJuWTZSUGpQVk01WnZlMjlkejQybGYxdytqbDNENmdRamRIQ3Zu?=
 =?utf-8?B?VkswR0ttSEVNK0hveVZySy9PVzltOUxZMUMySlJiZ0k3azZvK3p2Tzh5eU1J?=
 =?utf-8?B?RVdQczE0cU90TkxBUDVsS25UVXlKT3dxejdjdVRaWUhUU0dXR1NzYmtCNElU?=
 =?utf-8?B?R1ArVldIS0s1ZVE4eDJVTHRLVjBRZURDVm1Da3U4VVBWOFhha0pKWXpEZkRt?=
 =?utf-8?B?T3BqcldDUzNwOGQzUXdiYUlEY2RyajViclArMk1KSkpiSU1MdXdYTHV1VURz?=
 =?utf-8?B?ZjFvdTdKaG5ZZGM4aUdUNXcyeVFYMnBiU0JLdTRMSjlvQWpxUU00Q0wyMkRj?=
 =?utf-8?B?ZzRjc3BpQms3VEpiU2hFSWc1dlgvTEtQZGZmbnpnbUlFYUVXYjl6dlM3L3Ra?=
 =?utf-8?B?TGdUQkVMdm51bkFSK1prTEc1WlRSTjF1MjNvK1lSVTdhTjRmNk1Db21yNzBW?=
 =?utf-8?B?OHV6VUgvZnVOaG1QcE9RNUJGMkZ0V1BWYXhmblFXL0ltaUFoc1NlQU1VMmEx?=
 =?utf-8?B?MythNTg2K0VjZ0h6dEVTUWJUaVg2UHZtS3BnOGxDNlh4MVpXaUE0dHRnQzdC?=
 =?utf-8?B?YjFGRW1TakJSZnd5VHJKTG92SEtPTUdVemYzZnphNEpXSlNOTXpmbytCTTlH?=
 =?utf-8?B?MFRlajVqQ1ZIelVmbThtSTk1NlpEWUNoOHVJaGZKQStWdnRXRlZuWSsvMTRa?=
 =?utf-8?B?c0lPSmo5TmxnL2VHbTJUZWtDTkk2emNWWjhQTWVkeGRsak04Q3UzcDY0UkFk?=
 =?utf-8?B?b2RUbXRNUEh0SENNaG9EaUJqYjQyNXA0T25lZjhtaUxrbGVEUm5BU1BKTmx2?=
 =?utf-8?B?NmlENDdLMEtTWDNXWUZuQjdGZkE4TUlQbGN1YS9IbmFWdlMvZUQ0UG9zNkZk?=
 =?utf-8?B?bWxjcXd4TEI2Z0cxQm1VN3RrNTBuUEdWaUZqZXZ4b1BaYUV5TXlPV0d6Z1Uv?=
 =?utf-8?B?RllNbUhvalFTQUhkYisweFh6YkxxRlBGL3d3bjltZytXZ2MydFpSdDZGMWdz?=
 =?utf-8?B?cGVvRVNxbHhBKy9pN3pDZE1WNmJmSkkzdWF1c0JSY3AxWXRCN2ljZkVjbjRk?=
 =?utf-8?B?bzdSMVJXd09SRS9xa2hmd1g4MENpb3A4UkU2bS9xaFJQL1Jab3IwcmR3RDRC?=
 =?utf-8?B?MkZnVVRYSUs5MTVFZ2UvUnh3UEw5Q0dRdUtyakRZNU5oT0NvR3FHSGpHYnNC?=
 =?utf-8?B?WlQ3RnhONkIyR3NqVis4TFdnamQxbkpIUUhoMFA1ZVlkMFZVcmtrOWphbHdR?=
 =?utf-8?B?RmNXeTkxNVZBTUNWOG1iOGZrUjVFMzFDYzlTd3J5L3VZQnZlZ0dzTGNEZnd2?=
 =?utf-8?B?S0JXNUZGUy94bTh5OTI3Z0s1eDQzWHRiNTI1Q1huWU16QkpiUVcrYVNnTVA0?=
 =?utf-8?B?ZGZ5bmtZQ0hqSHh5bWRDOEduc0g4STM5TDY5eGNOcEFHRURCdmZvbXBjQU9G?=
 =?utf-8?B?Rng0eStpOW4zK0xJZVdzQStUbVV5alVIOVY4alhNY3I5VlVmb1g5eEVISTJH?=
 =?utf-8?B?NjVoVUFMT0dDeVB5ZHlhUGk1YzJPQmNVdmtjbUtndzFMY2tSdWlQeUVUS3Q5?=
 =?utf-8?B?WUFOdFdYN1FaZVE4LzBOcDZNQlpkdUpEdmpXQlV2V3IrY0dhdDAxc2t0Wjgz?=
 =?utf-8?B?c05Ga3pkMWVWcUpPZmJmMnNKek5JQW5yR1I0UmpHYTJFS1V1c1FmMUQvdlAr?=
 =?utf-8?B?QS9sUVFzd3dGNDB6Y0dtZFVmalhkOWtySDdqdEp5TUUvdWZEUk1pUkxxWGk3?=
 =?utf-8?B?KzBiMFNwQmo2QmtTUW4vL1pRS1RqQTRnVFpJaHRKOUFTUkY1R0hScUhoOEpL?=
 =?utf-8?B?WVUzb0dOWXF6MU5sUFBRc0R6OHcyNUtUNmd2cHhnYzNmaThJN3FWQ1I1a0hI?=
 =?utf-8?B?NU5ub3JiUVgzeXhDUFJ2aHF5SHo2Z0p6OG5FcUJWRjZrcTZ3clZwTDhZbFNK?=
 =?utf-8?B?LzZQSVY5WlRpWlZnajRHQkp6ZVl4MGxqMjZSM2J1U2pKZnRYMG51TWEvU2tw?=
 =?utf-8?B?ZE5GS3JmVFQyUjg0b2pMK2JyQjlKano0YWZVWk02YStxeXg1djRlTnZVU2Iz?=
 =?utf-8?B?SExhbjhUUk50V0ZMU2szVUJBZG9QZFBMc2pRVXFKcDBMS2ZvaGlWMUl4NGl4?=
 =?utf-8?Q?rUu8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:43:15.9673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f249f6-4e7a-43b7-aa73-08ddfca671cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116

Hello John, Matt,

On 9/26/2025 5:35 AM, John Stultz wrote:
> On Thu, Sep 25, 2025 at 6:33 AM Matt Fleming <matt@readmodwrite.com> wrote:
>>
>> From: Matt Fleming <mfleming@cloudflare.com>
>>
>> This reverts commit b7ca5743a2604156d6083b88cefacef983f3a3a6.
>>
>> If we dequeue a task (task B) that was sched delayed then that task is
>> definitely no longer on the rq and not tracked in the rbtree.
>> Unfortunately, task_on_rq_queued(B) will still return true because
>> dequeue_task() doesn't update p->on_rq.
> 
> Hey!
>   Sorry again my patch has been causing you trouble. Thanks for your
> persistence in chasing this down!
> 
> It's confusing as this patch uses the similar logic as logic
> pick_next_entity() uses when a sched_delayed task is picked to run, as
> well as elsewhere in __sched_setscheduler() and in sched_ext, so I'd
> fret that similar
> 
> And my impression was that dequeue_task() on a sched_delayed task
> would update p->on_rq via calling __block_task() at the end of
> dequeue_entities().
> 
> However, there are two spots where we might exit dequeue_entities()
> early when cfs_rq_throttled(rq), so maybe that's what's catching us
> here?

That could very likely be it.

> 
> Peter: Those cfs_rq_throttled() exits in dequeue_entities() seem a
> little odd, as the desired dequeue didn't really complete, but
> dequeue_task_fair() will still return true indicating success - not
> that too many places are checking the dequeue_task return. Is that
> right?

I think for most part until now it was harmless as we couldn't pick on
a throttled hierarchy and other calls to dequeue_task(DEQUEUE_DELAYED)
would later do a:

    queued = task_on_rq_queued(p);
    ...
    if (queued)
        enqueue_task(p)

which would either lead to spuriously running a blocked task and it
would block back again, or a wakeup would properly wakeup the queued
task via ttwu_runnable() but wait_task_inactive() is interesting as
it expects the dequeue will result in a block which never happens with
throttled hierarchies. I'm impressed double dequeue doesn't result in
any major splats!

Matt, if possible can you try the patch attached below to check if the
bailout for throttled hierarchy is indeed the root cause. Thanks in
advance.

P.S. the per-task throttle in tip:sched/core would get rid of all this
but it would be good to have a fix via tip:sched/urgent to get it
backported to v6.12 LTS and the newer stable kernels.

---
Thanks and Regards,
Prateek

(Prepared on top of tip:sched/urgent but should apply fine on v6.17-rc7)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8ce56a8d507f..f0a4d9d7424d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6969,6 +6969,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	int h_nr_runnable = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
+	int ret = 0; /* XXX: Do we care if ret is 0 vs 1 since we only check ret < 0? */
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
@@ -6998,7 +6999,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			return 0;
+			goto out;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -7039,7 +7040,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			return 0;
+			goto out;
 	}
 
 	sub_nr_running(rq, h_nr_queued);
@@ -7048,6 +7049,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
+	ret = 1;
+out:
 	if (p && task_delayed) {
 		WARN_ON_ONCE(!task_sleep);
 		WARN_ON_ONCE(p->on_rq != 1);
@@ -7063,7 +7066,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		__block_task(rq, p);
 	}
 
-	return 1;
+	return ret;
 }
 
 /*


