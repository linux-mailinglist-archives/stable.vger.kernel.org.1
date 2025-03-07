Return-Path: <stable+bounces-121405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED766A56C52
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45493AB7C0
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5496421D3E4;
	Fri,  7 Mar 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b2zsBtKY"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659952E822;
	Fri,  7 Mar 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362123; cv=fail; b=EBMT4ymbz1dwpMf1/A5BwS5vAzy2LYLglv0KmBLxFiTdPYZd83oJoJw3KFoEuunh9CyNnJUveHILpLVdILqI9oNuJ9jld2IH4gCPaNEPasW4FsWRgBCGcoPnLeoZX6syQv36twksf20n3bgEeBa1cPSIV1S8nbCyIM9JIvG8h4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362123; c=relaxed/simple;
	bh=zxVQDsrppz/Vp+z5SIAxphP+ySD6d3Qe1Du9v3haWH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qfGMKew6ZaQ6TMyEOhtZQHPuK18/Mga6DEFnLUnM2AZ1B+wfiSJPa4RQoDPfUibWFrKv0RDj/4qzJxxDMLNhXLIPiZ2++2n8hJLKQcq5q0qu0bZvlZdEXCM08jF6XZgOE/4bjeI0Gi7T9oSnmJAOGOC4GYZppuwyAlXqVDp+XVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b2zsBtKY; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADgnEjB3k9olE1DWfUA8rH1u4kDSTxVQXDt3jPzXwvoSglXgXfUCZozsjSPfC9KWoyuRd+EjTd/OxwmBo+P1beTwtKWxMKsoy2Jc35SOotXrQCXpGZTsq4y8mllfrC71UWHlkNg8rAzejDSGZR+uvrid9HiAopxau+r3Yj5FU1Ps3Yftq1aQ+iZ82nf9zdaNhqWXxtdjsdM/ZmrTgN6a2vMa82t4NE5EB1vESvFL8whctNI1Q5iUnkcIsKmvortHbF9meKg1ICKX/7DoOVsK2PaKDiM5ZAUeRUlHwCMiw5SkQVKaT+PWOzpHJ2ijzqmxD3ui9HO8QDRw9UScs7w/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hryHSDuWRCvlrZ7837Fe8lvojljV+wrLl+qv0d+LmJY=;
 b=UblT5wm0dQ9HS1FBTSTVTgfzfViBH4l5dWEwqe+nHkImDqapQfGhAnPZE9sTI7O9jcK0yGngY8rpTBdU16aWQz2xQ5CcdrAhxQoJ+2nrETA4cakMkTG5N7rv1123+1yGd65x8tbX1KU1kecYYnDnfdmfohPRPFJGf/knUTpKDlAT8a4I8UAzWvD13aVnpiAE/x6dDtenuRk8YHGoZx7l0d9Dqx8Wf+pbNy/s5B1b3V1/iwUeJH2zobjEgxtzB+CrnTJQTUeM+YYBjkbXdz/fQFwNYglqx8H1Ktku+f9qTGNIPaKzm5iLNnWH2LhJ+MW8KPzxtpcm95EN9/QK1OgEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hryHSDuWRCvlrZ7837Fe8lvojljV+wrLl+qv0d+LmJY=;
 b=b2zsBtKYux3Jt+Tc8ZIuqzL6sLqqiG/vGCIzlR00TI/xmh+tHRf0ig4SkihD3fdKiVeDHhsh61GQPrbSE7+60YhZKsTtonm8DlDgui+TbcbF4h8H8e85r2vh8MIYefHT1rD/Ce8LAK6gvZJkPsDDtZHkPf9gNSoPJngwrv3zUxQ=
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 15:41:54 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::a) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Fri,
 7 Mar 2025 15:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:41:54 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:41:49 -0600
Message-ID: <d033e4cc-728e-41cd-8fd8-616b2eb7709f@amd.com>
Date: Fri, 7 Mar 2025 21:11:46 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/topology: Enable topology_span_sane check only
 for debug builds
To: Naman Jain <namjain@linux.microsoft.com>, Valentin Schneider
	<vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>
CC: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Steve Wahl
	<steve.wahl@hpe.com>, Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	<srivatsa@csail.mit.edu>, Michael Kelley <mhklinux@outlook.com>, Shrikanth
 Hegde <sshegde@linux.ibm.com>
