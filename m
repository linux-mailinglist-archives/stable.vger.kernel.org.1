Return-Path: <stable+bounces-109499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064FAA16642
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 06:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD951882008
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 05:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5DE14C5B0;
	Mon, 20 Jan 2025 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cMpABsFI"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9F2F30;
	Mon, 20 Jan 2025 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737349223; cv=fail; b=Q/Xno27mkC0vgjTOwCvy8JSAtKZcaUSUTGxQ4FuqHXGTqrw5xWzjOOHDVlUeJmmlGLnjZYgKAPKpbF7B+6MjP27SW7vJeJ/w9hzxnf5gRAwh7XdFKGhfGd+1s7+RuxGirDW/RuDd5rkZrK6tik/AYLcGwDciNQJ7NhG8pqlrwZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737349223; c=relaxed/simple;
	bh=xnwwMVeKhVWseI7w88AiesjzfoLzJCxWhLhzFom6Csk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZR2NChjUw8toXGmo+qWQK8xYr/vK4g/PPAGXz694j0eg98u0sGxsP49upiBj08U6ZtEcQVAXA8km08lM/UZZndyJbVlWN5dURMJxOBaa/GEvB9yecf/HoS1C9dGNTKtltVg2eymY0yvFv5kcp9NM4ZmVQHByIfJN9qnF7h4758=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cMpABsFI; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yys054v4Sgc7EpiK+89Y484qR1H9VMgvT/0kDCgFFiPEKmo3Aayg1oPUFEBf10+pdBqJvwua8sbMxXCJJu2K1Pcmy9FQYYknoTho539oP1nC+ePq7CUj3XP1jUCnq+qhsLwDRZpQPJ/pa4RK+pS9P6Q3Asnk/p0ZffkCVwu3rGZpHPn9c0SRyj9aKxi1ZTgWPAumbfYv8A4k4VqnsamCFH9mzBimo7Fvm17q8TZw7HoX4u8zFhhGCY9ik7tZYVTGloKqAm2DNc269KeNfJoJN2fF2NHaa6lx+Q0hi9oxP+OpBVwvSNNdULxY7nA+banagLiOa/fQHUtRS3MDqvBViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYwKSWXlNFeKdyZuU2uBcFCluDhcm7xRHVvXXubPArg=;
 b=nmXbXmsFE3hT1jOwU6nF5OeQWsf8bPgoQRyP6xv1+W+OmyjRriSOyox5W3Zw6OSPuEBWO1Wc5YGFmlPQYjpM+n87Zubd0T0GCoPUjQWtHzx4OjdcQ5g+Mz5sj8vp63S+atMK1bSKhhOo1I7iuX/i1ww7nt8kZjEJS5W2JBYXLAQ5A36xT5GPA4yUGeB+ZGsIj0H8MXG+NEAcgsVBTpYMlbiYdiM/1AnfOoUHToYx5T4nI4PlEQY0bTFfB/cds0wo/2eI4pTxvb0GezK4haMsfIrez1pyrqyZXB9Qent0/C7N2ZuWpPHka4cJqu6tO23R8u0x8s7KMSVZOwJSEXqTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYwKSWXlNFeKdyZuU2uBcFCluDhcm7xRHVvXXubPArg=;
 b=cMpABsFI9nOoXfF9mQmzVEPZXmtnKCKq83CyralgXPy58kz/A5r0qXu52L+VopeNdPc9ujzR4g5o7V59VQETtfgkQFzB2kEyOIBQ1v28JBbVTqiOXr0YJaOgwPSh/A+nRx4U0xENLUFJ9K0J3efpWFGcYX3udushzBEkAv8f0lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Mon, 20 Jan
 2025 05:00:20 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8356.014; Mon, 20 Jan 2025
 05:00:20 +0000
