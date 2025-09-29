Return-Path: <stable+bounces-181855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB34CBA7E17
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 05:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F408178BE5
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73320C038;
	Mon, 29 Sep 2025 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nNG+ekFw"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1898F1A9FB0;
	Mon, 29 Sep 2025 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118003; cv=fail; b=Ihazb/oKRpn2/D3mxDD8eMNclzEKwTIt10IUJhr3LMl3D4A7geWciRHbVHiwW9WybwRU1yTe1Lx1Ug2MZcp1qm4BY4zV0k5NOJzK+f7WQlZXNhpYcHpAEEwJkJECRgOsVNaVddl+zBsRElZBeoB798wZoESeQMyVfbc/3cSEPw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118003; c=relaxed/simple;
	bh=DqT31DqOFvbGzxMlEEmRdAmg/dYzdnYD+D+XBLaNERg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j7N+0Rx2LWF7kyPMzLl2CwBzkmFkL1mU8rIoZM8HH5vtDwBp8snYQhYT2IjeUEgWePcF/G+CkjprbQvy7LtYtRP5EBxPYJd0m6D7mEnH7WNWJkB78joA2L+VNz7mDP9w2uIWDZH7Lc/ePYGeBOIvGbaaVMH5wTtV/zOuXM8h5m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nNG+ekFw; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qskLB3KYZvZjgB2tXdet/xKg+lWHulPeYJ1USEC4Rvb1Fwt/3Tnh9iCPc6DKralgkPpr8ofm0bo/cS/O+aNDoA84Ue7s84QkGoIoKSOjvI8RDHxvFw1s8c/1HKzVrFg+JHeO7zFJ4kN3h7KZbEZHRiRrgoBHl7mdIt73t6Bvcm8GLzqAMOttcqCSMzV3gGfBdercd3C0gDGTx1ftlBforshP+yRerLgrUkJK4zApOKt/WNhzEM8fsEeLdSOjOgvEMwJ5F+lpvl3oftqK+DBHrFJAYrG+fgEq9xERRcMdowHlwKr3gtDCXETd4TyozLlv2VJwi4T1MoIR4GGYokQHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWE9+ecRVdXV899UIQmOGJHb/gJ3VtmisETqpzhxw4g=;
 b=XeC44517EtWz2A05KXrTjjcfqAkaQzUY63k9TSzMwhYKWQ5QSbQyx1BuYolhxdzNCGEOU1pjFLH/thbSJmwOKS6Pgf8+IHW1hLx6AgzmMAY1TnS/7NU+gcIvuURf50ulaibuZDy0uwOaRrUN2/lbkA8zFDNW2pZ0XGurCrv378L7h8M/snTGeJ5li6Si3ra1qtev0qP/uB94sYYvmAZK09acHXbZv9vEuz4uOEG+d154P9XMZL/SXn0FIJF8lv/ZZ+Vxk6a3i/p7q6hcmbp2t5VWu4je9OffVUYt3ojuGHfF9bL1ASo6p0nZlr3tprD1bout2bHR5zTDm5JWV0eJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=readmodwrite.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWE9+ecRVdXV899UIQmOGJHb/gJ3VtmisETqpzhxw4g=;
 b=nNG+ekFwu+ir0f0p/gvU1rK/uXpW+e0V4dVA/9yE/9YbBXYs7sOg2++fS2T8kgDjVk18AObyLjNEhTlJPo87nyYtcx1GDwt6ntELXJIr31kgAzxhHwkyF2hiVdc1eNUZWxNMcm1UjB9jpY7/J3U8akZ9U7cbM484rQ7r5gtU3WQ=