References: <20250306055354.52915-1-namjain@linux.microsoft.com>
 <xhsmhwmd2ds0o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <81b11433-58ac-4a2c-a497-d6d91e330810@linux.microsoft.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <81b11433-58ac-4a2c-a497-d6d91e330810@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cc4b5c-e362-4ae0-00ca-08dd5d8e9664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|32650700017|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3J0bDhIbVFvNjZhdnF3WjNTdHJhZE1TSkdubFNZWUZBSzJESjlIYkhUbDQy?=
 =?utf-8?B?d0FZSGtjajM1MXQveE1kNlAyNUt4QjY1c1RPM0FwRHZpZXE0NjRMQzdJa1VF?=
 =?utf-8?B?cDNLTXd2K2RkS2JoSXE2VHJRVGNySHlVWFN2bVdReHFiN0NKb3d1eVFnSmk0?=
 =?utf-8?B?ZXFmWDh4YTdVanlsZkJZYXNLbkduOHRaYndxZE84VG51S2NrdlBsRnlTWS9F?=
 =?utf-8?B?bWkvaWpiTkJLb3AwT29uN2hRUFFURUVVUFpoMWVsMWZwajFadDkyY3F2U01Y?=
 =?utf-8?B?dGduM2w5RVoyOHduR3k2MXNCS2R1R01pRG1MWWJPbFhFTFdFOEhEYXFvWHZE?=
 =?utf-8?B?YW1iT25sTmY1QWVQWEpVRGdlUmdBbWZVdGlSV2tvOWpWc1p3YkVEZU1jRlUx?=
 =?utf-8?B?aHU3SzlLcmk3V0xNREllcEg3ZlJOVTRIVVZaMHBiU3h6akFXTTIxOERRaUZT?=
 =?utf-8?B?Nk95VXZ4MW1jYmY4ODlEb2N5Uk1SSStibS93YWdaV1htUVRRa2Q5dnFyVHI5?=
 =?utf-8?B?SnNCQ3BlNkRoSk9PaDRiRy81Y2VDWFRhVXJWZy9ieml4ejhCRUlMamlrNTZy?=
 =?utf-8?B?SEgwa2dJQTZhcGQ2RzhlQTlVOUVvbHNDWTRBMk5IVmxNWDZQcXlvaklnelNU?=
 =?utf-8?B?TEdJckp5eG9KZWhGRmFZYTZrcHpWSkovWVJneXc1cVJmQTI0bnRWZlBRcVVL?=
 =?utf-8?B?WWEzYXJWNlYrSGFCMnFZbDJLMmpmbHJ6eDdyLzRBVE5meEZKdVYyb0hEZlpS?=
 =?utf-8?B?ZitGWVpaai9iL2FHbG8zQXZGWWhMWEQ2Rmp1UWIvclFoM0hwUnRhZGdDMzJq?=
 =?utf-8?B?QXcyQm5BNlVHelNqQ1ZXUDdaTnZVT3FJUDVmNEhpQzI2N3l5bzhIeG9HS2Nq?=
 =?utf-8?B?SEY5OVRHWkhmeDQ2N01kaW8xTkQzVXNkTlRGWkQzczJhSW9CT21za3dxTGtr?=
 =?utf-8?B?d1dRaGVCa3NnbHEycVRvZTZZUG1NY1A2UHMweVQyN1BFNHZtNGR5N1llQmpi?=
 =?utf-8?B?NHQ0TGM0NjdEdkhBR3NhVFVYWXgwODNQci9kWmZkeGRNMTg4THc1TnFSNytR?=
 =?utf-8?B?cW13ckIxbFFYU1RHeS8vV2tOUFRBOVdqZURSaWczWjRSSFlLRXFrdWpYWUJW?=
 =?utf-8?B?dGo1eVJLNVpDWFZ6cnowNzYwSVVoWTRVc0ErMmZCNUtMdUpSN3lWeXpZc0hM?=
 =?utf-8?B?ZHBjcEtySjBTa01kd011UE9QUjYxeGppRDBhbGszcjNKNmZLUlY1ZUkvU3VM?=
 =?utf-8?B?ZTdyWE5wZFh3TG9Wd0FZQlc2Tm16bWVMTk5jcWt6VVY3ZkRBcU9jalVzbDF2?=
 =?utf-8?B?Wk41SDhua1RJSWdjNExGZmNWYU9CQ1dSVEI0emJad20yR1I1SFFXT3NuVmV2?=
 =?utf-8?B?dTFKUnRvN0VSTnlmb2ltMHpXU0x1SjNRcmwrZnp3d1FQU09PR3ZNbjVhY1gx?=
 =?utf-8?B?bkhlQzNqa0RkWUdFUDZVL3VvdEc4Q0pveGdSaVRsYzVaQlRHaGFuWlpIUXpJ?=
 =?utf-8?B?ME1zSUlSZkY4S0hlT1RIOXVoeE1EeWtSMlFIM1Q1cCtuM2k1Vld3NHBheU0r?=
 =?utf-8?B?T1VQWTJGTGRYVnpRQ3pyK0RDMHc4b2ZSWFQwWXlsQVJFOTlBUXBsdEpiNmNv?=
 =?utf-8?B?UlVvOG9uRmorK3h1UnZlTjVoUDRwZUVGNndTQ1R5VVhQSS91SUJCbjVwZmM1?=
 =?utf-8?B?bU5uV2tiejNPRjVjSlArMjBrQy9ySmU0dnoxY3E0b1FEWk93Ry9ldjZDcU1x?=
 =?utf-8?B?TUdqQVlVcElXUkxGQ0hrRkgxb2dKdDhkYnZEeS91cGFnWFh3OUh1ODhvSXpU?=
 =?utf-8?B?VVFzN2pIMk93aHlaRm9QaWI3MXZpYUFjNTliUzFyeUxpa29XeVpFM3BvTXlR?=
 =?utf-8?B?NjZYSTdvRXlTdmJXRmZ0VlEwSUF5c1h4RTZ0cW1wdnBDMU4yRnpVYktEazNE?=
 =?utf-8?B?am1jNEd1Y1I2dGFxUERqN1BPdDBVajdUQVFUbVcxU3Fjcm5IbTEzdkkvci8z?=
 =?utf-8?B?TEFPNDNtSWJydjUrN0QxSXYraHBYNHJDMjhkbjVtSk50MkM0Mi8wdVdwRlVz?=
 =?utf-8?Q?ycwiND?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(32650700017)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:41:54.4791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cc4b5c-e362-4ae0-00ca-08dd5d8e9664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455