Message-ID: <34d30d5d-da9c-46d0-9477-c25dadf06b42@amd.com>
Date: Mon, 20 Jan 2025 10:30:11 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 1/3] perf/x86: Fix low freq setting issue
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com, jolsa@redhat.com, stable@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250117151913.3043942-1-kan.liang@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20250117151913.3043942-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 54da4b9f-c801-43dd-b0eb-08dd390f56d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHFOUTM5VUlWa0FaVGMvZTk5cTN0cmk5a04yaGtEeU5sazFvMFM5OW4yUmhv?=
 =?utf-8?B?NEJEeXd2V0VRTXJjcE91MG5Xa2dKT2NQR0tPclErdjRTdjBJQVZqS0pJdnFw?=
 =?utf-8?B?WGlyL01TaWxJQko2dUk0M21GSjI0YVFyd0xRcVVvK28rOHRwU3BjNW02amVu?=
 =?utf-8?B?UDdBYlZpM0xyTjRjdTQvUWxrSkVTTHJIaDFoWEFnazdaQm9UbG83MTluOEpF?=
 =?utf-8?B?ZXVSV3ovcWhSMDhFWm9yTzJlVXU1RU1vWEtuMDIzMDlRQm9adElkQ2dHU1Rk?=
 =?utf-8?B?M3RCMXoyYlNkWktYRmdMYVcrblRFaXhaemNEZE9TazRPS0Vlby9Fd05CRGh3?=
 =?utf-8?B?VmFNMytIaDNMc2xxNll5UVlXVnZOU2Z0SVk3TEpDVGxDekFpampiS0VmZEpK?=
 =?utf-8?B?WVRSKzE4ZFFCY1NUVXhEUkdpRDBRV2t6WlQ3N0NYMWJpcTFQSk5KTXM5eHA3?=
 =?utf-8?B?L0Z6b09tUzRodk14c0djVXF4U3l5ZXM5L1owQUZ5VEVUYWlNTzhkSnJtZ3V2?=
 =?utf-8?B?RmhCbWtmb3FiYWREak9lZXZ6UHNFRlBxdW9wUG9TVWV3eHBsbDFoMjM0SjhO?=
 =?utf-8?B?TTBEN01jWWhSWlk5UVpocTFwSElna2pxc3pHUHRKUmxpQ1JKamlOQm9pVzVm?=
 =?utf-8?B?dHJNb2pPMUxRV2IzRG9oL1FUUlR5ODhITVc3OEJLK3pvZE92djB4RHBtVEpM?=
 =?utf-8?B?L1Jid3JlK3B5Y3J3QVhXbkE0cm1ZT3hqSXcvTnhzR25STkx4YVFkMkNrTXBD?=
 =?utf-8?B?TXJ5bVp1RlExWXh0cHhNQUJpUmlNcm5DOGpzMko5U2d3VWlmOEVpUStLL043?=
 =?utf-8?B?dmVwMVp4YTBzZzlSUk1PQmloVk5rcUgxVnIwNlMxejlCdWk0d2hPaXkwckU0?=
 =?utf-8?B?c1ZRTmtIb2F3NnpxZnZaWmNyMG90dGY4b0ZJN3V2SDJKR1RpRHdLd2Ewc2lj?=
 =?utf-8?B?a3FjVk5vNkprU1Bad0d5SkZzQkhHbWJKcVFFWXJQY3hXaE9PZkJVWjJDR3lG?=
 =?utf-8?B?YjFoRi9rR2ZlVnM4VjdCVWFZcC9nNDVyMi9CdDAxcEl2Tm1PaDgwUVlzbDZy?=
 =?utf-8?B?Q2ZqUms5K0J1ckNWelJ5NkRNaU45TXM1UWppM3VSUkh4Nm45dXZDcTN1OXBt?=
 =?utf-8?B?S01UUW5IQUgxVWV4dmplNXkydFVISzlMQzVLcUFlbFpWNHJNNVc4ZWtRc0F5?=
 =?utf-8?B?Q2pvMVpyYnRjYjNVTXFqR1E1RHN2dW1tOXY0Q0orOWlNdm0wQ0lOSGlCUUNQ?=
 =?utf-8?B?Rm5DVm5vSGllbytWSS80OVR0V1pHT09nYThwK2QxOW9uK1puRllzaG1MZSt0?=
 =?utf-8?B?N29wOXpSOWUvSHJWb3lBMnRGRjMrMEFlSStyS1MxQmZRdEljWU11WmpoV29P?=
 =?utf-8?B?SDJnK0JFRHkwV3FxOTIzc0xxV1o3ZEh5ZUxDRkJMYXpORTU4OUFqaTFsR1FZ?=
 =?utf-8?B?S0lKZVV1dVFrdVRSUThGb0hkaHRITVREUkpsS0tkVC9neWhZRm1wdTh3YVJY?=
 =?utf-8?B?SlozaWxvNTIvdXJiR2xEdExoeGN1b0tISGlLSmhpenRBRk9mTVlvYXIwWDhE?=
 =?utf-8?B?WFZzclNITWNIUlIyRkRVMHNUTENic040TnNhdWRGOUI1bGc0NytzTU5uL1dv?=
 =?utf-8?B?MUpEN0ZYR2RyRC9iNndQM0d0WUJjNjI1Q0ZVWE9EbnVxQUxRUjlHcWg0WVdr?=
 =?utf-8?B?VG45OGVZWXE0ZndOaDdKdWwzNHZiNUJBT1ZOOTZleU9rbDZEVURMWjFKNFY3?=
 =?utf-8?B?RXFzMlhVelg2a0F6d2RzY21JUEdCMXlqZGIrK1VoWDFOcTFac2N5bnl3RzFm?=
 =?utf-8?B?alVNa0s5TWRMQXNGNHR6Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUJYM2Y3SVdIdzJES3poRmF1Uy9XeURZaVZhcncwdHpIUTA4bjJ5U21WTStx?=
 =?utf-8?B?UldsUjFjUklQTlBoT2JtZEtzUFRiNEJTQ1VtemZwOHphUHk3U015MXUzd3Fx?=
 =?utf-8?B?ZkN6VXdBOHlWK1JDVi9vdHI1Q21RVE5Ib3M3MkJhVVRJbVYyL3F0bFpGc2JH?=
 =?utf-8?B?SUpYQ241UjAyUnJxQ3hqNkJXNElrN0RiNVBvbkZzcmxPWTZFU250WjRqdzhl?=
 =?utf-8?B?WDNlRnpsV09xU2hWNFpNNHZtOU1ORU1iMXJiTWJqaHRpY1BTV1lXK05hVlpw?=
 =?utf-8?B?Z1kvU3BlbUl5bU1MK1lqZlFVVEloUEhZMDJ4UjlsOG1pVTYyMU54ZlBkZjN3?=
 =?utf-8?B?aXhqc2g1eUVGRncrNEJUUXo4cDV3dURqSTZoREY2YnZJdXEzR1AwQXExQy9Z?=
 =?utf-8?B?ZDBEdHVGS0ZxU21JSmZDUTFseDRtVFJFdk8xQTVWTXdNNXlDcU96K0dBdHlS?=
 =?utf-8?B?dTlOdHBoOEFPdUlhdEpFVlE1aUxpenVWZk1oeTVBak9rTVcyRjRKSm9rSjcx?=
 =?utf-8?B?ZnRVaVB4WitScDREU2tqYTM1bXlOdzFJUUJOT0xCTE0ra0RNaWFNcGFoMHdp?=
 =?utf-8?B?Um42eFhBYzcrejF1Qk8rTmlidUV0V0Yxb3NMTTgreEFRNWNLMUFxcUFuM2Fk?=
 =?utf-8?B?NVEwQVh5dTEwRzFhQ2paTGMwVnVOZHZYdVNNUjZUdFF5OStHV09WMFZmMCsz?=
 =?utf-8?B?Z3dsaWZCNjFUeEEva0FFZlZ3VWpydnI2L2N4RVJ2a1hxR2lVRUVlUGpTL1RN?=
 =?utf-8?B?L0tnS3pqNXJRZnBRS0d5b2ZqUCs4RjJvUXZyKzRNRTdmRndsTEJXWWpna1I5?=
 =?utf-8?B?emR4MU1NYWxYMXptbUF5YVBuU1pZN0Y0bGhrMnRwWFZyTzVmQUI1a21oU3pr?=
 =?utf-8?B?bUw2cEVyNzZFNTVjdWxaOHZTaUNlYUtkY0YvcEd2NXkzNVdSUWZZNThjUGV6?=
 =?utf-8?B?VlZrTExuVy9hdGppUHQ3ZVhoNzh3ZWNiRFVyY2N5ZVcrdXdnYllOcnlqM0NF?=
 =?utf-8?B?bXU4QlF3anJiOVRwUWhMOWtKUS9rUXVtYkJhM2FvN0JTUWxqYVVacndhTTR0?=
 =?utf-8?B?UHpESDBBY2RjeUgxemw0MUhTaHUyQklKTHBuaEY1WHQ2SFNlWTRBZVRTR2tv?=
 =?utf-8?B?MW4rd1VZRitqN1JKQUpVa2RyN2drYmtCOUU5Z1c4ZE02QVZXUGg4K1d1ZUFD?=
 =?utf-8?B?RHBnK0d5eGxOdGd5WjkxWElKT1FrOE1zVXRGR3BaOFY3MStHb0FWM1Y4UWZ2?=
 =?utf-8?B?SmRvNHZiR0ZjYTA4NXMxSUs3RTg4eS9LYmxyTnFNNjZqQUhSbWwwWlh5VzlV?=
 =?utf-8?B?bUd5eW9FanltNENOUTZub1NjenN1VzBRcHVvZTIwbG5TcU9ZVXRULzQvU29I?=
 =?utf-8?B?dnozd0VKZGluRkV1RmZVdDM1a2FURU1JNmVub1ZSdUltbWdhbkErLzVnaElp?=
 =?utf-8?B?SU1RWE1tU3pFRWpiZE5jOEVkbnZibjQ1UFQwUkk3SG5FWnFTcXpiQysyRjFn?=
 =?utf-8?B?cmhzcDgraDlodHdZcEtGaTdNQUx1R3loRy9QWlkzSW4raHFVMjlCby95NXFl?=
 =?utf-8?B?ZnVvQmpoQ2xjc1pxbWFDYnhZcWRMb0w2dHNvZHFZRFFaOUE1NElSVUpKNVA2?=
 =?utf-8?B?UlRKNlNPYWpWZjNSVVBLWXlNNzJ6VUpjdkJuSmh4bFNtRVB4aEE0VjRyN1hL?=
 =?utf-8?B?SUVJeXBPaWJ6VjUrV0JUcnJBbnk2RjZZTGF0SXpFYjFyYVZsNEcxbjM1Y1lk?=
 =?utf-8?B?VVp1L0VnKzZWb1IyOUJESWNVc3p6TEpqVnZCRkZoNjVaZVI3cUttcStQMDdJ?=
 =?utf-8?B?dHp1Y3Y4MkwvOVI4bkVGakVueXMycTRZRDhXeGpzamJjK2lBWXR0V3ErZmVa?=
 =?utf-8?B?SlJ6SXFIV0dQVGJHWGZNY0xxSWtxeHFMUzF1NU1XSlUwUGRIVnhyY1ViUlhZ?=
 =?utf-8?B?TE0vd21sNnpyN21Sd2pSMjhxTE5yd1JDNXYwenZoaERyUHFTdzBXcmtBY2ha?=
 =?utf-8?B?dWNCZ1UzNVFKZUhIVXJmRFBWWGJQNjJDcjExV3A0YnJ3UDN1NVlneVdZWS85?=
 =?utf-8?B?cDFYT2UwcXZLVTVKblFKbjNZSnFpY1ExbXRJVlJodm16Vy9zanl4RGhmL2lp?=
 =?utf-8?Q?idf5EArokfVJRQZZJA9a/5El1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54da4b9f-c801-43dd-b0eb-08dd390f56d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 05:00:20.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIkkmNG4UJNPw/P3LS8Rs+cWRGOROBlM6lwdczOM03WUvtWY5bLz63gWLvzqvcuiiJcmSDp50wUGOHdhhLM8yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

On 17-Jan-25 8:49 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Perf doesn't work with a low freq.
> 
> perf record -e cpu_core/instructions/ppp -F 120
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (cpu_core/instructions/ppp).
> "dmesg | grep -i perf" may provide additional information.
> 
> The limit_period() check avoids a low sampling period on a counter. It
> doesn't intend to limit the frequency.
> The check in the x86_pmu_hw_config() should be limited to non-freq mode.
> The attr.sample_period and attr.sample_freq are union. The
> attr.sample_period should not be used to indicate the freq mode.
> 
> Fixes: c46e665f0377 ("perf/x86: Add INST_RETIRED.ALL workarounds")
> Closes: https://lore.kernel.org/lkml/20250115154949.3147-1-ravi.bangoria@amd.com/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi

