Return-Path: <stable+bounces-114901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5685A3093A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301511888F24
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B4D1F4E30;
	Tue, 11 Feb 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qriuDkNH"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E11F193C;
	Tue, 11 Feb 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271412; cv=fail; b=A8Vg/Rz/kQ+fi01XuVk/JjCoz7CHRu6UZaV29CQO2dAn1MT7IF1iU4k9Hwm/tdPphjvGqGFSOWWtcccnrpAR1LcyC5Q34mw8vS1U5GVVfrj/tIahW3SNyRDmWC1uNSUfFMywC4UySUBY7Yxsef7PydeEmKedYaQeL3hFwn3FKGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271412; c=relaxed/simple;
	bh=a6DOE3F7k1OMsaPgGQk9oKWeHlycwXaAHMjtFmanBAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rJA31FCfo9G60ctdHXtYRgDCG3WE1TyOJ72UcnDPUiA1k612fyBJxAkPacgSPW8Oqik5+5iV+nUemDIorBwqPLF9F5I33Hm3gyyLjVTSqHDiWAyQvK+dxw0ByDZhhPEx/stEVp5oUoRsorL/PKAs7ue9BZdLD+A7ROCu/KKI2Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qriuDkNH; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHXPAu3i4DUChey1wegbI17N4MAVttM/KSshXgQWwdxZgjqwCZ/xbGaW4620Uy2dLQCd5ksgqGKy5803APXUJgxGgia3dK7kzgjK14GoXCN4ndwuho5hTVBMUtYPI/tRVjg4rPnpEBrYtd68UZVtLxW8QLz4tgivyEqF64ez/xVSIV8y0cjmKO0alurQGsjCHvL0Mg2XBJCTRh18NtNVIlN/Z9HFrjKaQmRPKyawol1Vo55cb3ppmzDAOHykjjd3Ov/X0FOTwze361A+f6C4QD7v5UUwkV7UBFThjujHdJ4T5mKEsqivQqtuxExJdDvy/DXgyCtF0jqr2lQKxChqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+HdFFa4AujmUrmi4Onsgo9COGNWQwGuFwYupR2TCPE=;
 b=fw0GmZb7OD8v4pKj6CcHAXz/eGKDohVTgYvMkl3uwmBbC8srdBfIhqy2I5YymOaMgGOPsWXMs3L4nTP8JpWlc7BEjL8kh0w/EZ1aYkqEj2Wg4w8XDpP49Vo2SH/GmW9y/dXofkh5cosGYE2gEuZu+iz6smmrT+p/r2NwqY+EUHbaWdZ5NCHH57uteBYtv4VyjlU0WY0KKzUt+qtSl5ZxqOZxSZzph1gUr1SfK2LZC77eTbvWjVItUPpzHLiG86PjtMiLtOMHT8r+MP3pxVFUtUnjiHoUeu0GB4AW16qEJeMR+h35zkO8JSive3nBvFPo9ivqUKDtxYY4ZrFunnnm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+HdFFa4AujmUrmi4Onsgo9COGNWQwGuFwYupR2TCPE=;
 b=qriuDkNHOItzehX6KMQ1soxL8NK3eCd4V1xzGCaxzFgKhDo6NydYgAVhImT659WgcdxzpdY1dijBSzgn703+Z+n4WZ8EHvxeEGdeEAN7YEgWyhNGWkQ3Y6jWAOT3oafKnQdSVHekfPh01mdxrus55xEJbwkgjsZCkBiu1blBt8Y=
