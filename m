Return-Path: <stable+bounces-240454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOpKKzXx6WnzogIAu9opvQ
	(envelope-from <stable+bounces-240454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:15:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8CF45070F
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C767F30D7F71
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B443793D5;
	Thu, 23 Apr 2026 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="xP1uLhvr"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021113.outbound.protection.outlook.com [52.101.70.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51231378D8C;
	Thu, 23 Apr 2026 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938847; cv=fail; b=N0DIH5qOMzrG93L+A8QTAjaRXbJVAVRyhJMopxOka2ZjuLgm68ENs8PHBRIRBBubnUTioZ796lARH/6T40ktQK0zU6RttnZS8Rjxvpcb62tAtLwnpJzTAHNgNPyZnPXOv4QJ1YSVtX2RdWqNdoMVrkzeWNmTM8qL50HHuldsnOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938847; c=relaxed/simple;
	bh=Z+rqtzIWxYLcgf/NTlgTkFDdsjuLaWd/6WCwm+SwXOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e4QmxdqXdTGvpcjkw94PyJRIAsJqSJb0ergZfMuhHu42mA0irWYqSP1n24CUv0JGvyXyDUjN4uodK+YtZluAVjFuoqY+ZJhJA3hi+svYhuX9trM3dbVrxr4Qyql+ztstHz3+I7ks9hGROAbBxryg5phJR31GPBdxzKoDv3LQZmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=xP1uLhvr; arc=fail smtp.client-ip=52.101.70.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uy/aWVos+9CQLFzZlhppzOwf8yhPSvdakK8WcaxZoB9+/I0a/76LyWCGKnkexjQjPROY5HWNd1PZYkitsfuCpLdMAO5zdnq+m/jFwHYDNGWyR5zvRlyo2q5gm6hq8U13am/a4WKWnXv/sSUjmVmIJkcymROSrpsntUh2fjdvs99aZX/Mnqh/WnDyXN5n5qgrW8rmzypPOKZdMwHm+KZqfweT4Ng58uFFFu7PFSdoBK1XgB8HRI/16mPk5borQgxtrCdgl65NTakjlw7XnsrgQ4jiAWSuyoW/N8ksSLpt2Ao30u+lx2V1gbkZxNQC/qK3vyiWTENjwfu7FpTSatWG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiaYJRMoZyfwKqBY56sdsW3Bh+SX8CLBhxmyCXJANoU=;
 b=ac8TiUPHD6pzlljAHMKZgfF5pzHoOb7ZW6m0WPKLbpJkAPDeWOa9944dQb8UkfB/F6qgqGrbYHDyaQcWe3eFpIAAJ3bdSeTClGkTivC1s3jPFM1MCTMHz/0reqeEc5816BiTlDFvYFHIM0BH3wS+9KS/JQZKrZLKDxRfQ+MdjW/SP4ywI525czyeFC3rYSJ/av6IEJBYk9y73cOw4xXk/aJf8zGB9Zt3CrH/iohTohNGtCd7SqE2bOUUwRVEc2FV6s2oKTTpqwCPIDnALjGiGXX3nuls/mrMKmMEYiq9+Og6vFIN7DVsn0dy44khQCZhAY+U5k6aMb/l8NyXZ/vUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiaYJRMoZyfwKqBY56sdsW3Bh+SX8CLBhxmyCXJANoU=;
 b=xP1uLhvrf0a51aKEetDn4GS3/TaiiiP0jEPm41+eoNGsoVTnlL6DEgpQJTB07JdHtl1wO319sLUqocSTlNS5t3vLumEbSYntEtzag2UVawoODkHTPOwVkdg7/RlWNWgbEClrBoMrj+kU3pthGd9MYklOiVps9V70C7/D4EDDf7wUS/6U+bagqq++KkPXRHtDd/K9n0ZwYfst7eGhnDGldqpstzgn9eyHXMPCpeT+EJKw7l8ihgsabdoEXie5wck3uqovZ2aaK/PJGKQNPnJS70jnnA3XLOAZ+ydD+UhMuNVifuRUv+UHIvtLNcaCme6rxnm9XQVGtJenW73HfzRmRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by PR3PR08MB5580.eurprd08.prod.outlook.com (2603:10a6:102:8c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 10:07:21 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2%5]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 10:07:21 +0000
Message-ID: <679c54ef-9799-4df8-8555-c4f54922bea9@virtuozzo.com>
Date: Thu, 23 Apr 2026 12:07:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/pid_namespace: compute pid_max test limits
 dynamically
To: Bjoern Doebel <doebel@amazon.com>, linux-kselftest@vger.kernel.org
Cc: brauner@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260421194344.2981537-1-doebel@amazon.com>
 <20260422201151.3830506-1-doebel@amazon.com>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20260422201151.3830506-1-doebel@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::14) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|PR3PR08MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf7e6af-7904-4583-8b35-08dea1201c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	E2+T3Sw26EfWStFqO9LZ+6EmZdK8cJb1yCEWI7D5QdPLvzZmzbKNsHcxPod1WGdFqL/JU8lqZd5djp5lDrM0PTDIdEV3QIRLvGRKd7BJn5K2FhXJYO7tZL+JjfwpkYfPEOtcR9ZOqHrV0GW5wsECdbulx2ZaPs55XzfS6wfWneqEkmi9+WDRdidsBidXz9UuUNSPb5umSfQiiYw8tzD4zR3MsbaWaiUfj1YBpCZYYxnVmRT9PUQrXZwR8+wKUohfbhQLnfCrSpA53aKG7TtmkzmPwpXHAG0OsqVrcVOdV7C0U/8VmUH7uZkQCfhoPEqQ5CWpPo38c65IrZD+2XTIZ/VbAbN0xIs+ermdjwLmH31X1PZY56iLZcjyfyra/wklqfvYMpMs4HfdTiDKLUaHKf+NOap5oo4h6QO6GB9a5BgzJBA2j7GNFnegD5tZtMgLHLD+zVe4kvXdc6BK9xuyyh7MMxkin0xqNf+hnj8JgHIKRDYwaUfio9UPujncFyF+WOQq9TX3Ln8HlUr4d6Wn+rg69siGUAJqZwSn1DMD4UoE6RUEvoq4mjI/hQAqgfi7bk+66RHqGNoarBXY5NdQHFvqU8bgO3iKCFcYsj6ByxW5EdAjI5SQDnajswjMt4wnt3fpzMYs8+S51kafN6TnigIvWBL1+Gj/ADl32i3KLdF7Wi6YEkT2gRx6CvxtoL+W3nwnfKGwoIyv3ngIv0NXYvpb6IaqmQsk82QsGCvbr44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm1pVDB6Ykt0SjNEeVJ6bWFoeXpURVQ2cEVKd3BXVXo1UFErK2s4NFV1RXc1?=
 =?utf-8?B?RE42TkZiNDh0VUFHeVB2QUF5bVdoajNwRnJsa3oxMW5oV1E1MDduUzloTDdj?=
 =?utf-8?B?QWthQmx2b01uUi9hcklPMWV4bmpmd3NHZWRjVHVyVUJ1ckhjQlBzZzlVVDUv?=
 =?utf-8?B?NStzaXlKUEhIeWhncGVBdVg5eEhaOFVyN3dzemw4Vkw3MktIM0tXeGhaWE1P?=
 =?utf-8?B?NzR0Y1FvMVVzQi9OeTJlUFlaTnlSa3RxMkxLdm5FaFhpb1U4b1VDN0dDV2NB?=
 =?utf-8?B?Z1NJV1c1OERhbEFkbVlvMzVIcGxZSDJXMjBZd3hMSUFlTmk2ZnB3NVd0aUll?=
 =?utf-8?B?MEFXVlFKbGhzMzdIZStuQ2tRaHVpOHNGNjBnenJwSTNaUzRKQkZPSU81RGdP?=
 =?utf-8?B?RllQR0hhWnBjcnpyMm1mK2g4am9MTkU1TFlkZXZBU0l2U3JnN0R1V0lpWllm?=
 =?utf-8?B?Qm9JM1RpVXJWNU00SFlrUllmdmZKckRSRVk1T2pVRy9uOGZMZ0g0VUYrK3Jy?=
 =?utf-8?B?WmFQWThPWitHSmV0Z2VjUk0vblZwWnRiTzFPYkpaTHBNVktpVkVWTTN6VTNG?=
 =?utf-8?B?c0ZqUk1lOUhjdExCV0RWVmNIR1hTdzV3aFpSdGxzcm1PemlEM096SU4vdDRT?=
 =?utf-8?B?R0xMUXFpb2xFbG1QNTA0dkZnZG1VS1o2bDhjTlJQY3RaU01tTU5UY05wTGNG?=
 =?utf-8?B?TVhpVnpTNWZEbFZOQXBvb3ovdlM5d2lBUjdCNTlER1BjQU1XSlZ1VVFKM3Vx?=
 =?utf-8?B?WVRaSG15bVhkZ0NMaWNzU0ZNNjhPTVNrV25jcEVZUm9lVDhSbmNGTVNicUxU?=
 =?utf-8?B?WEhZSjh2NExYbU54YmtoQWZQdGZuMWp6SU4yalh4b2hQN1hZMEtjSE1GN3BG?=
 =?utf-8?B?TEppamlQaDFRQkQ3cXhnMmNmZkVwZEFTZUYzb3p5MnRVSjBlbVdMVVJPT21L?=
 =?utf-8?B?MVYycXdKZHBFazRBSkNaUWZab2lPNmpVS292UllQUE1CRXNRZnYzckU3cXY2?=
 =?utf-8?B?M0FFbE9HTVVZNU5rUWdNblViYldsNE9SbXhDc3RZVW9kenhBWnF5VExMSloy?=
 =?utf-8?B?VTBuZzBiREx0QnV0cS8rbzBEZTRFY202T1NiRlEwK2kxdnI5Y1FQU1BpSFJ3?=
 =?utf-8?B?dUordEVodytBYXdHbEtLQUhXZjNzdmtpYVVGS2paRVRZSEhIMEg3UnlnTE1m?=
 =?utf-8?B?bjlZNzFVNTc5OExqQitGcjNBN0M4YWhvKzR5V3FsZ1Vkd0lOV2dxVFcrejNU?=
 =?utf-8?B?Y3gzQmFyUmVXVEljM2Y2ajV6UVBKUlA0M01nK2hSeGd2ay9JcWMrTE05dFdz?=
 =?utf-8?B?VDdMdmdHQlhkVjlaK3BXcEJEclpxK0tLVmVtZk4zQUJYTFhuWlR4YWxqeXMw?=
 =?utf-8?B?RkRtYW5pek5NbUo0ZFIxZnBFVVhXQUZud2hUb3pYVXVxNGxRTmtzNm94RGY4?=
 =?utf-8?B?Q1c2QU94eGZmNnlXMktCQXhGNDYxTXJCR0RSYVlWUFgycTRleVUwdGQ3ZHhr?=
 =?utf-8?B?anY3Y2RGOWV3REY4bi9VU0NxTWo4K0FVU3hmMVpTUkFTZUNBdkc0RGVuY21G?=
 =?utf-8?B?MXZCVnBTRStQOHRqMC8yK0N5cjRsRmk3ajRSSlFBT0Q2VHNnSjk0SWc5ZWZt?=
 =?utf-8?B?VjBrelJycGJRbDBtdTZqaCtBaVMxb0UzdFBhcTlFdllWcjF5MlFqSEZmYy9Y?=
 =?utf-8?B?am1ITkpDQlFydnJvenV3K3I5NUI2WEJORXRHSCtLTFNoUW5jTnFWcUZTOXRs?=
 =?utf-8?B?RS9MNk5nL3ZIbVV0YmI1ZWkyc1VCUmNaZlhmOGdQd0ZhYkE5b2N1QW5yUy96?=
 =?utf-8?B?SDJFZjlHOTNVaVBJSHJjZVNnSDNNOG9LTXlXYWtXY1l1VVVHZ0JIRUIxM2Nj?=
 =?utf-8?B?andPSFhuS2FXQzBWdGpnMmlVcHcydkcySWxFY2k1cm1pWGxJNmgxVGgrNUVH?=
 =?utf-8?B?M240THJLVVpqQWl6MVdZbDU4d2dJQmRnQmIxblowb094RjlWOVZXcnkvVlJl?=
 =?utf-8?B?UWpXNFpKWCsvNzRFR1M2b0FvMDkyMHdxZWoxaDVlVktKWi92VWdvTnh1RC9v?=
 =?utf-8?B?UW9EVGlkaFkvcVBXczcxcjVqSk9vSVJSS05NYlZ1bExnbUdjT2ZhOVYxd2o1?=
 =?utf-8?B?cFIvL2REZ2FQMGo3T24vR2RnZjBlNDF4cDNBN2I4dHpuTjU1eTBoeU5IYVJE?=
 =?utf-8?B?ZWIzemNEaWFTMDRnQVBGbkVXMlJzc0VWNW13MUdrZ01lZTFMNnFBVDR3YnNx?=
 =?utf-8?B?M09PSi9qSi9RWVBrWHo5MnNnU3ZvUFNvZU1yUE8rK0hJc0J2ZUJtNXByaDFW?=
 =?utf-8?B?T1V4VlBMT3BlUXo1S1l1VUN2b0YxY2NFV2xuNjhnMzNhTkxoaGtIbGZPOFhh?=
 =?utf-8?Q?QsUnMZK0AEtyAnIVt5ss+gkJMUkpekfQ15QNI1LU5tR6Y?=
X-MS-Exchange-AntiSpam-MessageData-1: TvB1vUKr1G1Gewn3OPG19YpX0OuKqfAb49A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf7e6af-7904-4583-8b35-08dea1201c05
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:07:21.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5idg8zV8guqAOQWnSo1hogaVftmtl98xKR6wDA60Z2KBTedG9pAXLWc2sO1gf20hIkX0yGsHf/MPKGNYnV2SgWmj95POhaz1yFfqer73Qb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5580
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240454-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptikhomirov@virtuozzo.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid]
X-Rspamd-Queue-Id: 8A8CF45070F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/22/26 22:11, Bjoern Doebel wrote:
> The pid_max kselftest hardcodes pid_max values of 400 and 500, but the
> kernel enforces a minimum of PIDS_PER_CPU_MIN * num_possible_cpus().
> On machines with many possible CPUs (e.g. nr_cpu_ids=128 yields a
> minimum of 1024), writing 400 or 500 to /proc/sys/kernel/pid_max
> returns EINVAL and all three tests fail.
> 
> Compute these limits the same way as the kernel does and set outer_limit
> and inner_limit dynamically based on the result. Original test semantics
> are preserved (outer < inner, nested namespace capped by parent).
> 

Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

> Signed-off-by: Bjoern Doebel <doebel@amazon.com>
> Assisted-by: Kiro:claude-opus-4.6
> ---
> v2:
> - use global outer_limit/inner_limit instead of complicated config
>   struct
> - make use of FIXTURE/TEST_F macros
> - reduce buffer size in write_int_to_fd() to 12
> 
>  .../testing/selftests/pid_namespace/pid_max.c | 156 ++++++++++++++----
>  1 file changed, 124 insertions(+), 32 deletions(-)
> 
...
> @@ -328,17 +405,32 @@ static int pid_max_nested_limit_outer(void *data)
>  	return 0;
>  }
>  
> -TEST(pid_max_simple)
> +FIXTURE(pid_max) {
> +	int dummy;

nit: Having dummy variable here does not seem to be required.

> +};
> +
> +FIXTURE_SETUP(pid_max)
>  {
> -	pid_t pid;
> +	int min = pid_min();
>  
> +	outer_limit = min + 100;
> +	inner_limit = min + 200;
> +}
> +
> +FIXTURE_TEARDOWN(pid_max)
> +{
> +}
> +
> +TEST_F(pid_max, simple)


-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