Hello Naman,

On 3/7/2025 8:35 PM, Naman Jain wrote:
> 
> 
> On 3/6/2025 10:18 PM, Valentin Schneider wrote:
>> On 06/03/25 11:23, Naman Jain wrote:
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index c49aea8c1025..666f0a18cc6c 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -2359,6 +2359,13 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>>>   {
>>>        int i = cpu + 1;
>>>
>>> +    /* Skip the topology sanity check for non-debug, as it is a time-consuming operation */
>>> +    if (!sched_debug()) {
>>> +        pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",
>>> +                 __func__);
>>
>> FWIW I'm not against this change, however if you want to add messaging
>> about sched_verbose I'd put that in e.g. sched_domain_debug() (as a print
>> once like you've done here) with something along the lines of:
>>
>>    "Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it"
> 
> 
> Thank you so much for reviewing.
> Please correct me if I misunderstood. Are you proposing below change?
> 
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2361,7 +2361,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
> 
>          /* Skip the topology sanity check for non-debug, as it is a time-consuming operation */
>          if (!sched_debug()) {
> -               pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",
> +               pr_info_once("%s: Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it\n",
>                               __func__);
>                  return true;
>          }
> 

I think Valentin meant moving the same pr_info_once() to the early exit
case in sched_domain_debug() for "!sched_debug_verbose" to notify the
user that sched_debug() is disabled and they can turn it on using
"sched_verbose" as opposed to announcing it from topology_span_sane().

-- 
Thanks and Regards,
Prateek

> 
> Regards,
> Naman
> 
>>
>>> +        return true;
>>> +    }
>>> +
>>>        /* NUMA levels are allowed to overlap */
>>>        if (tl->flags & SDTL_OVERLAP)
>>>                return true;
>>> -- 
>>> 2.34.1
> 