Received: from BL0PR02CA0040.namprd02.prod.outlook.com (2603:10b6:207:3d::17)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 03:53:18 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::b1) by BL0PR02CA0040.outlook.office365.com
 (2603:10b6:207:3d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 03:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 03:53:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 28 Sep
 2025 20:53:17 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 28 Sep
 2025 22:53:17 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 28 Sep 2025 20:53:12 -0700
Message-ID: <0fc0943c-8ec1-47dd-9b3a-82c68c6bde34@amd.com>
Date: Mon, 29 Sep 2025 09:23:06 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "sched/core: Tweak wait_task_inactive() to force
 dequeue sched_delayed tasks"
To: Matt Fleming <matt@readmodwrite.com>
CC: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kernel-team@cloudflare.com>, Matt Fleming <mfleming@cloudflare.com>, "Oleg
 Nesterov" <oleg@redhat.com>, Chris Arges <carges@cloudflare.com>,
	<stable@vger.kernel.org>
References: <20250925133310.1843863-1-matt@readmodwrite.com>
 <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
 <105ae6f1-f629-4fe7-9644-4242c3bed035@amd.com>
 <CAENh_SRj9pMyMLZAM0WVr3tuD5ogMQySzkPoiHu4SRoGFkmnZw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAENh_SRj9pMyMLZAM0WVr3tuD5ogMQySzkPoiHu4SRoGFkmnZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: b75e166b-b90a-4fab-31be-08ddff0bb990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE9MYTBlc3E2WEh5MVJiWFM4VDE2Wm55dGUyR1J4WldNS0lUR3VLcWt2eXRG?=
 =?utf-8?B?RXJRQytTWTVOS2tuSmdERGRpa0hZVHNFelExVUJwKzdtaUo5MU1OeWJYejNs?=
 =?utf-8?B?YThzRy9rSkE3RitHcFhiMVR1T1IzNk0wNlNqUnByM1YyOGR2RFFXa0orQnRD?=
 =?utf-8?B?VStmNitJbk1ycVFqYndhdFBrSUEvbEtNaVlTQzRRblpOV205eUh2MDBSMFNl?=
 =?utf-8?B?WkZRMWMvcUcyMjBTQmpPWksyRlBtYldTUEp0VDBVVHY2WS9xMjI1M0NySWNF?=
 =?utf-8?B?YVA0UlN0L0JPYmtJY2lod3hxTUptSlZJbDl1UjR0VlRpZWlqSFV0c01ZRG8x?=
 =?utf-8?B?TTFVS21yOG1HaGFtSllrSEpUK3drTFErWjA0SklnK1FNcXdTQVJqSzFtdS9n?=
 =?utf-8?B?VnRDRWNMTGFDSy9hRTZ3VW01TW1BbVZpd1ZQaHlkSE1TaVBvdW1sYVZkTnlm?=
 =?utf-8?B?ejFOMTBJZWpBelkrd1VweWZHWEZDT29pQnl2MEVibUhPV1JoellnVWVvd2FO?=
 =?utf-8?B?SytIWjlveWxxWWJ4NTBxMko5SFphZVB2UkdWY0V2N25DeDRDeFFrWEtrNWVj?=
 =?utf-8?B?VFNoelIwV2N5NFFpRjFzc3I0MTVGTHl6YXBVTWFZOGpCRVN3RGhza3Joa00y?=
 =?utf-8?B?TkwxZUlMeGQ0dWVubHJTeVlkVlJMNTdZcXdtK2I1QllqTVpiMGd3aUNmOHpn?=
 =?utf-8?B?UjRwZEtVRG5tOXp3N1lZZHRhS0pZMzh3NjBCZ3EycmFpb2ljVGNmNjRpSXRs?=
 =?utf-8?B?d1NQNmFQSGhDV2ljc2RlYlptaWdDQnM5cTgvYThhdVdJSDI1ekw4bk9LUk14?=
 =?utf-8?B?OUUyTjV5WmlOUWhWTEkrcmNmanV5VFVxY29ROXp4bnRnbXo4UmlUcUlERk91?=
 =?utf-8?B?R2hBM0ZJa05GdUcrN2ZaNmw0MU5qTjlBMzhMazNDV1BlUmw3ZFJJVmdlZUVh?=
 =?utf-8?B?TG5UY2U0U0psc1d4Y2lvQzNzVkpSWDdrSGpOWFRxNUpkdk5GbWlxUUM3WHJT?=
 =?utf-8?B?MGZDYzRORnlodnZONWNscmE2ejFjU090T1FwbmJTYUJQWSsyVitCeFdxTUts?=
 =?utf-8?B?TDZzcVkvK1RqS2tydE9rYWNqNzI0SCtTQTVVM1kvM25tWjRNZm55Y1EwdDNn?=
 =?utf-8?B?RGFicTBqdUd1bE5YeFJaS0xpazE4cW1RcVdITVo1UHJWR3lLMGdYVUJkajVQ?=
 =?utf-8?B?VUNWYWZ2SjJNZm1tWEZ4NXZkK1hDbTM2YTNLRGI5OU16Sm9PZCtOSEhQcnFL?=
 =?utf-8?B?bkg4TDRzWDZuRUNSRnZlNUt0ZTUrajNRWStVSE9MTmxmVk13dkxEYXhOdGJT?=
 =?utf-8?B?SGh0R3pvZ3FRdG41N2tXSVFBeEt0bkE1dHJzRmdoZ01aSUpWcjZmdXRWU2dC?=
 =?utf-8?B?VThTUlB6M2hxRyt5Wk9tV0pkYnc4eWd4WmxWWmNxT0VJTnVpRjN4ZHdSV1Mx?=
 =?utf-8?B?RTB1RUwvVVhueDdLK3FDT1JvdmluWXVXTTdwNWxnZnJjMjZ3cVE5RWNDbm9P?=
 =?utf-8?B?dTFqck83N21aQ29abWU4dnhydTFaOFpqODJBbFBKdkxsUnc4WmVYa0l4Z0Ja?=
 =?utf-8?B?SXZtVjNQQmhycUs2c0pwVm5rNDJaak5Xc3h4WFYrckphSHdPMndsakRZTUdy?=
 =?utf-8?B?bE9nNHpGNjQxYWROWXA2ZE4vZk50Rmp2VUFlTjJFMjk1T3hjUmx5SXorTXMz?=
 =?utf-8?B?dVUvamUxbmJ6NHVCK1VhZ1l6ZnNHbmtua2x1eFRxd0RWeVFhTjRIbmxJbVpw?=
 =?utf-8?B?ZG40dmsrM1RLdWNwZ0NjaVIwbHc2RFA4VG5BanBESU9mTWd5VjFBR1RQM1FM?=
 =?utf-8?B?aWpXOUlrMmlTQXoxL3JzNE5MRFVkTEFVM2J4dVBpNEJzdVVuM2xIZ0R1NTZ1?=
 =?utf-8?B?d1U3K01yenE5Y1ZZTGRLb3BwMEcwR3ZvMWl4dGpwd3NENzFodE9TRTVuKzZr?=
 =?utf-8?B?VTc0QVBPRUR4VE1iWlZxVnpwWlUrZDZabmxCdUZLL0kxMlQ4b2xLVjVvcFhS?=
 =?utf-8?B?TVZUend3M0FmK2FCZVQxZGV0VFUxVzloZm41UTAvSi9CR25Eb250N2tvMis5?=
 =?utf-8?B?cDRUenNrQWpGRFVFbElJcUFqNmgxNCtheVlWZXNTczk3NjlLcklHMGRsbkJx?=
 =?utf-8?Q?mQCE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 03:53:17.9013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e166b-b90a-4fab-31be-08ddff0bb990
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419

Hello Matt,

On 9/26/2025 9:04 PM, Matt Fleming wrote:
> On Fri, Sep 26, 2025 at 3:43 AM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Hello John, Matt,
>>
>> On 9/26/2025 5:35 AM, John Stultz wrote:
>>>
>>> However, there are two spots where we might exit dequeue_entities()
>>> early when cfs_rq_throttled(rq), so maybe that's what's catching us
>>> here?
>>
>> That could very likely be it.
> 
> That tracks -- we're heavy users of cgroups and this particular issue
> only appeared on our kubernetes nodes.
> 
>> Matt, if possible can you try the patch attached below to check if the
>> bailout for throttled hierarchy is indeed the root cause. Thanks in
>> advance.
> 
> I've been running our reproducer with this patch for the last few
> hours without any issues, so the fix looks good to me.
> 
> Tested-by: Matt Fleming <mfleming@cloudflare.com>

Thank you for testing the diff. I see Ingo has already posted the
scheduler pull for v6.18 which indirectly solves this by removing those
early returns.

Once that lands, I'll attach a formal commit log and send out a patch
targeting the stable kernels >= 6.12.

-- 
Thanks and Regards,
Prateek