Received: from CH0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:610:b1::8)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 10:56:48 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::78) by CH0PR13CA0003.outlook.office365.com
 (2603:10b6:610:b1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.15 via Frontend Transport; Tue,
 11 Feb 2025 10:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 10:56:47 +0000
Received: from [10.136.45.220] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 04:56:42 -0600
Message-ID: <0f51023c-7413-4503-95d4-42113fa3e2e4@amd.com>
Date: Tue, 11 Feb 2025 16:26:40 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Naman Jain
	<namjain@linux.microsoft.com>
CC: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Steve Wahl
	<steve.wahl@hpe.com>, Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	<srivatsa@csail.mit.edu>, Michael Kelley <mhklinux@outlook.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <ef199f2a-f970-4c86-a3f2-ddb6ad7abc96@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ef199f2a-f970-4c86-a3f2-ddb6ad7abc96@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: fb323938-7814-4bd1-0766-08dd4a8ac809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|32650700017|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXo2Sll0MmFsTDRhQ0tKdlJhTW0zczZpTThKVUZLc0h4RUlLazlYc20wRUE5?=
 =?utf-8?B?SkdGMEhqWVFVR0Y3OFNoaU5admltYTBjNXQ0TjAvVk9JVDZjQ3dBTmpYWm1o?=
 =?utf-8?B?QVQ5ZE9CTjI5ZFdBZDFoK25FcXBJUVRLcThZV2c4TDJHMWV2Nlh3RGJMdE84?=
 =?utf-8?B?U2NDZng5M2JFTmRJN0pHdTdtcndUUjRPYk40K3hKV0RjbnFUYXZBdUkyZXNQ?=
 =?utf-8?B?L3ZiaTZIS3M1eVp3ajl3V0VrcUwxbzJOaDlQVS9YT3czVHBBMXBYOGY4R09n?=
 =?utf-8?B?K0dRVklYSU5UUGk5c0ZyTFFYVDAwVXdPbEFOeitBQnZnSVpueVA3QjNJN3pp?=
 =?utf-8?B?ZkxwR0FkM1FCVGg2UzZuR21sWk0xTFY2b1JxRC82WG9tRXY2ZnlCb1VmVUhZ?=
 =?utf-8?B?eXdOcy9sZEJOaUlUbG9IcEx1bG1WbTNrSEY0T0ViNjk1d2FWVXk3WndLNW1q?=
 =?utf-8?B?YnlIL1BYQStpTWZPamJmUytzd0swbEZBOWhIaUltcWVWZkFkTmpvc0hzdlNO?=
 =?utf-8?B?YjREQ2dsYUVUMW1md0NzSTVOd2grOGsza2N3MFUxamx4aXVMamFQcjdBeTk3?=
 =?utf-8?B?UFdFcE00ZlIybWEzR205MUhKZkM4UVI0R0F3TnFnbUI0VGNPWEpUVlBkR3Rr?=
 =?utf-8?B?MlJJbTNac1hNYTJZOXpVYU9yZzFXRXhvL2s2MndKUFIrU3h2bmI4RFFWeHY4?=
 =?utf-8?B?d0NOdno5dDk0anU0QXN4dnk2VUNFemtqRDVSTW9WTkVKUFJ5OHdHQlVhZVQr?=
 =?utf-8?B?SEhrRGhJbDJrMHB1NzBDL0dyb0c5SUpRTDZhS0JBMUhKbG9vbG0zSGFxM1Ji?=
 =?utf-8?B?VDhvUW4yLzIyWkJJQ0ZZcXpMcllhZFY3SHgybkFER0svQzhLS2o2WTdDR0hN?=
 =?utf-8?B?dGlyMjN6c2RCNDlTVGN1SmI2c1pjeERmNWNpQ3VnWndJZDhBMGJrbUVkWStm?=
 =?utf-8?B?VUJYcmF3djZJWXJxLzBNcjJTMndiNk1xZWYvVlJSV1lRZ2s0WG9VWkRoMzJx?=
 =?utf-8?B?THZCQy91bEtqdGlvZUgzT0VPYXh1Z1o5RVJHSm9CZnlmT0JqMGtOcWRWQlUw?=
 =?utf-8?B?N3NYdHRWYjllMmlHMTF1WVFqZEVuUW1RUXpqQ29IVzRaTExidlVHOGV2aHR5?=
 =?utf-8?B?T2pROFI4NjF6ZnlDY3dZWm54UDVkNTdPVzN4VlZnR0NwOU8wR21JRkVHb3Ns?=
 =?utf-8?B?MitVN0JXdXMzelN2bEdreTF2dkhlWXZobEZRODBzcUJSQWQrUHI0RHhqYVhP?=
 =?utf-8?B?MWNlU1VOa1ptK1BqN2dKREREL0I0RVpLSnZXQmxtWTBBQllzUHRhQzVGcXhn?=
 =?utf-8?B?U2NwVTJrMGRkSzAxZTllMTYrcE1QR1RiUE9vd2QvSU94aWFDZVU2cEcyS1JE?=
 =?utf-8?B?Mjlpejk2WWNvZmZ3My9MV2EwYWttamVydytXaUx3R00vS1VGTEhxbjZ0MFZO?=
 =?utf-8?B?NWtPTTh1V1FBeGxJczhBN2hCRE9GOGdveXZpTTQ0cUs1SXkwWkFDNFlGc09G?=
 =?utf-8?B?Y3pxSE1kWjFqL3lHcjZ6NXVockpsUm9RNi9pMmFZaVhzY25GWmhJTEhNRDFr?=
 =?utf-8?B?OUVkK3ZuQVNtWHhWcUJ1VGJoY3F5UEtPcGdSR2I3VkRHVGk0SWdyS01HdEhY?=
 =?utf-8?B?SFMwc1pKTXJrclZESERkYzZneDVlQjBmSnQ2ZUVPc3loeWtHRWtZcGlqNjZl?=
 =?utf-8?B?WGpmdTVpTFdaRVZoVTg2cDBKMStnRk5kS28vT3dySGRJb1VQUWcyb3l0UERR?=
 =?utf-8?B?OGl3L3IrTjk5dmx2NjI0dW1PZkJOcFNWcmNzT3l5UStEQ2VhYlF2TEsrZVYr?=
 =?utf-8?B?a241dXUxUGFwRXVRRW8wbXdMRVVqNkNnejFXMERmakRUNWYrZTRYKzd0M29B?=
 =?utf-8?B?bEE1WnpFVmVnUkIraFI4S0NyekErUitPQU9tT2tRNmZWY0lvcDJKbStjcGVC?=
 =?utf-8?B?OEpBWDN1YVJlMEFEbk4vQnprVTBNalM2aW1Mek8xam14TmI4QzZzNHhRcTJU?=
 =?utf-8?Q?tnhSWdheRs3ou78G9uZltTO9JzfAeg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(32650700017)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:56:47.7361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb323938-7814-4bd1-0766-08dd4a8ac809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

Hello Shrikanth,

On 2/11/2025 11:22 AM, Shrikanth Hegde wrote:
> 
> [..snip..]
>>
>> What I'm getting to is that the arch specific topology parsing code
>> can set a "SDTL_ARCH_VERIFIED" flag indicating that the arch specific
>> bits have verified that the cpumasks are either equal or disjoint and
>> since sched_debug() is "false" by default, topology_span_sane() can
>> bail out if:
>>
>>      if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
>>          return;
>>
> 
> it would simpler to use sched_debug(). no?
> 
> Since it can be enabled at runtime by "echo Y > verbose", if one one needs to enable even after boot. Wouldn't that suffice to run topology_span_sane by doing a hotplug?

Ack! It was a suggestion in case folks felt apprehensive about guarding
the check behind sched_debug() ...

> 
>> In case arch specific parsing was wrong, "sched_verbose" can always
>> be used to double check the topology and for the arch that require
>> this sanity check, Steve's optimized version of
>> topology_span_sane() can be run to be sure of the sanity.
>>
>> All this justification is in case folks want to keep
>> topology_span_sane() around but if no one cares, Naman and Saurabh's
>> approach works as intended.

... which is why I ended that long explanation with this :)

Valentin seems to be on board with the current approach from Naman and
Saurabh and it works as intended.

>>
> 

-- 
Thanks and Regards,
Prateek


