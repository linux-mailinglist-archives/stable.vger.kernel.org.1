Return-Path: <stable+bounces-237839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ExTG/Mq3mmSoQkAu9opvQ
	(envelope-from <stable+bounces-237839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:54:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC143F9A61
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7A08301C921
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A384A3E1203;
	Tue, 14 Apr 2026 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vux2Bi7t"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F37260D;
	Tue, 14 Apr 2026 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167647; cv=fail; b=DooHlhLapOvS5N218Kh3MZNtOG7nw9059KILDM3Skl6+G2hd6a70zTJ50vGGcm9DRoglRoHgqxONy1PXCp1C9wqkayVv1G8OrAGi4BKNtJXFzYJ7+h8/CiF0uErl0CiPYWZ9+SY2uJu4O8R8X7pxR8zMKPYAYJ5Kd16dh0qpcJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167647; c=relaxed/simple;
	bh=cpK9gB4Hj/fTjiTghYZAhd6P6JP6DGHZtOsQVBS6KvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i3+Stsmz4R6hoQ30G7k+GWhHqyI2XddTnukQkRoMoGW+5B4N5QlykfRZ+W5eemxo34v3cTCjty8aa9YBMCTIZuboVYraZXr4mffUyAZzcMOlo1xzRo6yeG7b4W7qJ4v6YAwWOFt4ekcOOHqetMxURGCRxgO3BVr2n59BoNNwMSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vux2Bi7t; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ/LCOWb/ZGLLSc+RdFaP8lA6pkxj3P5xOp005CAwF3ZMGcyg2TsrkZkwGkuMXaFEXv9RYGMjofnQyyUL9YotjkldOZLfRas+C9fpOn61NOQ+2OTiy+MEMgUlEjTOvTdSTeJzQ5V+10AVR4K6GRDix47I3wZYXeGGdTyAm/D7sd9OS4M8zY1vLyHa2TqNuFyqJzz93eFR4sk+iwCQ3o6dfPAIezgMq9U7/ekkZl6czEqkYGUTWxNigvUJo/g2/Ufa3e7k0ZLR20c5aPTDmAXFj+mSQZBdg4rqLvYHxrtbm/tjYCwFTqOrMZEtuyYKZOJ4XCDaPKe5H/D+6fLGNXSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rznk6WAlR5MKHfMFl6MbhjoBG5/g8AAcLT+wr4YdvIQ=;
 b=aFQQlqKOuRX+ksXHjvtTYMoKLKyX4Ap4n9l1omDemq+RygbnBPjmaF+BcO21U8MYr4le4GI4hp9tUQPtoFuYNlWan4nlIaSr2EloAfQ/3+ZNgcHuW9eFErAaJBmSNAZF1YCba9w8rHqIMrhBKE2D+nfuganMtElxf69jN2s5mLMzBfrH0qwTtFR7Sz9NOv/+9lMOgL27RGtcGsC2i0A+eShFryRi+nK66DuqFMaU0I75fWEXO01vSEd/xyYkXzs5s7scT0c1lqOJwj5oynDffzPdtPG3sCci2M/H0XrWOzFMR6xxdv7RHlZw+G61ojmUMAq8LRucMvNqCXArqGZ5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rznk6WAlR5MKHfMFl6MbhjoBG5/g8AAcLT+wr4YdvIQ=;
 b=Vux2Bi7tqcJjsoCjJHkUFAERRa/zera9TqLrmW38b6z75UIy8dq2CjqbI4oI2NPxMnPiX/sU+wjh20LrfztuZ/MYMvzsU9xOkzvLu/K2oL6yyq36jIESiK5rj7J7FTn4dmAP+VI/XB/jOx1AaTZ4kxFC66R5Xp4lX1FYkmEfzgrNp1FSWscMmkLAVKKo55RQIShZVPexw3z5jr/Lzn+9FC+aO+4CDvHFr9w9+8NwcL5EUvxqPvru/HVuFt9fDsJrTf0YlMxGJyNqBdCWbAknBkXGPh0tUYLjqEXsn7tBMQ70rZmeSAVD6FcJ5/BInkQKJQ5476EvqHDiSq5V5ygQVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 11:54:03 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:02 +0000
Message-ID: <fbe13ade-d503-454e-973c-68785d8f7baa@nvidia.com>
Date: Tue, 14 Apr 2026 21:53:56 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate_device: fix double unlock
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Sunny Patel <nueralspacetech@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260413211559.20969-1-nueralspacetech@gmail.com>
 <2c0c00aa-7fb2-4d7b-90b3-0309c13468ce@kernel.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <2c0c00aa-7fb2-4d7b-90b3-0309c13468ce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 061048a4-ede2-4957-9f5f-08de9a1c85bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3VQCNAAnaS/dl+z2bbzZTFCHVOgu6YRbdesJc3Mavim7wrGLpUtcsKEYk+CBDCUh8kF2BQCdYzF6mzXNY3MQFetbroe0Hs94T3+EXdExW7h/J3fjkx19acMMh+BxIo2RYes62IRwup8/33J7kY4EoLMZc5XlP6YJwsYAmsURicrCmvA0ADtCB06JL74uXjFRgW9YLsqELik4v8EGqQzUhhyh1C2SCbhlwNYpbaGWsk8bLXis2ue/hNXqyfh6teNIT1dX7ufjpn6Fe7ORH//SvOxFtezzlimRLWPu9ghTgjZW/JCrQshAlO+W1g+sRZSeyog/9S5TfD1BLSZF69x6LHNtCwm6j2UDAOYs+dpHxmnbF0w96U1C4M3409u27otA3VfLCkswapPl39gY2RGOiSfbk4xchbn+HrGnC2k480fiZiZnzQinwNLvhFy+Ew84pD0sXs7egfnzqC0e89yJ1UlOSzCi4BfAhI/5sjZ2gcugbM7baTLQMJTTTngaOzuuj+UkD+zKTjOcbsca8ey+q7ZfLlL5MD6nDXrOU39GYqASBc367LNE7LOJ7cyfCjqOkC4/2thgacJNOJdXtPSwI8xrk8eYna2MQIJeaWgx2nX7Yao7NdKUIp86BjlqGRzmchubo2MlOCH4MGFykdD3ksJ44CHrJbHQboKLCY/nhjT5HxPdYoaZDzlxMI/cLClJmQ0PdQKVoK5cmAclYmFEgGvAcPba4xhgpHc5rQy7hrA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXZCL2FjOXJPQnlLTlM3SERMTHBNaW5RUkZobzJYZXBFS1I5ZGlZalBhNUJM?=
 =?utf-8?B?Kzl6K2F0MG9UblFPdVYvYkRlWFZKbDF3Zlh2SVJueEg0RnRNclR4WUh5aXNT?=
 =?utf-8?B?RnFpSCsyYTBkRWtwSGZQbEEyMWN0YWRvMlhUd2pnZEdqV1kyOVdGQzVyOU42?=
 =?utf-8?B?ZlQwV3lWQkliU09UVkxVS2JGYjN5Vk4xKzVnMXIwbTJUbTNPK1k1aGdscmpC?=
 =?utf-8?B?WTJ1NUtJQzZabE9ZaDhHYzFjQms0R2lOV3VDNGVUSFdQaDdSeUJTL01CZFFa?=
 =?utf-8?B?WFBOR3hENUFjcjN0aUN3RytScy95QytSN04rd0pKRGFzRjhZcjQ1Sm95bFVy?=
 =?utf-8?B?eVZBeDJCQVdnN3lseUZXZ1k4NDZhR1JoYUQzWGtoaXR2bUQ3L2lFb2Q0blU0?=
 =?utf-8?B?NlFUZXJUeXlFRnhhWHAzVURwT3hKWTJpYWgyYkZiSU1NTEpzN0dycnRtQnM0?=
 =?utf-8?B?REtaazlwanJNTFZFVzdqQkxvS1J3dDVHVVFtZFhuUXVJSHZxbzNFaFZONkpU?=
 =?utf-8?B?ZWJUdFYvMjI1emJzN3dBT3M1a043d1hZU3pUWm1WcGNxVXJxaDJTcFo0NXZI?=
 =?utf-8?B?aTVFVnBOa1cvWFJoZ0l4UWNoeWFhU1MxUW1SRzJCRU81Y0pVbzRDRjFVTHFr?=
 =?utf-8?B?QnhIM0lXaXdMS2lzdVE1amN4NktnQTRoUjYycXRISDhhZGc2NytuNTVvbmlV?=
 =?utf-8?B?cmU1ejlZZzlLNWhXd2JGOXE0aHBVMFNhVGxYYWRXeGJyLzFkQWJYZ3ZzTEFa?=
 =?utf-8?B?b1ZHRFFwODlrbHB1emNJSDlTOTJWMHRHa3dLTGVrVzF6M0I4YzRpT29Mdmda?=
 =?utf-8?B?ZnJKN1NGOWFaOWREUHF5LzRDbVovQzloMFllZ2g2ODl5ZW1wSjZlVmxueVdG?=
 =?utf-8?B?MVhrd3ZWbkVoNGg0Q1JWWVl2VHY0QXcwV2hnT0JuSmp6aEcyek5MVE16ZHVx?=
 =?utf-8?B?aC9PZngwaloxUEhjUFpGQkIydTZWcjV1WEoydGFFSzc3TDl5blNaYThKMHRB?=
 =?utf-8?B?czZrNmVYOU1IRExMdHZsSkVjbmZJMWU0U2RHR093ZkhUNGNEQ09rUzlJVk43?=
 =?utf-8?B?UjRjUm9obUhCSXkxUzVsZk9ZcTEwR0JQNTkyczczc3pyVDg2QU5aMGZab3Rn?=
 =?utf-8?B?V0xmajA0UTVmeit5UEVMQ0tLaXZ0UWR1OHZPcDVrb3hkTWVtK1ZsakNFNXpC?=
 =?utf-8?B?VUNOWE1vaThMV0UxblVMN0k5RUREdU1kWjNWem9leFdQc2ZZT0xQWHRYL3gr?=
 =?utf-8?B?OWhoU0RvWW4rTEM2VDlrT2E5SUN3Qk4xYjNZenhjUnQySGhQNFV4dWxJZ0JD?=
 =?utf-8?B?RkJ6K3MxV29pYW93V0U2QkFvUW5iUFc1Z216TUlKYjhaTHlGMlVibmpNZTJ2?=
 =?utf-8?B?ZlZyTm1xbWV6SzFhTzUwYWlJOGFJNnlicHlKRjFrdXpuMzdXR09HMHFsR0xS?=
 =?utf-8?B?ZnNWVWNXbGhPcnY5Rkg2d2FNTlphWjFEajhuS0lDbmpMSmFOdHpUSFdkT0xJ?=
 =?utf-8?B?Z1VvVG84Tm8xUkdxUjVhbG52SmJyR1A2Q1pvUERNYjM2emNVTjJlWENSaTR5?=
 =?utf-8?B?bDlYdFBNcjZHOWRQZFQ5STdpbXBWNmRJdUM5eWtwZ0d6SGVkUElyeXYwOEdl?=
 =?utf-8?B?dThWMnRVN01UNG9LRXZ3QkE0MWNRT1ljVTBzblVIaUNZaW1DaGd4eW9WWmxE?=
 =?utf-8?B?UGZlemlGSWU4RE01ZXpuUU1pWGFHdjlGdDFjN2YwRjlERWVYbE83TTRaYlpw?=
 =?utf-8?B?YmVJQkkvOFc4NlB4U0V2SEE5RE14VUVsK2xsckhSZ3B3b3MwY1d3SFdrMUxi?=
 =?utf-8?B?eHpSRHRkV1B1VUpidWh1dnZscVdiTm1SdzBmZit4b3o3ODZXTHF0dlp4M2Fi?=
 =?utf-8?B?NFNHZkhpU3ppTEp4NDBMLzdPeUUwSUxwSk1hY2QzZGlNVnZLQ3pQUnFmNytv?=
 =?utf-8?B?UWNINHV5eUFQVnA5RXN6UUhvempVc0oxTFBvbUg4QVplall6MVFwUFF5OWtF?=
 =?utf-8?B?TWZzOGZKWGg5VWRTSXhhdCttVFUzaXRHUUVyOWRvcGVFQ2JwbVpybm02M2R3?=
 =?utf-8?B?M0FMVkpUdFpoMVZWOGdyc2dLZlJESmtDbndWQ1Y4cFVmV2VsM1hPOTZwWDVM?=
 =?utf-8?B?alRLektVbTBYQkxOUCtqSkMrN0JhNGE3NlRVVk9rWHhYeXFzcEJKSllPUlRC?=
 =?utf-8?B?UW1WQWJyRWMyc2V6RjViREFkZHNkZllKcjFBYzFkMUlRY25VNVRZZmY0TlNY?=
 =?utf-8?B?V1Z0K2lBaGdYRHRsSWJTQ3hjb1lhdi9neWVZNmFlVzlBd2VjNXFJejhTaHNi?=
 =?utf-8?B?VzVhTGV3ZEhjOWs4d2lXZDN1b1ZDL1BRTFVVWWNsZkwyNnkzb1MzZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061048a4-ede2-4957-9f5f-08de9a1c85bb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:02.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: la+F/HwTU39X5LXzHYR9/iLGlZzCNJ1TU+gDckSRWDIZ+chYtjv49JU8Wdm/O58KKQmfciAlFJof0yC+DY4YcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237839-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,kvack.org,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBC143F9A61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 20:03, David Hildenbrand (Arm) wrote:
> On 4/13/26 23:15, Sunny Patel wrote:
>> migrate_vma_collect_huge_pmd() calls spin_unlock(ptl) after
>> softleaf_entry_wait_on_locked(), which already releases the ptl.
>>
>> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
>>
>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
>> ---
>>  mm/migrate_device.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 8079676c8f1f..7eb2f87ea39d 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -177,7 +177,6 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
>>  
>>  		if (softleaf_is_migration(entry)) {
>>  			softleaf_entry_wait_on_locked(entry, ptl);
>> -			spin_unlock(ptl);
>>  			return -EAGAIN;
>>  		}
>>  
> 
> As raised by Matthew, the entire code block is dead code:
> 
> https://lore.kernel.org/linux-mm/20260212014611.416695-1-dave@stgolabs.net/
> 
> And I even Ack'ed it /facepalm
> 
> So we should take that (cleanup) patch instead. Thanks!
> 

+1

Balbir

