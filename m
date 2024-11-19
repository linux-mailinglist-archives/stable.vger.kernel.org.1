Return-Path: <stable+bounces-93926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A279D2032
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 07:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4BC1F21DBD
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 06:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A848155CBA;
	Tue, 19 Nov 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="41eZpGc6"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45D14D70F;
	Tue, 19 Nov 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731997512; cv=fail; b=r52S6TrZP/Qugbt/EsRM0X49YWTmoxnz/pxLxJ7X5inoslIKGKUnwYbAVMyXVPRSBMz+hKMxb7vrZgLW7oR4k84JGT8zLvOPwEeuY8pBCGgNJdz3NsFqOGbjRgONjDtQv4743wzzq0jB0CX3wC7uk2UHCKletE5CjbjbFnnZ6y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731997512; c=relaxed/simple;
	bh=KrTePBy5KmT8DCUUby98RtkzM2w4zS5qmb27jMgu76o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LnsTSDoWp6WJcf63JUSkhGniQ9mLUWMOaTgfHIbXcNAUEp3HS/02UZnAYYk60+w4w6L6Jx8FIaHhiRYwB0jjNGqM+FR9kXhhjzNA4fFs74lpfazTA4DqHJ+zgpCVRhX9bwbbd4aUl9yCVbjzdgiyb4qN4LlITPp9lL1AzaN0NfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=41eZpGc6; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmiT0oPY3vGtcKdX+gH4AYUR6xKhFhmfO8TC9C1B7yRvdo5sJPbR/sfiwh8j0ekjDDXbEUQVUQBQUd/nqC9CiBXqBbuT4aYyzxY8ZVGQiHyD1r/ZmTNc3e/PwpwOEuj9yw5rcuEh0qb2KLTRifDv4PU3O83Qvlv5eVZgzgNCSXwkPnuOwHavZbAB6YvaaVPcbxwwccer/QOj7nrInoexg9FLq1xnuSb+CLBb5KgsgElGBLhrJxEdMh4j+TZEjIVe+OoPFbYMRhIr2RhN7xfP/b1LoyqC9+5m+V7aCn5+9NvtFmbHL48ijtRTbE/pEQrl9DjF68GabIkgJNaDq6ySbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SiSwn70BwbvlMkx4WThYRv9FXs9qf3HRxjgwZvZDmw=;
 b=YXJG6ySjMlwo1TJ0NfFpJ4Fta2ESBQrDberQXja+7uP3oa6UDDtLXTZl2QpEEhj7Vq3L1qnQznAofSy1wdeXE23jQTJRxcz+6/IgQhpvi31JyJzgf6E5DSmH7EAFSdIcHPdjTir2L+kJebvZ8uGjJygNolJwBhJXTCMS0KqwUI/B2mn0BbpiwCnDk1ZEj8Lm55RQzFlTLfny52eG0QgOquNIoeaonT5fOkPOFnyUolAU9kpvdUDFcKQ1GnnTGKJaK46P43IosAGc7DtXDhUGWlH2RsZ/046Sg3jhgkPxL7uowZeI467+LWUpFzOc49tMOFLZZbgz3opikp1VBcEE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SiSwn70BwbvlMkx4WThYRv9FXs9qf3HRxjgwZvZDmw=;
 b=41eZpGc6YQzEn0T+/eqNzq1qFobqJgAczZwBQBLd6clUrkKEeJlVa+dz0KfO8OTQx0py31pRAznymNbOTeJ78PKPm3IaIrlm6KYE3c0JKoTjOy+kpooN3Xs/SVww4rbkw5dbN6CKnJijzn4h4KN9bfmHeWluR5VGkodsSoab3hM=
Received: from DM6PR02CA0154.namprd02.prod.outlook.com (2603:10b6:5:332::21)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 06:25:07 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::eb) by DM6PR02CA0154.outlook.office365.com
 (2603:10b6:5:332::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 06:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:25:06 +0000
Received: from [10.136.38.66] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:24:59 -0600
Message-ID: <1e4c0bda-380e-5aba-984f-2a48debd7562@amd.com>
Date: Tue, 19 Nov 2024 11:54:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] sched/topology: Enable topology_span_sane check only
 for debug builds
