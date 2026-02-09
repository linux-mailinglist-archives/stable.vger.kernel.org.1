Return-Path: <stable+bounces-214878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEF1OgRfiWn07gQAu9opvQ
	(envelope-from <stable+bounces-214878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 05:13:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D9B10B867
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 05:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F375730057A1
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 04:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0491923D7CE;
	Mon,  9 Feb 2026 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="27w6UmAQ"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1C1CEADB;
	Mon,  9 Feb 2026 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770610431; cv=fail; b=NovDC6frSawPz4Efi4n/Aofs1FMMoT1mEfEKoDlylTTcL3lZto2e02KamcrQQRBrPsuquCtuPnPT67+aQIGTdgXGrtZfFGTLuuc1fF8ISoOrFAazL+So6080vqKXAwaM8s/rbHzQWn8zeNA6a5BdShmPB0slVmDFZ65hlJUNljs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770610431; c=relaxed/simple;
	bh=QO5kvyykJwfWERsj99d35RoVD8osxqf2wkudIXPUFvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uJjiQtYCar3UpdrC0Kpv/yAJ1KteEODZ36OVow/s1gR6SNv7hwdUJ8UX1ToGrzXdYRiUQMcyKmSI4j6I0imXAa0bBE1YI7c4vnXzWO46uF/EFEuAJRU6vVvp06UEvEEZI96aSD9w2P/aGD048pJulnUmsR2B/oSSK5AU80IzeeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=27w6UmAQ; arc=fail smtp.client-ip=52.101.85.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Krax7JVukpkABSqL9Ju+jyKf6aKVX5ILYnEd52WPpZ39dZrZWwvOcOZBuLgmpSrS8OGCIkR//tTyGnKRWItZl/OJTcwZQtoNmBd4QoLzcXyrcSE9Pe1MsfQF9zKDPBbdzjJZT+kofy0I/mbV2ZW00Tv7v+LnAn40OzbqQmODL0Eqa+jhewr5QrLX4WNbQQaGTG3Il5TambCkoBLmtIpx+rzKAqB6ChTb7M57ekffZdxPs4SOngWBpiWMR3F0ul88kjbkOhSiP6N8H3uJTe/WO33bmrrutJMBvNWvhtO1EFZrEUM2f6MlzhqHwsLI5m2OgqjkGygL3p7E1HmQrBiTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elM6DHyR3dDfZTTdziC75JipAERIRRitTqcnYOiWEq8=;
 b=DeYNllxkAOLelXGgplUJcMWc8cFa/+8i9JGEiP8mBBkIGOVbhoC5CUd1sGEV/nmKvhHv/mdrnR8eEN+3pd8K9exWGeh4tSUYUsJgZnsOLSP2YeGYyvhm9iVCvn1Xef2lZRjNg3xx+02TuLOudPnn8gdoyLLg549E3hP1rsR50v2y1gf9AYz5iHuEK1KOLlZHdf2CydzFd7g+8cD33PdWYs7pVwRiBD45fyHpOfurERRKLkmhd0Gu1iwWjvMQ0nExKyu7BZmcOcr2hFsTWeyA8nZw1CP2s19buiB8BmGwXi9xlA1JIpfxthxNx/efOetN1MoJCuoOTXvxeukf/2VOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elM6DHyR3dDfZTTdziC75JipAERIRRitTqcnYOiWEq8=;
 b=27w6UmAQQr15EVAG314yQJiVhvU4RLhb5nI1O/TFsGrcqr2Ppg7hSWen7S4rl0DjBMCcu8g80KocagVdFFCGiPrcpP0+XmSZ49MaCWIYMghOjbOXVwbBCvnfQ97WHsu3GWgOExYkEi9H+v3guWRWfRhkPNF9lMnI8kHeDkODRhY=
Received: from BYAPR11CA0107.namprd11.prod.outlook.com (2603:10b6:a03:f4::48)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 04:13:47 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::97) by BYAPR11CA0107.outlook.office365.com
 (2603:10b6:a03:f4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 04:13:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:13:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:13:45 -0600
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 8 Feb 2026 22:13:40 -0600
Message-ID: <64ebef1d-5f22-44ed-a1f3-2f7cb432e10b@amd.com>
Date: Mon, 9 Feb 2026 09:43:39 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Fix integer underflow
To: Pierre Gondois <pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: Christian Loehle <christian.loehle@arm.com>, <stable@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Rik van Riel
	<riel@surriel.com>
References: <20260205150846.1242134-1-pierre.gondois@arm.com>
 <20260205150846.1242134-2-pierre.gondois@arm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260205150846.1242134-2-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c26ba7-8015-4cf8-ad6e-08de67919ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlFRSHVaVllwZ0k5RWxVQU5uWS9wNm9qNDlXYmhnQnJ2MGlQOFMxclRQRFJs?=
 =?utf-8?B?K2tMNnZSTHdBdmhhV0ZyUXlvRGkvN3NhcVRadzhiVndVekdQVXRDSCtoR1Ru?=
 =?utf-8?B?czBLVXREb1N0eWxPcEczWmNuekxpV0ZhQjZma1NLYVhuLzAwQlZrOVRjRXFm?=
 =?utf-8?B?bEszUEZsWmJJeVNZcCtqQWl3dFU4SE9FemJYempLK3AveFN0S1BRK0crM2My?=
 =?utf-8?B?ekt4ZU44c1FIcWttTldUV0JIRXdzTmNXSkxGN0dyWHV3RGVxQVRYN3lXUG9N?=
 =?utf-8?B?L0ZpaUtZRUtrYzd3bVFHR1JraFpUd3BpOUJVdU44VWR6MDUwV1BIZmRSWlYx?=
 =?utf-8?B?cHJjQ0tTSXhvQ2Y2ZU9TL0w0WHlLNnBMdFdjMW1JbUcwUHJNUkl4bW9FU0lQ?=
 =?utf-8?B?WmZYTkpiUHNwQ0tGWGFOK09Ga2czN01WNVF6MjAwZ0xkVU52M2FHZ3hLUzFT?=
 =?utf-8?B?UFdkaHErWndOWDJwOU9rT01ia2g1dzVDTFkrNVV5VTJIVndVRjdxaXVKaW1y?=
 =?utf-8?B?ampTTUdNemdxTTUrTklIbHkyOEVLUjQ1WVUxalRxV2tzTUhLRkZSaUNiU3NJ?=
 =?utf-8?B?Z3NndEF3NEY0WjlBdS9KdVB2b0pzc1h2RFFJSVoxaXJBYVBZNGZEQ2YyRWNo?=
 =?utf-8?B?Um56alR2K2Fhc1ZGQmVENmJRc3J3Tm56UzdIb0tsYWJhV0hWL1Z1dVplRlJv?=
 =?utf-8?B?Z2REMkRLWGVzcmFCQzJsYkJPNmJXWndQNGh3dEdKMHhibGFoUkVQN09URWdm?=
 =?utf-8?B?RWkzVEVHVngxbUgvcVRvVlBPQ014eWtCYUVEdEVDYm0yemNxSmdHdFp6RUYz?=
 =?utf-8?B?S1hpSnRJcTkzbjBxd1FGakw1dE1wbTRIMGlFVFJsSDJ5VTJ4UTRCbWgxdCtN?=
 =?utf-8?B?b2F1N2JtU3NCVHRURmh1QXZwRno5d0ZYUHlwd2NrUUpwZGI5ZE1PRkxpUDZt?=
 =?utf-8?B?bzBZLzZJYjF5emZhR1J1YWh2Z2JiMGJ3RzdVaFhZR252UXV4S3czQ2twTUxz?=
 =?utf-8?B?bmlUcmhRbVZoenc4ZUM1T0RENWVPRit6SEtvck4yT2hsRWgxTHdiaklNYnUr?=
 =?utf-8?B?eHRSdEtEUlQrZmVXRnM4ZmJLcXhvYXVLL0grcXM3QVgvMklwSkprVlhrd1VO?=
 =?utf-8?B?azFYb1dyajBpaWxXQ21YSVJsTXdGRnMwY3VxRDJzRzFNWXpNR0dqTVQ0MHh2?=
 =?utf-8?B?OHloT3AwUzRiNXlDMUJEUFZUY1N5YlpKeUFVNXV2bVFmU1Y3QTI3Vm96ajla?=
 =?utf-8?B?UXVVSlNzNjlEN295K1QvdjM3QTZuVHlOM2Y1TFRpNW1NUEhFRXVDTHF4a0VO?=
 =?utf-8?B?VktSQkora3dQYjY4Q3MwQlc4Zng4V3Q5OG1zQ1NIQW9pS1FOVFRDakg2UENX?=
 =?utf-8?B?aWQvb0ZTcXVGT1R2REtWWlR4K0xjeENxQ0Z4dFpzUUtFK1VqdU12U3RscWRC?=
 =?utf-8?B?N0ZzRUNTRmlkV284ak11TmVmRXlhUnJ6TXplZ29JMHhnci9LUEYrMjRNVEZ4?=
 =?utf-8?B?MWlSWmJkd3N0b1lNaUVDdjBQM093TDdUZktzQ1d4b3Blb0ZQTDhqcTlPRkIw?=
 =?utf-8?B?RUVtazhTTmVuSG9Oa2NmNlhqaWk1SU9IOU5wODlOV0E1L0NhWk9SUmFCN2VI?=
 =?utf-8?B?eDc4aERhL2FsOENVOHRnNHBDUlZLUkF4YWFoS2VUTjUxL3hZMFJmbGFxTWlu?=
 =?utf-8?B?R0EwakprLzFkUndrbW1mK3ZjalJuK1plblVuS2J3Y1I4L29ld2dtWWFtTlpi?=
 =?utf-8?B?OTh4NEtSQW9mQk90OWI1SG0vVWtpM3ZSM2lWN3oxMzZCT2VWb2pka2hMRzFY?=
 =?utf-8?B?SG9kS2FObVVVV2RISEZzTmxINk16ZEdmZ2ltSTU2SmJjemluM1o3WlMzS1Ix?=
 =?utf-8?B?cHZFMDBvcFJEYnZ6S0NKcytHTkQ1dTgwMW1pV1BJZ2pLM3V4b1d2T0luY1ow?=
 =?utf-8?B?NE9BVm1VcXB2LzFCeDExQy8wSVpEVFVGN2VYVStwOFFBRTBYamRlMEZlMXJ0?=
 =?utf-8?B?ZGlOQWM3NGxBL1pLZS9SOG9LRko4bTF6cEIvb050WVZhUXcxTTNwQTIxSlc2?=
 =?utf-8?B?MDlvMVhUTnYwZ2hVeW93WmRZd1M0bUtNdytFdS9RS0p2UGlVbTFBdjFOWDZD?=
 =?utf-8?B?dWUzWnNUeURLcC9ENTdUc1JhL1AyU2s4RTdRYWtNS2VGYXNCT1dleUpEZDFZ?=
 =?utf-8?B?OVQ3aDR4L2M2bGdtZTFvZDVVemVTNm9aN3FIRmY1NThNbFJjMDVubHdRRlFC?=
 =?utf-8?B?Sk1sajRReUx4b3psRWRNMG9zZ3NBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f9IZpgxFLne9JJyORrYRQ6uYB1ut1hDw3AR56kbUUSFQI5bYjbSdNvxhgsEFngSocvPEA5udGsb63afNQ5692CJavgYfWEKX6nI8b04dAknzYWuPBv1vlkroWKYqMRUH1qGc6enMbhE37EAYbl2iw9EsXuv9ZVn7DE9zsV7aUXvUPGZ39pYK24XhIoz6n+uik+z9p4CFv3uXbnJf8kSA5mBwc175nvDsIfNh3LzeIN/c8qRjor9/uP2GdAll25YnZESU+oj9oOb87QL086q2O6gISw5p+qOSh0hskq42uV9bFp/ibmrRFrd7R/ptzUrFsQz1UbeM/Mdl5jj9U0IK86CpZ7Arah/yP+S8Kn0NIY4C356HAtBaOaqQx+TPFAqnOhSRNlFTI1Wve2ALTgX5MkbvZ483uBMwrKxwdH5gilJ8LewEMu7qw26lSsnhZX49
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:13:46.3725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c26ba7-8015-4cf8-ad6e-08de67919ec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214878-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,amd.com:email,amd.com:dkim,amd.com:mid,arm.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 43D9B10B867
X-Rspamd-Action: no action

Hello Pierre,

On 2/5/2026 8:38 PM, Pierre Gondois wrote:
> (struct sg_lb_stats).idle_cpus is of type 'unsigned int'.
> (local->idle_cpus - busiest->idle_cpus) can underflow to UINT_MAX
> for instance, and max_t(long, 0, UINT_MAX) will output UINT_MAX.
> 
> Use lsub_positive() instead of max_t().
> 
> Fixes: 16b0a7a1a0af ("sched/fair: Ensure tasks spreading in LLC during LB")

Should this be commit 0b0695f2b34a ("sched/fair: Rework load_balance()")
since I could spot the max_t usage all the way back to to it?

Apart from that, feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

> cc: stable@vger.kernel.org
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da46c31645378..aa14a9982b9f1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11249,8 +11249,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			 * idle CPUs.
>  			 */
>  			env->migration_type = migrate_task;
> -			env->imbalance = max_t(long, 0,
> -					       (local->idle_cpus - busiest->idle_cpus));
> +			env->imbalance = local->idle_cpus;
> +			lsub_positive(&env->imbalance, busiest->idle_cpus);
>  		}
>  
>  #ifdef CONFIG_NUMA

-- 
Thanks and Regards,
Prateek


