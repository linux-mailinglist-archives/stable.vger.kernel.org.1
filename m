Return-Path: <stable+bounces-114198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA01A2B939
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 03:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3735D188921D
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 02:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A3BA4A;
	Fri,  7 Feb 2025 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HQF3MW2y"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403810E9;
	Fri,  7 Feb 2025 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738896379; cv=fail; b=GEsw49S0aVrLFqPZ6mBwjjaoDegHCJt6oSDjUWnzh8tOKM2+nxmPBUqyedl/REHBcth9gVuRMbBjbVnZUSV+qd5RuKOUESH1o0bLXvc/uvpMClzytwOLb7TZvpG/Fv9MSdTzUjXSJmMoYeY10v+Q5KEGYkuV/iLmlFJ/czglQ9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738896379; c=relaxed/simple;
	bh=nzYKaBtZwfaTuI9ENMQvRvVK3rKEvMI7bcAk9h1GKx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W0fK36hx9m3LRSNKjsGo8pwyGjMwFlhUZX64hUrus3CK8ettrKlrZJLrm4CEUIOLjh0d8JVb3JKnt0EcnusqD6J65knYiumYbgeqjkDQ+qd9GSDnoe+Xi4TqSrgU2Sw60oimy0ajVf6M8Gxq7QbTQU/Sn6YJ8bjVM58CYyAg8Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HQF3MW2y; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW5HRBUdkuGQ6bZMMddaK6rUTcGtE0+8PC/PyrCYUJUybmFlj6sGJJnYzHVOYbhlQn3fC2EeFfGlrKQroi7sUym3UPRWPPOIBjIxpTPiEjzyHbz8NcClJEthp5KazWo56BRHc+jXDDYVatloOsxjW3HhYhfYmDiGssMnUwSZbpVMR2lV+dOfVXSpPNEpvLDK91BRcwMsoXEVLlRCXjlUyp43cdQvKP0//9YBFKDtovS4yZojCd6w/Twer3KUQ2/zFDQ7Ueltjg6Uve8L1mYlYY5orXjrganOgJtFQHPrvPHvvAQ6rN9V0i1F7MXYqNm1GhjO7nHF7ptLH3k5qr3Kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlOAwRYql73yOJxV44zhv4TCNTw6b6+KL4b+CDvy7m4=;
 b=Tfy8/MagzqKm40tSn7JVVfIwh+V9bKLC4yY/1KkMGWgSx72ruoSb3J/AVTF4DLo+oUlavcZU1WoYW9caYJ1yr9xHQHaKsjeg2YFF270EKBEDlIFggYxTGpmNFV1DmOHFvLiMXqMgbtBnPQJ0wzvJNPCXucA7BwTlSsYDjbEtxiPkZcpHuZA/6VuIoKbKZaLfCkCD1anrRj5bDXnhs1EOOPBLjIScmjHbXmENo08Viq596407BinQUAZCZDbZ4AUCaaXJgeJ3bgkWOgrqRrDQQcynld12TpVPXPhFBXaEV4V7V9bpUQD+fDGPSF7SEVGO2DaoTbe79pjHFi6C3zuDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlOAwRYql73yOJxV44zhv4TCNTw6b6+KL4b+CDvy7m4=;
 b=HQF3MW2yVWj4G1+zwhr7kPLoZuZuDghjvAp3gHNcRaoBeFR6B59PKi2ba2HgNjReJNtEXhpyiyS0jz/uS7wOQ6uwCt5LXf9hU94RIVDUm/K5j5+6b+UUOfdhB5/U12uRb9nhZXJB7f0ZX3jXkGI6//KjcTPJKrjAry5C3KNbc5E=