Content-Language: en-US
To: Saurabh Sengar <ssengar@linux.microsoft.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, Steve Wahl
	<steve.wahl@hpe.com>
CC: <stable@vger.kernel.org>, <ssengar@microsoft.com>,
	<srivatsa@csail.mit.edu>
References: <1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f8e784-4ecd-4aeb-1d4e-08dd0862e915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlNYQ25IaTlmZ3lmd0dQNmErVjQ4YnY0UDg5ZTVtcCtrWVFlTEZLa0FtMU9E?=
 =?utf-8?B?d3JKMFNhNjRUTDBNOHdiRWI4a3JnWDJUUk5OdFZxWU5JalZwd1ZwZTdwZ3FU?=
 =?utf-8?B?dUh4ejZYaXVmbkhTQ0Rwd1dqYXE3dmdqMVhoeXRSeUk3VTlVOVNQOHNKeXZw?=
 =?utf-8?B?ZWZvQXBGQ0ovQzNKbm9KOTdjRVMrSzNJUjBjb2VPZlNxTUhRbjR5cllSL3hR?=
 =?utf-8?B?eDU5LzhsWmJRYVZNUkdSL21xNXpjek1UN2drUzRHTklHVmxWY0lWc3d2T0dw?=
 =?utf-8?B?YUFDdXlKQ1BhV1BpL05ZbkFzSkY1ZUpLbWlDUk9XaE1oK1I0RUpETkRjNDdP?=
 =?utf-8?B?aGEvQ1Y3d1k0MXlCd28yMW5Way9aQ0V2OEszMHl6N1RSUEl3QWxxRmNBakEw?=
 =?utf-8?B?RXo4VmNoTi9ycSt3L2plbjlSc0VQUGI3LzJGUitsWnljeTRjWE84eTRjeEM3?=
 =?utf-8?B?MHZQMFE3RnQ4a0NYbVpOMGF3SC9pYVpoOXY3OTNNYkJLZmxBWTd3TDE3RTda?=
 =?utf-8?B?WmxRWE5GbGM3TWlaNXZXVTM1OTk4UVoyYXlIc1JkWmtpSnZncUtpa2VWZkJt?=
 =?utf-8?B?dUJTbHpUWGdFLzdJRldUbjZRT0U4K012OFJUTWxTUytVYjBqNmRxVGpGQXV4?=
 =?utf-8?B?Y0lOWWZlMnJ1T0loM2oxWW1FVy8rcytkNjBmV1ZsbjlnUVNBMEpSd2dkbWpU?=
 =?utf-8?B?L3RKaTRiWTVTMit4bGNFMFIwcVJCN2E3U2JLTExHS1dwM0Q4YVUxZ1NFaStV?=
 =?utf-8?B?NDNKMUFrZ0wzNWtsQlRvVkNzSE92TzQ5VUYxdGJtVElRSVc4Z3FrRnZGemFp?=
 =?utf-8?B?OHBKRnlVcGNBMGxaUHduV1c1a3AzTFp4TlEzQU1OV0ZkOWNnK093QXdQQklq?=
 =?utf-8?B?SDhKMHo3TWR4YWdwOGdlNGVRbGFEdlZlRENpVWNMcDRWWCtab0dHOGpjUUhs?=
 =?utf-8?B?em5mRVpyenZxeU5SU1ZNM25HbFRmRmhCQ2NpczY1SGViOUZTY1BFMGNwMDVu?=
 =?utf-8?B?SkhrN2U5RzluZjNQdktTYll4TVppUlZ4dnQxdytTL0s4VTkzaVhUWkJvZDUw?=
 =?utf-8?B?Nk82S3kzeml0WncvR0hXR1pJU2h4eDVSMEhMcGhqT1FaOVoyY0VFZ0t0V0po?=
 =?utf-8?B?VnF4NlNLVHV0eHNZcFpaREpEdk1tdXFQSUQ4MmtUejJCbHZVL3o2aEVxclIy?=
 =?utf-8?B?bXFNNmMvRmtObzVXTDJTTEU5cmdBbUIzSnNUZ1o0SVk4RmIzN0xtV2Z6VVhr?=
 =?utf-8?B?NHNsUjlaT1N3cXA1SkFGK3JmQ0cvR1FSY3R6TlFUNTdvMkZXMlp5c1g5VjdF?=
 =?utf-8?B?STloWEVValdFbWQwdkd0NGFRWDZxV0lLYU10dkxqSWN0ZWs4a2ZDVi9aNGQw?=
 =?utf-8?B?UGFjSEFQNzNneUg5cTNxRVowd3l6cHBRTzViWmhyUjN6bFovQ2hpWmxYVHRE?=
 =?utf-8?B?ejlaOWhCR3BZRzZRcnhNRzRkcFNFQ1RBMFpNMmdGMjRXU2hWTVpHNTE3cXJa?=
 =?utf-8?B?a0Y3bnF5SmNUNk1yZUUwdUZ0Y1VsWERiQktPYUZ0anR3aithVTFqUkRLeVBo?=
 =?utf-8?B?OXBKZk5JQm9KRVBHOTd3YnpDUXBSZFZaRjJEQUJzRk53TUFNMGpIbWZpa25G?=
 =?utf-8?B?bks3R2NTN09aR0NLRVpqdDJHVEF6Z3UwekRqUXhTVHk4Y0lkZGttQlNIQWIv?=
 =?utf-8?B?VGVCT0t4VVQvRXI0T29hZ0NOUGtsV1pvZmpPKzBYY2pqaWRMZ2g3MkRPZlJQ?=
 =?utf-8?B?a2VYM0hBR3BweXk4VkMzY0RxV1NnbGxnM0FJVnNRNjV0dlRWaFE2cVo0TkpR?=
 =?utf-8?B?T3JKYmRpWTNYNWRpNHRJUFhVQzZkTFdRTzl4YXJXdVAyM05WMUFud2RKdmFM?=
 =?utf-8?B?NUNXeWhsc1l4TGdpcFRxckp0RnBGeEtZbnUzMkllOE9JdlpscE91dHFpOWFi?=
 =?utf-8?Q?MNEpvcEV0SMGAeWFo8EzlvOYr6Z0rSzI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:25:06.4583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f8e784-4ecd-4aeb-1d4e-08dd0862e915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

(+ Steve)

Hello Saurabh,
On 11/18/2024 3:09 PM, Saurabh Sengar wrote:
> On a x86 system under test with 1780 CPUs, topology_span_sane() takes
> around 8 seconds cumulatively for all the iterations. It is an expensive
> operation which does the sanity of non-NUMA topology masks.

Steve too was optimizing this path. I believe his latest version can be
found at:
https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/

Does that approach help improving bootup time for you? Valentine
suggested the same approach as yours on a previous version of Steve's
optimization but Steve believed returning true can possibly have other
implication in the sched-domain building path. The thread can be found
at:
https://lore.kernel.org/lkml/Zw_k_WFeYFli87ck@swahl-home.5wahls.com/

> 
> CPU topology is not something which changes very frequently hence make
> this check optional for the systems where the topology is trusted and
> need faster bootup.
> 
> Restrict this to sched_verbose kernel cmdline option so that this penalty
> can be avoided for the systems who wants to avoid it.
> 
> Cc: stable@vger.kernel.org
> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V2]
> 	- Use kernel cmdline param instead of compile time flag.
> 
>   kernel/sched/topology.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..4ca63bff321d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2363,6 +2363,13 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>   {
>   	int i = cpu + 1;
>   
> +	/* Skip the topology sanity check for non-debug, as it is a time-consuming operatin */
> +	if (!sched_debug_verbose) {

nit.

I think the convention in topology.c is to call "sched_debug()" and not
check "sched_debug_verbose" directly.

> +		pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",
> +			     __func__);
> +		return true;
> +	}
> +
>   	/* NUMA levels are allowed to overlap */
>   	if (tl->flags & SDTL_OVERLAP)
>   		return true;


-- 
Thanks and Regards,
Prateek

