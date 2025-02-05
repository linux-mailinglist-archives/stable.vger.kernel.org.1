Return-Path: <stable+bounces-112290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612DFA287A9
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 11:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E314B16921C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 10:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808622A4ED;
	Wed,  5 Feb 2025 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1/YpoNfy"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFDB21A44A;
	Wed,  5 Feb 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750452; cv=fail; b=UCtswiH0klea5CFHXkhn1NBhzSpd//2vLRR3th5kBIlSd2rR2R8iF73hIUdfv9nZ3deDxS/3acG6P9U4Y99ZZ+XoLv+4U/ko66eFKE80gIIiTBLnYZXQUEXOhGRLactPprHP9UVC7pbFY4+vOCHf35MvVQgieCACaHybzKHBE4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750452; c=relaxed/simple;
	bh=R9jsyqh0tur7JNXgNh2vjND39FkLhkM76ww1izojzWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YwmQel7mU4FjR5Qe0CaJIGdbip0DtN3tLiWT5Fjs/seJpQfCgbcL85lGDz7f7313x2lsXENmNYGGDBvdkEPnvb2hRZRkEGZ4iGLgyJ7FD7IU+kpZWbivESr6dFIeDnZTVP4Fw6yWjRfvc/mriIKqFCtRBe9EROkKuLELaXEBvRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1/YpoNfy; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9VQbvLfL/5OlkFF0/PHUD9kjwTOKAtTHRvkfH081iLwCBeRv99gaLoiPTpDv7KxnfYSW/bvF14xqAc1niiahFoxCcZZDj0QxCPxsvkrA1brxufSgSDeG8HKIyI/F2WaaD//CMWQllsnxc+Q5irPKbCmhS20c1Quibip75Jn7zELHKnWw1sQJWVTmcl7Noek6Hrd5LvU2a4BC8yGrH9mMAJRgywfsfOMXO/CxSBGDW6QNd5L2Xho3ywxHfhTPc6HsgQq5MYgUhO0VNbLXtFA6j/gYXpKZf4lZroH2W9et1SRMnPGaFawM/v6+fyxMmI43cuaYalkhzoBQKrTfecvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7NcB/tp2Dte0+tRSsPxQDqZjC7Qd+YUDAa32BbumQI=;
 b=mXYNx9glEDQIxchmh8rF4ZLWhJPJtOqba7awU/NPzXdSDwPaHlDdwCtK/mENPHoR/bQwPP7xBIYkSvsEOwMHByMvK7ny5dhuqk5HzD624BoUvrwgGLknlerB/RWl0HzckD06WMcKt6qVnpRIyAcWxiUDZN6ENin9H0gLcYChJpJJSLJkdpOKLNQo/wOn7qJo+DIRute6/U+FhxDi8/qCpXBTYMBF2yi/4Fun09WzCFGZSVL8xUIm6qU8sOh+Q9EqSzraIicGz3R3W4CvXUFaeImwH3kGfbnNqwujX70LGS5aJ/eYg/SaBedHUI/XNm9/PKWANcyFIIRtSf/JCB/9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7NcB/tp2Dte0+tRSsPxQDqZjC7Qd+YUDAa32BbumQI=;
 b=1/YpoNfyqbxZrTsl+Mf8ta9geUhENy0lUIhd55PcIjGrNetdE0HTLUy5wEMIxiHMpSgA/K9kv+n1mCDpbzDQfWKVHQPMW8oUT8Wcy4g4H5Y7p9wDjhzvZikMPFhyczlaJo+/SAQbUesEoq1BaoCeE1zxM8abMDW4vuq0dD+KzXY=
Received: from DM6PR12CA0014.namprd12.prod.outlook.com (2603:10b6:5:1c0::27)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 10:14:07 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::f1) by DM6PR12CA0014.outlook.office365.com
 (2603:10b6:5:1c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Wed,
 5 Feb 2025 10:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:14:07 +0000
Received: from [10.136.39.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 04:14:02 -0600
Message-ID: <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>
Date: Wed, 5 Feb 2025 15:43:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: Peter Zijlstra <peterz@infradead.org>
CC: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Steve Wahl
	<steve.wahl@hpe.com>, Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	<srivatsa@csail.mit.edu>, Michael Kelley <mhklinux@outlook.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <20250205095506.GB7145@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250205095506.GB7145@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: d954e301-97db-44a1-b6bf-08dd45cdd388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|32650700017|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEZlZXcrY3haMzhlV0ZUejgxd0NFR2lPZW5hNmpIbE5Od2dhd2ttdlhnMVFx?=
 =?utf-8?B?OC9QcUdUbW53bkRNQjJwMGw0dlpkMEU5OWhNMDUwNVpoWVpQK3RnNHNET04z?=
 =?utf-8?B?UzlZbFZ6UEpmYW14Mjk1SitmeVJ3b1FMYUpWUi92dEh0SlFubDJBWHRUVlVL?=
 =?utf-8?B?eU5nMzFiQ1VOZGJ4Q2owMDdLUWUvNTFGVlg0MXVtck5BTlhJQmZiVTBlMGZL?=
 =?utf-8?B?cnhBNGlxUGVRWS9vVmNlWmorU05sOHJiRXE4Z3I0ZExaUW9teFNsbm5vQjBM?=
 =?utf-8?B?Rnh3cGZvYUw0VkVIaFZpdHNDNGdjRTRNZnY5c01mb3pnU3FaU1B2dVV3OThl?=
 =?utf-8?B?WEliTmZWVnB5c00rTzRZZ25WZlkwZUZ4dWtJV1ZZSmtMWVU4MGZWdmlYZ3hL?=
 =?utf-8?B?Qk9aaDFYaWduUTlIVEdzK2RKdWh4Y2JFeFpTaXMvMXpCUE5iamZuV0FKVTFY?=
 =?utf-8?B?Q2xBQlk1RVhJNUs1clFUbjRnV2FBY0hseitpZ2dZNkFIWXRIZldKWjVMcXlr?=
 =?utf-8?B?SDF3MGFyTDN4SE0rR0NOVDNMWG5zNXRTaVJvNWNGbWt1YVpVaXpwM3VtYk1K?=
 =?utf-8?B?cTBXWFVucUt0MVBLeXYvNnRLczVNb0ZvRGs3VTFvTmlEcGg1YXFyLzVENmNH?=
 =?utf-8?B?NTJSZnNtSXArN3U4NHdlM0dZeGxPbGJKNkFZRXNURnBGRjYzNEd5dG1wWFJQ?=
 =?utf-8?B?YVlXLzhHbmdhYStHZjdHRm9pd1Fxa2R2c1VDUmRSa2kvZXlobGVxRUFPMUpj?=
 =?utf-8?B?T2N2eXVVRlJqdDV3V3RGTnNGYUxhMnFRdERtRzczempwL3N2RUhzRUs2azBI?=
 =?utf-8?B?MGtSejdpNzh5djdMb29XakJTa0JsdHJnZ0JvV3Nqd2MrT2tOMTFyaURuZFRy?=
 =?utf-8?B?NVQvTHZubm42eldCcHBSNzQ5YTlkVUpHdHo1WG1LU1JoVmkrUGxDWjJ3UHlh?=
 =?utf-8?B?NE5uNWI0SWRvbWJpN0N6aXhQek5UV1lMSnhDL1N3NVNPUlNERnRLdlh3V3FV?=
 =?utf-8?B?TlVhNXBPWE9WVVlhZDdnbWR2c0s5ZGNpZnQ3TU5BVDVKK2UwdnFJTytBRE5W?=
 =?utf-8?B?WE0xNmJUVllSUm9qajhmU29UU21aOTVka0Q2enNqeGRYNlp5anBRMjdSRnhE?=
 =?utf-8?B?OUxTa085NnJHWjVGOXNEY28zc1NFZEtSTzI5Q3hVa1dmVE8wZ3pHNWI4amxB?=
 =?utf-8?B?VkVnSGx4S2lIZWUyZ05oVmQzQmxBazkrbzhFdDVxK3Rycmd4RVdBMVVySC8z?=
 =?utf-8?B?U1RlRzNnMkV6OVBDaFpsbE9mOEtkYTAvNzd6VlkyeTM1Q2xUV2R2bmZ5emFy?=
 =?utf-8?B?bHZNYzBtWkVreXZoaWV0V2ZTa01oSlpZTkQ1ZTZaVTlXMk13STdlME1rV3pu?=
 =?utf-8?B?bDI5dERCVC85S3lMLzJpaHVZTUJNNk00QlZQRnhpOG9MUTdRblFrVTRBaHEr?=
 =?utf-8?B?ZU9NQXpKVFVkMjJ1QnBWN1pvTjMveFkweVJ2Y002UmkyQ3E5NmU3b2tZSjJX?=
 =?utf-8?B?Q0U4cjhJSzFxU1VGVmlFK2IvellUVXRmZjNCcGxHelQwYUZpZGxRRGxoV01w?=
 =?utf-8?B?WHNCR3lFbUhjY2plU0s3NWEwdE83VHdEUG1GQ2VOb3FoeUZXUW5FYUpkMW5j?=
 =?utf-8?B?enhmTzd1QnNvNmVpMm5PSFgzaVlyWWE3SmIrQXQyRU8yamRqSFd2QUZqK1RI?=
 =?utf-8?B?ZU1BaWt1dEN5QzdkRVJqR296R2xxMzQrS1YvZVJtTVQ1UVIzSTg3eFd3ZS9l?=
 =?utf-8?B?QUtQVERzeHdyMStNcXlhUEdGcEFUS3IzbnlMVDYrakNHL0hPeFF3L295OEkr?=
 =?utf-8?B?TStDTng3VXpTTldJYlRuME01U1Uva0EzZnZBTjVINmJaSm1hUWVOSGhuWTM1?=
 =?utf-8?B?aGozLzBiODQ1RC92aGxZSzc0L1FYdUNyT1NjSDhLK2Y1bUg5c3U0ckhzSDY0?=
 =?utf-8?B?Q0VFRWFJUTFOM0VNUFpWRnlOZ1ppWFcyNXYzYU8xUzZtOE1lR0dnSDI5cWRr?=
 =?utf-8?B?YnpmK1JTaXBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(32650700017)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:14:07.4324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d954e301-97db-44a1-b6bf-08dd45cdd388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

Hello Peter,

Thank you for the background!

On 2/5/2025 3:25 PM, Peter Zijlstra wrote:
> On Wed, Feb 05, 2025 at 03:18:24PM +0530, K Prateek Nayak wrote:
> 
>> Have there been any reports on an x86 system / VM where
>> topology_span_sane() was tripped?
> 
> At the very least Intel SNC 'feature' tripped it at some point. They
> figured it made sense to have the LLC span two nodes.
> 
> But I think there were some really dodgy VMs too.
> 
> But yeah, its not been often. But basically dodgy BIOS/VM data can mess
> up things badly enough for it to trip.

Has it ever happened without tripping the topology_sane() check first
on the x86 side?

-- 
Thanks and Regards,
Prateek