Received: from CYZPR12CA0001.namprd12.prod.outlook.com (2603:10b6:930:8b::8)
 by CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 02:46:12 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::dc) by CYZPR12CA0001.outlook.office365.com
 (2603:10b6:930:8b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Fri,
 7 Feb 2025 02:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 02:46:12 +0000
Received: from [10.136.39.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 20:44:39 -0600
Message-ID: <6d436d56-20f7-4106-bedc-e9d146427fa9@amd.com>
Date: Fri, 7 Feb 2025 08:14:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: Valentin Schneider <vschneid@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Steve Wahl <steve.wahl@hpe.com>, Saurabh
 Singh Sengar <ssengar@linux.microsoft.com>, <srivatsa@csail.mit.edu>, Michael
 Kelley <mhklinux@outlook.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <20250205095506.GB7145@noisy.programming.kicks-ass.net>
 <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>
 <20250205101600.GC7145@noisy.programming.kicks-ass.net>
 <e0774ea1-27ac-4aa1-9a96-5e27aa8328e6@amd.com>
 <xhsmhed0bjdum.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <xhsmhed0bjdum.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CY8PR12MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 937fa5b9-db48-4650-ab51-08dd472195b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|32650700017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0Q4STdOMGc2bnRuR2VIalRFb2ZraXduVmcvbmoxUSsrTDBLNkhXNDZsNWRR?=
 =?utf-8?B?Mmhhd3QxNXQ0WmlmSmdxMWkzbk5VN1crZjRHQ2tOUS9lMFp6WGZ4bVdKNCtO?=
 =?utf-8?B?VEJHQWpvV3AxMzRpVk40ZjQ4RzNNaVltK1VqZS90cVNDMGRWNmswR2FlMVZI?=
 =?utf-8?B?a2ZwTjdXRjQ0UENaYURrSFlrUUtNUXFHcFYxaHpQYUV5N2YvWXBuT2h1d1BU?=
 =?utf-8?B?TEpuN3ppa29xd0ZJMWxqVDRXSEorRmxZREIvNHIreXZTNUhkaWZ4TkZaSldP?=
 =?utf-8?B?TDd5ZFcrQTlNWVp4dHBucGlNckV6S0JVNXhLMW9VV1pUek9NRWNqZmdKNjBk?=
 =?utf-8?B?bTYrbFVYVEhYTTBkbzRScDBYNmlJR2tNSjM3QUtZZE90SkJRdmhZVkZVaWVN?=
 =?utf-8?B?cDZ3RVB0YTNZUGR5RnFEL0t4S1RsRlR5OTlXcGtMOFg4bmRQbU1DSVBiOGxM?=
 =?utf-8?B?em9wdnlRSks4bTNOWUNsaVRPZnNxTVM3VFZKbFZMZjVNZ0d1ajQyRTVaR3V2?=
 =?utf-8?B?cDg5KzlFb2xTWTJqY2h5YVBuT3E2UzZXVjhIS0cwZE01MkhpTXU0Y0N1ZVNK?=
 =?utf-8?B?U1VDUHoxZldBRk5WSDZPeHpLZEIwOS9IV0RGODJvMnNIWFJFYXgzZ0p2Rllh?=
 =?utf-8?B?bXNSQnoxN1JITDR5Y3JhVlFyM2hqb1NVbHhSN0FqdFBaV0tPOXR4L2Jtd2Z2?=
 =?utf-8?B?VEU3a3dMc1pIbXdMQjFyN1BCOWwzeklCMlBQZjNhS3p5Q29MSEtrZ0NMeElS?=
 =?utf-8?B?VjlSMW1oRTJ4K0JNSzhDa0N1VHZYN0Vqb2pldnowbE05MUJkdW15TnU1RHBO?=
 =?utf-8?B?a1RaWmZkRE9HRC82MzhnRVBtT0tlTWhuakJWMks1a0dNakJyNDVhK1QrSEsx?=
 =?utf-8?B?b01jWXNqQWUyZm9wNUdqbzVGSTJseUlHaURhMk5GNFNybUZQYVRYMlEvZkV0?=
 =?utf-8?B?WEVvZDE5N0w1S1I5ekY4dmRLbEk4dlZzR1htckpwU1JSbHJtbytEMWxUSnQ1?=
 =?utf-8?B?RFRoTXcwMUFrZHpvelg1RFhzOE9KTSt6V1pXYVdQLy96V3JLQzlUdEVBNWhG?=
 =?utf-8?B?OGFOek45Q3FkcVpER00rU3JBK2gxN1lNU1kyV1ROK0taYkh1K2ZLZzJQZXFG?=
 =?utf-8?B?Kzl1cXNMS2xWQUorb2lQRlVhaGtpNDRlZXd1NDhiNG5CZkkyK2J1U1F4YmY1?=
 =?utf-8?B?eWtrajVqbXBrYWFrekozN2hWT0dYK2NIVGhFYnhIMVcyd2R5Q3lneXBTZE0r?=
 =?utf-8?B?ZWE0TTZvY3NiaXhWVjBkcnNmSEp2L3dIellqT3BkSlErSktCeEdWZGo1RzFp?=
 =?utf-8?B?dG1ScEFuS3FybzJFTTZBNnJMYW5XVkRBdUF3T1BWbWt4Zmh4ZHppdThxZU1Z?=
 =?utf-8?B?MVBEdlVLcGZPa3BKNGUwZyszWGMvQkxGUUUxbzBDY2N4VTFoTnVubzFscENa?=
 =?utf-8?B?MXN5ek0rTndyKzJ0N0ZoWnl4WCtvOTFhaDVaRVYyTWpZdVdsRTh4N0RBZnI2?=
 =?utf-8?B?dzljVnFUd0xnQklZNmpiU3l1WDRTcDNrQ0ZWQ3d3RWtKQWRqOG9MblhLb2Zt?=
 =?utf-8?B?ZEdqcGltMnBCK09WdFNuUFJ4VDU0VnVQZDMrVWpPSmRzSzFqdmxpSkREd1p0?=
 =?utf-8?B?YTdDbXM0UW51NHFHWC9WN211eHg2ano2ek1IS1cxWWZsM3dDbkJDYmJha0pk?=
 =?utf-8?B?OUxVTmluSHJybzludXJkMlF5TVBLVDF1RVQwcUcwbS9DOEpPdzRjOWwrbHFm?=
 =?utf-8?B?WHRJRG1IRUc3VldXWnZ2c0RNTDg4UjNFODNFc2ZPZVcwSzlvTDBtS2RJWnkr?=
 =?utf-8?B?bytvbG9xSFp2YU1xUnJReVJaT3J5WDF0a093ZVdlZU85dHZPcWFtcGh2cFJI?=
 =?utf-8?B?SWY1a0ZmcFNnelV1b05GbS9JQW42WkIvQWZuTEJRa1JDckFyT2NYNTlGTVYr?=
 =?utf-8?B?UW1yREVuY0lNY0p0NFBKUUZPdjlValp4UWlyMi80Q0pvLzhtbDgzWGl5ZDM3?=
 =?utf-8?B?d0RZc291eUNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(32650700017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 02:46:12.6407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 937fa5b9-db48-4650-ab51-08dd472195b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363

Hello Valentin,

On 2/6/2025 8:54 PM, Valentin Schneider wrote:
> [..snip..]
>> So circling back to my original question around "SDTL_ARCH_VERIFIED",
>> would folks be okay to an early bailout from topology_span_sane() on:
>>
>>       if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
>>        return;
>>
>> and more importantly, do folks care enough about topology_span_sane()
>> to have it run on other architectures and not just have it guarded
>> behind just "sched_debug()" which starts off as false by default?
>>
> 
> If/when possible I prefer to have sanity checks run unconditionally, as
> long as they don't noticeably impact runtime. Unfortunately this does show
> up in the boot time, though Steve had a promising improvement for that.
> 
> Anyway, if someone gets one of those hangs on a
> 
>    do { } while (group != sd->groups)
> 
> they'll quickly turn on sched_verbose (or be told to) and the sanity check
> will holler at them, so I'm not entirely against it.

If you're game, I'm too!

I just put it out there in case folks had any strong feelings against
this on other arch but that doesn't seem to be the case and we all love
a simple solution :)

> 
>> (Sorry for the long answer explaining my thought process.)
>>
>>>
>>> That I can't remember, sorry :/
>>
>> --
>> Thanks and Regards,
>> Prateek
> 

-- 
Thanks and Regards,
Prateek


